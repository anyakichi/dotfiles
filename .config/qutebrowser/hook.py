import os

import qutebrowser.app
import qutebrowser.browser.network.proxy
from PyQt6.QtCore import QEvent, QObject, Qt
from qutebrowser.keyinput import modeman
from qutebrowser.utils import usertypes

EXPANDED_WIDTH = "15%"
COLLAPSED_WIDTH = 30


def _set_config(key, value):
    try:
        from qutebrowser.config import config as config_mod

        config_mod.instance.set_obj(key, value)
    except Exception:
        pass


class TabBarHoverExpander(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.enabled = True

    def eventFilter(self, obj, event):
        if not self.enabled:
            return False
        etype = event.type()
        if etype == QEvent.Type.Enter:
            _set_config("tabs.width", EXPANDED_WIDTH)
        elif etype == QEvent.Type.Leave:
            _set_config("tabs.width", COLLAPSED_WIDTH)
        return False


class FullscreenWatcher(QObject):
    def __init__(self, hover_expander, parent=None):
        super().__init__(parent)
        self.hover_expander = hover_expander

    def eventFilter(self, obj, event):
        if event.type() == QEvent.Type.WindowStateChange:
            is_fullscreen = obj.windowState() & Qt.WindowState.WindowFullScreen
            if is_fullscreen:
                self.hover_expander.enabled = False
                _set_config("tabs.show", "never")
            else:
                self.hover_expander.enabled = True
                _set_config("tabs.show", "always")
                _set_config("tabs.width", COLLAPSED_WIDTH)
        return False


def on_leave_mode(mode):
    if mode in (usertypes.KeyMode.command, usertypes.KeyMode.insert):
        os.system("fcitx5-remote -c")


def on_new_window(window):
    mode_manager = modeman.instance(window.win_id)
    mode_manager.left.connect(on_leave_mode)

    try:
        bar = window.tabbed_browser.widget.tabBar()
        expander = TabBarHoverExpander(bar)
        bar.installEventFilter(expander)
        bar.setMouseTracking(True)

        watcher = FullscreenWatcher(expander, window)
        window.installEventFilter(watcher)
    except Exception:
        pass


class MyApplication(qutebrowser.app.Application):
    def __init__(self, args):
        super().__init__(args)
        self.new_window.connect(on_new_window)


qutebrowser.app.Application = MyApplication
qutebrowser.browser.network.proxy.init = lambda: None
