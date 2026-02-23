import subprocess

import qutebrowser.app
import qutebrowser.browser.network.proxy
from PyQt6.QtCore import QEvent, QObject, Qt, QTimer
from PyQt6.QtGui import QCursor, QFont, QFontMetrics
from PyQt6.QtWidgets import QLabel, QVBoxLayout, QWidget
from qutebrowser.config import config as config_mod
from qutebrowser.keyinput import modeman
from qutebrowser.utils import usertypes

EXPANDED_WIDTH = 250


def _color_to_rgba(qcolor, alpha=1.0):
    return f"rgba({qcolor.red()},{qcolor.green()},{qcolor.blue()},{alpha})"


def _get_colors(index, is_selected, is_pinned):
    parity = "odd" if index % 2 == 0 else "even"
    pinned = ".pinned" if is_pinned else ""
    selected = ".selected" if is_selected else ""

    fg = _color_to_rgba(
        config_mod.instance.get(f"colors.tabs{pinned}{selected}.{parity}.fg"), 0.90
    )
    bg = _color_to_rgba(
        config_mod.instance.get(f"colors.tabs{pinned}{selected}.{parity}.bg"), 0.90
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

        self._layout = QVBoxLayout(self)
        self._layout.setContentsMargins(0, 0, 0, 0)
        self._layout.setSpacing(0)

    def refresh_and_show(self):
        while self._layout.count():
            item = self._layout.takeAt(0)
            if item.widget():
                item.widget().deleteLater()

        tb = self.tabbed_browser
        current_idx = tb.widget.currentIndex()
        pad = config_mod.instance.get("tabs.padding")

        for i in range(tb.widget.count()):
            title = tb.widget.tabText(i) or "(untitled)"

            label = QLabel()
            label.setWordWrap(False)

            is_selected = i == current_idx
            is_pinned = tb.widget.widget(i).data.pinned

            font = QFont(label.font())
            font.setBold(is_selected)
            label.setFont(font)

            fm = QFontMetrics(label.font())
            text_width = max(40, EXPANDED_WIDTH - pad.left - pad.right)
            elided = fm.elidedText(title, Qt.TextElideMode.ElideRight, text_width)

            label.setText(elided)
            label.setToolTip(title)

            fg, bg = _get_colors(i, is_selected, is_pinned)

            label.setStyleSheet(
                f"QLabel {{ color: {fg}; background: {bg};"
                f" padding: {pad.top + 1}px {pad.right}px {pad.bottom + 1}px {pad.left}px; }}"
                f"QLabel:hover {{ background: rgba(140,140,140,0.90); }}"
            )
            idx = i
            label.mousePressEvent = lambda e, idx=idx: self._switch_tab(idx)
            self._layout.addWidget(label)

        self._layout.addStretch()
        self.adjustSize()

        bar = tb.widget.tabBar()
        bar_topright = bar.parentWidget().mapTo(
            self.main_window, bar.geometry().topRight()
        )
        self.move(bar_topright.x() + 1, bar_topright.y())
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

        if obj == self._bar:
            if etype == QEvent.Type.Enter:
                self._expand()
            elif etype == QEvent.Type.Leave:
                self._collapse()
            elif etype == QEvent.Type.MouseMove:
                if self._cursor_in_bar():
                    self._expand()
        elif obj == self._panel:
            if etype == QEvent.Type.Enter:
                self._collapse_timer.stop()
            elif etype == QEvent.Type.Leave:
                self._collapse()

        return False


class FullscreenWatcher(QObject):
    def eventFilter(self, obj, event):
        if event.type() == QEvent.Type.WindowStateChange:
            is_fullscreen = obj.windowState() & Qt.WindowState.WindowFullScreen
            config_mod.instance.set_obj(
                "tabs.show", "never" if is_fullscreen else "always"
            )
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
    bar.setMouseTracking(True)
    expander._panel.installEventFilter(expander)
    expander._panel.setMouseTracking(True)

    watcher = FullscreenWatcher(window)
    window.installEventFilter(watcher)


class MyApplication(qutebrowser.app.Application):
    def __init__(self, args):
        super().__init__(args)
        self.new_window.connect(on_new_window)


qutebrowser.app.Application = MyApplication
qutebrowser.browser.network.proxy.init = lambda: None
