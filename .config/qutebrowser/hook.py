import subprocess

import qutebrowser.app
import qutebrowser.browser.network.proxy
from PyQt6.QtCore import QEvent, QObject, QPoint, Qt, QTimer
from PyQt6.QtGui import QCursor, QFontMetrics
from PyQt6.QtWidgets import QLabel, QTabWidget, QWidget
from qutebrowser.config import config as config_mod
from qutebrowser.keyinput import modeman
from qutebrowser.utils import usertypes

EXPANDED_WIDTH = 250


def _color_to_rgba(qcolor, alpha=1.0):
    return f"rgba({qcolor.red()},{qcolor.green()},{qcolor.blue()},{alpha})"


def _get_colors(index, is_selected, is_pinned, alpha=1.0):
    parity = "odd" if index % 2 == 0 else "even"
    pinned = ".pinned" if is_pinned else ""
    selected = ".selected" if is_selected else ""

    fg = _color_to_rgba(
        config_mod.instance.get(f"colors.tabs{pinned}{selected}.{parity}.fg"), alpha
    )
    bg = _color_to_rgba(
        config_mod.instance.get(f"colors.tabs{pinned}{selected}.{parity}.bg"), alpha
    )
    return fg, bg


class FloatingTabPanel(QWidget):
    def __init__(self, tabbed_browser, main_window):
        super().__init__(main_window)
        self.tabbed_browser = tabbed_browser
        self.main_window = main_window

        self.setFixedWidth(EXPANDED_WIDTH)
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground, True)
        self.setAutoFillBackground(False)
        self.hide()

        self._labels = []

    def refresh_and_show(self):
        for label in self._labels:
            label.deleteLater()
        self._labels.clear()

        tb = self.tabbed_browser
        current_idx = tb.widget.currentIndex()
        pad = config_mod.instance.get("tabs.padding")
        bar = tb.widget.tabBar()
        visible_rect = bar.rect()

        origin_y = None
        for i in range(tb.widget.count()):
            tab_rect = bar.tabRect(i)
            if not tab_rect.intersects(visible_rect):
                continue
            if origin_y is None:
                origin_y = tab_rect.top()

            title = tb.widget.tabText(i) or "(untitled)"

            label = QLabel(self)
            label.setWordWrap(False)

            is_selected = i == current_idx
            is_pinned = tb.widget.widget(i).data.pinned

            font = label.font()
            font.setBold(is_selected)
            label.setFont(font)

            fm = QFontMetrics(label.font())
            text_width = max(40, EXPANDED_WIDTH - pad.left - pad.right)
            elided = fm.elidedText(title, Qt.TextElideMode.ElideRight, text_width)

            label.setText(elided)
            label.setToolTip(title)

            fg, bg = _get_colors(i, is_selected, is_pinned, 0.9)

            label.setStyleSheet(
                f"QLabel {{ color: {fg}; background: {bg};"
                f" padding: {pad.top + 1}px {pad.right}px {pad.bottom + 1}px {pad.left}px; }}"
                f"QLabel:hover {{ color: {bg}; background: {fg}; }}"
            )
            label.mousePressEvent = lambda e, idx=i: self._switch_tab(idx)

            label_y = tab_rect.top() - origin_y
            label.setGeometry(0, label_y, EXPANDED_WIDTH, tab_rect.height())
            label.show()
            self._labels.append(label)

        if origin_y is None:
            return

        position = config_mod.instance.get("tabs.position")
        bar_origin = bar.mapTo(self.main_window, QPoint(0, 0))

        if position == QTabWidget.TabPosition.East:
            x = bar_origin.x() - EXPANDED_WIDTH
        else:
            x = bar_origin.x() + bar.width()

        y = bar_origin.y() + (origin_y - visible_rect.top())
        panel_height = visible_rect.bottom() - origin_y + 1

        self.setFixedHeight(panel_height)
        self.move(x, y)
        self.raise_()
        self.show()

    def _switch_tab(self, idx):
        self.tabbed_browser.widget.setCurrentIndex(idx)
        self.hide()


class TabBarHoverExpander(QObject):
    def __init__(self, bar, tabbed_browser, main_window):
        super().__init__(bar)
        self._bar = bar
        self._panel = FloatingTabPanel(tabbed_browser, main_window)

        self._collapse_timer = QTimer(self)
        self._collapse_timer.setSingleShot(True)
        self._collapse_timer.setInterval(50)
        self._collapse_timer.timeout.connect(self._do_collapse)

        tabbed_browser.widget.currentChanged.connect(self._on_tab_changed)

    def _on_tab_changed(self, index):
        if self._panel.isVisible():
            self._panel.refresh_and_show()

    def _expand(self):
        self._collapse_timer.stop()
        if not self._panel.isVisible():
            self._panel.refresh_and_show()

    def _collapse(self):
        self._collapse_timer.start()

    def _do_collapse(self):
        if not self._cursor_in_bar() and not self._cursor_in_panel():
            self._panel.hide()

    def _cursor_in_bar(self):
        pos = self._bar.mapFromGlobal(QCursor.pos())
        return self._bar.rect().contains(pos)

    def _cursor_in_panel(self):
        if not self._panel.isVisible():
            return False
        pos = self._panel.mapFromGlobal(QCursor.pos())
        return self._panel.rect().contains(pos)

    def eventFilter(self, obj, event):
        etype = event.type()

        if etype == QEvent.Type.Enter:
            if obj == self._bar:
                self._expand()
            elif obj == self._panel:
                self._collapse_timer.stop()
        elif etype == QEvent.Type.Leave:
            if obj == self._bar or obj == self._panel:
                self._collapse()

        return False


class FullscreenWatcher(QObject):
    def __init__(self, expander):
        super().__init__(expander)
        self.expander = expander

    def eventFilter(self, obj, event):
        etype = event.type()

        if etype == QEvent.Type.WindowStateChange:
            is_fullscreen = obj.windowState() & Qt.WindowState.WindowFullScreen
            config_mod.instance.set_obj(
                "tabs.show", "never" if is_fullscreen else "always"
            )
            self.expander._collapse_timer.stop()
            self.expander._panel.hide()
        elif etype == QEvent.Type.WindowDeactivate:
            self.expander._collapse_timer.stop()
            self.expander._panel.hide()

        return False


def on_leave_mode(mode):
    if mode in (usertypes.KeyMode.command, usertypes.KeyMode.insert):
        subprocess.run(["fcitx5-remote", "-c"], check=False)


def on_new_window(window):
    mode_manager = modeman.instance(window.win_id)
    mode_manager.left.connect(on_leave_mode)

    tb = window.tabbed_browser
    bar = tb.widget.tabBar()

    expander = TabBarHoverExpander(bar, tb, window)
    bar.installEventFilter(expander)
    expander._panel.installEventFilter(expander)

    watcher = FullscreenWatcher(expander)
    window.installEventFilter(watcher)


class MyApplication(qutebrowser.app.Application):
    def __init__(self, args):
        super().__init__(args)
        self.new_window.connect(on_new_window)


qutebrowser.app.Application = MyApplication
qutebrowser.browser.network.proxy.init = lambda: None
