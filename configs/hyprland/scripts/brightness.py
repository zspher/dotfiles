#!/usr/bin/env python3

# GDbus - no work
# busctl - sadly only option (for now)


import argparse
import subprocess

import gi
from gi.repository import GLib, Notify

gi.require_version("Notify", "0.7")


def init_argparse():
    parser = argparse.ArgumentParser(
        description="brightness control with notifications"
    )
    brightness_slider = parser.add_mutually_exclusive_group()
    brightness_slider.add_argument(
        "-i", "--increase", type=float, dest="brightness_up")
    brightness_slider.add_argument(
        "-d", "--decrease", type=float, dest="brightness_down"
    )
    return parser


parser = init_argparse()
args = parser.parse_args()


def get_brightness() -> int:
    # brightness = subprocess.run(["busctl", "call", "org.clightd.clightd", "/org/clightd/clightd/Backlight2",
    #                             "org.clightd.clightd.Backlight2", "Get"], capture_output=True, text=True)
    # brightness = float(brightness.stdout.split()[3])*100
    brightness = subprocess.run(
        ["brightnessctl", "i", "-m"], capture_output=True, text=True
    )
    brightness = brightness.stdout.split(",")[3].replace("%", "")
    print(brightness)
    return int(brightness)


def increase_brightness(n: float):
    # subprocess.run(["busctl", "call", "org.clightd.clightd", "/org/clightd/clightd/Backlight2",
    #                "org.clightd.clightd.Backlight2", "Raise", "d(du)", f"{n}", "0", "0"])
    subprocess.run(["brightnessctl", "s", f"+{n}%"])


def decrease_brightness(n: float):
    # subprocess.run(["busctl", "call", "org.clightd.clightd", "/org/clightd/clightd/Backlight2",
    #                "org.clightd.clightd.Backlight2", "Lower", "d(du)", f"{n}", "0", "0"])
    subprocess.run(["brightnessctl", "s", f"{n}%-"])


Notify.init("brightness")


def notify_brightness(brightness: int):
    nf = Notify.Notification.new("Brightness")

    if brightness <= 60:
        nf.update("Brightness", f"{brightness}%", "low-brightness")
    else:
        nf.update("Brightness", f"{brightness}%", "high-brightness")
    nf.set_hint("value", GLib.Variant("i", brightness))
    nf.set_hint(
        "x-canonical-private-synchronous", GLib.Variant(
            "s", "brightness-notification")
    )
    nf.set_urgency(Notify.Urgency.LOW)
    nf.set_timeout(1000)
    nf.show()


if args.brightness_up:
    increase_brightness(args.brightness_up)
if args.brightness_down:
    decrease_brightness(args.brightness_down)

notify_brightness(get_brightness())
