import configparser
import logging
from swipe_button import SwipeButton

from gesture import Gesture
from direction_parser import parse_directions

def _get_array(string):
    if string:
        return list(map(str.strip, string.split('+')))
    else:
        return []

special_config_keys = ['scroll', 'click', 'freeze']

def parse_config(config):
    swipe_buttons = []

    for button in config.sections():
        if not(button.startswith("BTN_")):
            continue

        # collect all keys that aren't used for other reasons and try to parse them as gestures
        possible_gestures = [item for item in config[button] if item not in special_config_keys]
        gestures = []
        for key in possible_gestures:
            try:
                swipes = parse_directions(key)
                keys = _get_array(config[button].get(key))
                gestures.append(Gesture(swipes, keys))
            except:
                print("Failed to parse '{}'".format(key))

        click = _get_array(config[button].get("click"))
        freeze = config[button].getboolean("freeze", False)
        scroll = config[button].getboolean("scroll", False)

        swipe_button = SwipeButton(button, [] if scroll else gestures)

        swipe_button.click = click if (len(click) > 0) else [button]
        swipe_button.freeze = freeze
        swipe_button.scroll = scroll

        swipe_buttons.append(swipe_button)

    return swipe_buttons


