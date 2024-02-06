import configparser
from swipe_button import SwipeButton

def _get_array(string):
    if string:
        return list(map(str.strip, string.split('+')))
    else:
        return []

def read_config_file():
    swipe_buttons = []

    config = configparser.ConfigParser()
    config.read("/etc/mouse-swipe.conf")

    for button in config.sections():
        if not(button.startswith("BTN_")):
            continue

        swipe_button = SwipeButton(button)
        click = _get_array(config[button].get("click"))
        swipe_button.click = click if (len(click) > 0) else [button]
        swipe_button.freeze = config[button].getboolean("freeze", False)
        swipe_button.scroll = config[button].getboolean("scroll", False)
        if not(swipe_button.scroll):
            swipe_button.swipe_left = _get_array(config[button].get("swipe_left"))
            swipe_button.swipe_right = _get_array(config[button].get("swipe_right"))
            swipe_button.swipe_up = _get_array(config[button].get("swipe_up"))
            swipe_button.swipe_down = _get_array(config[button].get("swipe_down"))

        swipe_buttons.append(swipe_button)

    return swipe_buttons


