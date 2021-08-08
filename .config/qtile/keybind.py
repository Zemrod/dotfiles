#!/usr/bin/python

import os

CONF = os.path.expanduser('~/.config/qtile')

def keybinding(mod: str):
    f = open(CONF + "/config.py").readlines()

    for line in f:
        if "Key(" in line:
            if not "keys" in line:
                if not "#" in line:
                    print(line.strip().replace("mod", mod))
                    print()
    input("press eneter to close")

if __name__ == "__main__":
    keybinding("mod4")
