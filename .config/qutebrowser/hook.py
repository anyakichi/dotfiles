import os

import qutebrowser.app
from qutebrowser.keyinput import modeman
from qutebrowser.utils import usertypes


def on_leave_mode(mode):
    if mode in (usertypes.KeyMode.command, usertypes.KeyMode.insert):
        os.system("fcitx5-remote -c")


def on_new_window(window):
    mode_manager = modeman.instance(window.win_id)
    mode_manager.left.connect(on_leave_mode)


class MyApplication(qutebrowser.app.Application):
    def __init__(self, args):
        super().__init__(args)
        self.new_window.connect(on_new_window)


qutebrowser.app.Application = MyApplication
