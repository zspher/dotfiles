#!/usr/bin/env python3

# GDbus - no work
# busctl - sadly only option (for now)


import argparse
import subprocess


def init_argparse():
    parser = argparse.ArgumentParser(
        description="brightness control with notifications"
    )
    brightness_slider = parser.add_mutually_exclusive_group()
    brightness_slider.add_argument("-i", "--increase", type=float, dest="brightness_up")
    brightness_slider.add_argument(
        "-d", "--decrease", type=float, dest="brightness_down"
    )
    return parser


parser = init_argparse()
args = parser.parse_args()


def get_brightness() -> int:
    brightness = subprocess.run(
        ["brightnessctl", "i", "-m"], capture_output=True, text=True
    )
    brightness = brightness.stdout.split(",")[3].replace("%", "")
    print(brightness)
    return int(brightness)


def increase_brightness(n: float):
    subprocess.run(["brightnessctl", "s", f"+{n}%"])


def decrease_brightness(n: float):
    subprocess.run(["brightnessctl", "s", f"{n}%-"])


def notify_brightness(brightness: int):
    nf = ["notify-send", "-a", "Brightness", "Brightness"]

    if brightness <= 60:
        nf.extend([f"{brightness}%", "-i", "low-brightness"])
    else:
        nf.extend([f"{brightness}%", "-i", "high-brightness"])

    nf.extend(["-h", f"int:value:{brightness}"])
    nf.extend(["-h", "STRING:x-canonical-private-synchronous:brightness-notification"])
    nf.extend(["-u", "low"])
    subprocess.run(nf)


if args.brightness_up:
    increase_brightness(args.brightness_up)
if args.brightness_down:
    decrease_brightness(args.brightness_down)

notify_brightness(get_brightness())
