#!/usr/bin/env python3


import sys
import os
import argparse


class Channel:
    def __init__(self, freq=None, sign=None, alpha=None, keep=False, **kwargs):
        super().__init__()
        self.freq = freq
        self.alpha = alpha
        self.sign = sign
        self.kwargs = kwargs
        self.keep = keep


def is_float(test):
    try:
        float(test)
        return True
    except ValueError:
        return False


def parse_channels(path):
    channels = []
    keeping = False
    with open(path) as fp:
        for line in [line.strip() for line in fp.readlines()]:
            if len(line) == 0:
                continue

            if "#keeping" in line:
                keeping = not keeping

            if line[0] == "#":
                continue

            keep = True if "#keep" in line else keeping

            fields = [f.strip() for f in line.strip().split("\t")]

            if len(fields) >= 8 and is_float(fields[0]):
                freq, sign, type, tone, alpha, description, mode, tag = fields
                channels.append(Channel(freq=freq, sign=sign, alpha=alpha, keep=keep))
            elif len(fields) >= 3 and is_float(fields[2]):
                sign, alpha, freq, *others = fields
                channels.append(Channel(freq=freq, sign=sign, alpha=alpha, keep=keep))

    return channels


def main():
    parser = argparse.ArgumentParser(description="baofeng channel csv translator thing")
    parser.add_argument("file", nargs="+", help="file to process")
    args, nargs = parser.parse_known_args()

    channels = parse_channels("channels.txt")
    print(",".join(["Location", "Name", "Frequency"]))
    for i, channel in enumerate([c for c in channels if c.keep]):
        print(",".join([str(i), channel.alpha, channel.freq]))


if __name__ == "__main__":
    main()
