"""Use the cover art of a different release of the same release group.

Typical use: you tag the Japanese edition because of its bonus track, but want
the US/European cover. Right-click the album -> "Use cover art from another
release…", pick the release, done. The choice is stored per release MBID, so it
survives refreshes and restarts.
"""

import re

from PyQt6 import (
    QtCore,
    QtGui,
    QtWidgets,
)

from picard.coverart.providers.caa import CoverArtProviderCaa
from picard.coverart.providers.provider import CoverArtProvider as _CoverArtProvider
from picard.plugin3.api import (
    Album,
    BaseAction,
    PluginApi,
)


OPTION = 'overrides'  # list of "<album mbid>=<source release mbid>"
PROVIDER_NAME = 'CoverFromRelease'
CAA_URL = 'https://coverartarchive.org'
MB_URL = 'https://musicbrainz.org'
MBID_RE = re.compile(r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}', re.IGNORECASE)


# overrides ------------------------------------------------------------------


def get_overrides(api: PluginApi) -> dict[str, str]:
    result = {}
    for entry in api.plugin_config[OPTION] or []:
        album_id, sep, source_id = entry.partition('=')
        if sep:
            result[album_id] = source_id
    return result


def set_override(api: PluginApi, album_id: str, source_id: str | None):
    overrides = get_overrides(api)
    if source_id and source_id != album_id:
        overrides[album_id] = source_id
    else:
        overrides.pop(album_id, None)
    api.plugin_config[OPTION] = [f'{a}={s}' for a, s in sorted(overrides.items())]


# provider -------------------------------------------------------------------


class CoverFromReleaseProvider(CoverArtProviderCaa):
    """Cover Art Archive provider that reads from the user-chosen release.

    Reuses all CAA options (image types, size, approved only). Must come
    before "Cover Art Archive: Release" in the provider list; once it found a
    front image, the regular CAA provider is skipped.
    """

    NAME = PROVIDER_NAME
    TITLE = 'Cover Art Archive: Chosen Release'
    OPTIONS = None

    @property
    def source_release_id(self) -> str | None:
        return get_overrides(self.api).get(self.metadata['musicbrainz_albumid'])

    def enabled(self):
        if not _CoverArtProvider.enabled(self) or not self.source_release_id:
            return False
        if self.restrict_types and not self.included_types_count:
            return False
        self.api.logger.debug(
            'Using cover art of release %s for %s', self.source_release_id, self.metadata['musicbrainz_albumid']
        )
        return True

    @property
    def _caa_path(self):
        return f'/release/{self.source_release_id}/'


def ensure_provider_first(api: PluginApi):
    """Put our provider in front of all others the first time we see it.

    Afterwards the user's order/enabled state in Options -> Cover Art is kept.
    """
    providers = list(api.global_config.setting['ca_providers'])
    if any(name == PROVIDER_NAME for name, _enabled in providers):
        return
    api.global_config.setting['ca_providers'] = [(PROVIDER_NAME, True), *providers]
    api.logger.info('Added cover art provider %s in first position', PROVIDER_NAME)


# dialog ---------------------------------------------------------------------


def _release_row(release: dict) -> list[str]:
    countries = []
    for event in release.get('release-events') or []:
        area = event.get('area') or {}
        codes = area.get('iso-3166-1-codes') or []
        countries.append(codes[0] if codes else area.get('name', '?'))
    media = release.get('media') or []
    formats = []
    for medium in media:
        fmt = medium.get('format') or '?'
        if fmt not in formats:
            formats.append(fmt)
    if len(media) > 1:
        formats.insert(0, f'{len(media)}×')
    labels = release.get('label-info') or []
    return [
        ', '.join(countries) or release.get('country') or '',
        release.get('date', ''),
        ' '.join(formats),
        str(sum(m.get('track-count', 0) for m in media)),
        ', '.join(dict.fromkeys((li.get('label') or {}).get('name', '') for li in labels)),
        ', '.join(dict.fromkeys(li.get('catalog-number') or '' for li in labels)),
        release.get('barcode') or '',
        release.get('title', ''),
        release.get('disambiguation', ''),
    ]


COLUMNS = ['Country', 'Date', 'Format', 'Tracks', 'Label', 'Cat. No.', 'Barcode', 'Title', 'Comment']
PREVIEW_SIZE = 250


