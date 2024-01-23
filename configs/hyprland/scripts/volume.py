#!/usr/bin/env python3

import argparse
import subprocess

import gi
from gi.repository import GLib, Notify

gi.require_version("Notify", "0.7")


def init_argparse() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="volume control with notify")
    volume_slider = parser.add_mutually_exclusive_group()
    volume_slider.add_argument("--increase", "-i", type=int, dest="vol_up")
    volume_slider.add_argument("--decrease", "-d", type=int, dest="vol_down")
    parser.add_argument("--mute", "-m", action="store_true")
    parser.add_argument(
        "--notification", "-n", action="store_false", help="turn off notifications"
    )
    return parser


parser = init_argparse()
args = parser.parse_args()


def get_volume() -> (int, str):
    volume = subprocess.run(
        ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"], capture_output=True, text=True
    ).stdout.split()
    muted = volume[2] if len(volume) > 2 else None
    volume = float(volume[1]) * 100
    return int(volume), muted


def increase_volume(n: int):
    subprocess.run(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", f"{n}%+"])
    subprocess.run(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "0"])


def decrease_volume(n: int):
    subprocess.run(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", f"{n}%-"])
    subprocess.run(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "0"])


def mute_volume():
    subprocess.run(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])


Notify.init("volume")


def notify_volume(volume: int, message: str = None):
    nf = Notify.Notification.new("Volume")
    if message == "[MUTED]":
        nf.update("Volume", "muted", "audio-volume-muted")
    else:
        if volume <= 10:
            nf.update("Volume", f"{volume}%", "audio-volume-low")
        elif volume <= 80:
            nf.update("Volume", f"{volume}%", "audio-volume-medium")
        else:
            nf.update("Volume", f"{volume}%", "audio-volume-high")
        nf.set_hint("value", GLib.Variant("i", volume))
    nf.set_hint(
        "x-canonical-private-synchronous", GLib.Variant("s", "volume-notification")
    )
    nf.set_urgency(Notify.Urgency.LOW)
    nf.set_timeout(1000)
    nf.show()


if args.vol_up:
    increase_volume(args.vol_up)
if args.vol_down:
    decrease_volume(args.vol_down)
if args.mute:
    mute_volume()

if args.notification:
    notify_volume(*get_volume())
