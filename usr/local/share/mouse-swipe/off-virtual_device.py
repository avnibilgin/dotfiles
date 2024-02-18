from evdev import InputDevice, UInput, list_devices

def create_virtual_device():
    mouse, keyboard = None, None

    input_devices = [InputDevice(path) for path in list_devices()]

    for input_device in input_devices:
        try:
            keys = input_device.capabilities(verbose=True)[("EV_KEY", 1)]
        except:
            continue

        if ("BTN_RIGHT", 273) in keys:
            mouse = input_device
        
        if ("KEY_LEFTMETA", 125) in keys:
            keyboard = input_device

        if mouse and keyboard:
            break

    if not(mouse):
        raise Exception("No mouses found.")

    if not(keyboard):
        raise Exception("No keyboards found.")

    return UInput.from_device(mouse, keyboard, name="mouse-swipe-virtual-device")

def remove_virtual_device(virtual_device):
    try:
        if virtual_device:
            virtual_device.close()
    except:
        pass