class ChooseReleaseDialog(QtWidgets.QDialog):
    def __init__(self, api: PluginApi, album: Album, current_override: str | None, parent=None):
        super().__init__(parent)
        self.api = api
        self.album_id = album.metadata['musicbrainz_albumid']
        self.releasegroup_id = album.metadata['musicbrainz_releasegroupid']
        self.current_override = current_override
        self.selected_release_id: str | None = None
        self.reset = False
        self._pixmaps: dict[str, QtGui.QPixmap | None] = {}
        self._preview_id: str | None = None
        self._closed = False

        self.setWindowTitle(f'Cover art for “{album.metadata["album"]}”')
        self.resize(1100, 450)

        self.tree = QtWidgets.QTreeWidget()
        self.tree.setHeaderLabels(COLUMNS)
        self.tree.setRootIsDecorated(False)
        self.tree.setAlternatingRowColors(True)
        self.tree.setSortingEnabled(True)
        self.tree.currentItemChanged.connect(self._on_current_changed)
        self.tree.itemDoubleClicked.connect(lambda *_: self._accept_selected())

        self.preview = QtWidgets.QLabel()
        self.preview.setFixedSize(PREVIEW_SIZE, PREVIEW_SIZE)
        self.preview.setAlignment(QtCore.Qt.AlignmentFlag.AlignCenter)
        self.preview.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.preview.setWordWrap(True)

        self.status = QtWidgets.QLabel('Loading releases…')

        self.manual = QtWidgets.QLineEdit()
        self.manual.setPlaceholderText('…or paste a release URL / MBID')
        self.manual.textChanged.connect(self._on_manual_changed)

        buttons = QtWidgets.QDialogButtonBox()
        self.ok_button = buttons.addButton('Use this cover', QtWidgets.QDialogButtonBox.ButtonRole.AcceptRole)
        self.ok_button.setEnabled(False)
        reset_button = buttons.addButton("Use release's own cover", QtWidgets.QDialogButtonBox.ButtonRole.ResetRole)
        reset_button.setEnabled(bool(current_override))
        buttons.addButton(QtWidgets.QDialogButtonBox.StandardButton.Cancel)
        self.ok_button.clicked.connect(self._accept_selected)
        reset_button.clicked.connect(self._reset)
        buttons.rejected.connect(self.reject)

        top = QtWidgets.QHBoxLayout()
        top.addWidget(self.tree, 1)
        top.addWidget(self.preview, 0, QtCore.Qt.AlignmentFlag.AlignTop)
        layout = QtWidgets.QVBoxLayout(self)
        layout.addLayout(top, 1)
        layout.addWidget(self.status)
        layout.addWidget(self.manual)
        layout.addWidget(buttons)

        if self.releasegroup_id:
            self._browse(0)
        else:
            self.status.setText('No release group known; paste a release URL or MBID.')

    def done(self, result):
        self._closed = True
        super().done(result)

    # releases ---------------------------------------------------------------

    def _browse(self, offset: int):
        self.api.mb_api.browse_releases(
            self._releases_loaded,
            **{'release-group': self.releasegroup_id, 'limit': '100', 'offset': str(offset)},
        )

    def _releases_loaded(self, document, http, error):
        if self._closed:
            return
        if error:
            self.status.setText(f'Could not load releases: {http.errorString()}')
            return
        releases = document.get('releases') or []
        for release in releases:
            self._add_release(release)
        loaded = document.get('release-offset', 0) + len(releases)
        total = document.get('release-count', loaded)
        if releases and loaded < total:
            self._browse(loaded)
            return
        self.tree.sortByColumn(1, QtCore.Qt.SortOrder.AscendingOrder)
        for column in range(len(COLUMNS)):
            self.tree.resizeColumnToContents(column)
        self.status.setText(
            f'{total} releases in this release group. '
            'Greyed-out releases have no front cover in the Cover Art Archive.'
        )
        current = self._find_item(self.current_override) or self._first_selectable()
        if current:
            self.tree.setCurrentItem(current)

    def _add_release(self, release: dict):
        item = QtWidgets.QTreeWidgetItem(_release_row(release))
        release_id = release['id']
        item.setData(0, QtCore.Qt.ItemDataRole.UserRole, release_id)
        item.setToolTip(0, f'{MB_URL}/release/{release_id}')
        has_front = (release.get('cover-art-archive') or {}).get('front', False)
        if not has_front:
            item.setFlags(item.flags() & ~QtCore.Qt.ItemFlag.ItemIsEnabled & ~QtCore.Qt.ItemFlag.ItemIsSelectable)
        if release_id == self.album_id or release_id == self.current_override:
            font = item.font(0)
            font.setBold(True)
            note = '(this release)' if release_id == self.album_id else '(current cover)'
            for column in range(len(COLUMNS)):
                item.setFont(column, font)
            item.setText(8, f'{item.text(8)} {note}'.strip())
        self.tree.addTopLevelItem(item)

    def _items(self):
        return (self.tree.topLevelItem(i) for i in range(self.tree.topLevelItemCount()))

    def _find_item(self, release_id):
        return next((i for i in self._items() if i.data(0, QtCore.Qt.ItemDataRole.UserRole) == release_id), None)

    def _first_selectable(self):
        return next(
            (
                i
                for i in self._items()
                if i.flags() & QtCore.Qt.ItemFlag.ItemIsEnabled
                and i.data(0, QtCore.Qt.ItemDataRole.UserRole) != self.album_id
            ),
            None,
        )

    # selection --------------------------------------------------------------

    def _on_current_changed(self, current, _previous):
        if current is None:
            return
        if self.manual.text():
            self.manual.blockSignals(True)
            self.manual.clear()
            self.manual.blockSignals(False)
        self._select(current.data(0, QtCore.Qt.ItemDataRole.UserRole))

    def _on_manual_changed(self, text):
        match = MBID_RE.search(text)
        if match:
            self.tree.blockSignals(True)
            self.tree.setCurrentItem(None)
            self.tree.blockSignals(False)
            self._select(match.group(0).lower())
        else:
            self._select(None)

    def _select(self, release_id: str | None):
        self.selected_release_id = release_id
        self.ok_button.setEnabled(release_id is not None)
        self._show_preview(release_id)

    def _accept_selected(self):
        if self.selected_release_id:
            self.accept()

    def _reset(self):
        self.reset = True
        self.accept()

    # preview ----------------------------------------------------------------

    def _show_preview(self, release_id: str | None):
        self._preview_id = release_id
        if release_id is None:
            self.preview.clear()
            return
        if release_id in self._pixmaps:
            self._set_preview(self._pixmaps[release_id])
            return
        self.preview.setText('Loading…')
        self.api.web_service.download_url(
            url=QtCore.QUrl(f'{CAA_URL}/release/{release_id}/front-{PREVIEW_SIZE}'),
            handler=lambda data, http, error: self._preview_loaded(release_id, data, error),
            priority=True,
            important=False,
        )

    def _preview_loaded(self, release_id, data, error):
        if self._closed:
            return
        pixmap = None
        if not error:
            pixmap = QtGui.QPixmap()
            if not pixmap.loadFromData(data):
                pixmap = None
        self._pixmaps[release_id] = pixmap
        if release_id == self._preview_id:
            self._set_preview(pixmap)

    def _set_preview(self, pixmap: QtGui.QPixmap | None):
        if pixmap is None:
            self.preview.setText('No front cover in the Cover Art Archive')
        else:
            self.preview.setPixmap(
                pixmap.scaled(
                    PREVIEW_SIZE,
                    PREVIEW_SIZE,
                    QtCore.Qt.AspectRatioMode.KeepAspectRatio,
                    QtCore.Qt.TransformationMode.SmoothTransformation,
                )
            )


# action ---------------------------------------------------------------------


class CoverFromReleaseAction(BaseAction):
    TITLE = 'Use cover art from another release…'

    def callback(self, objs):
        albums = [o for o in objs if isinstance(o, Album) and o.loaded and o.metadata['musicbrainz_albumid']]
        for album in albums:
            album_id = album.metadata['musicbrainz_albumid']
            current = get_overrides(self.api).get(album_id)
            dialog = ChooseReleaseDialog(self.api, album, current, parent=self.tagger.window)
            if dialog.exec() != QtWidgets.QDialog.DialogCode.Accepted:
                continue
            source_id = None if dialog.reset else dialog.selected_release_id
            if source_id == current:
                continue
            set_override(self.api, album_id, source_id)
            self.api.logger.info('Cover art for %s now taken from %s', album_id, source_id or 'itself')
            self.tagger.refresh([album])


def enable(api: PluginApi):
    api.plugin_config.register_option(OPTION, [])
    api.register_cover_art_provider(CoverFromReleaseProvider)
    api.register_album_action(CoverFromReleaseAction)
    ensure_provider_first(api)
