import os

from qutebrowser.api import interceptor

def on_request(info: interceptor.Request):
    if info.resource_type == interceptor.ResourceType.main_frame:
        os.system("fcitx5-remote -c")


interceptor.register(on_request)
