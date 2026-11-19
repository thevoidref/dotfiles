#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p "python3.withPackages(p: [p.tomlkit])"
# noctalia-merge.py — fold GUI changes into dotfiles config.toml, then clear them
from collections.abc import Mapping
from pathlib import Path
import tomlkit

CFG = Path.home() / ".dotfiles/.config/noctalia/config.toml"
GUI = Path.home() / ".local/state/noctalia/settings.toml"


def merge(dst, src):
    for k, v in src.items():
        if isinstance(v, Mapping) and isinstance(dst.get(k), Mapping):
            merge(dst[k], v)
        else:
            dst[k] = v


gui = tomlkit.parse(GUI.read_text()) if GUI.exists() else {}
if not gui:
    print("No GUI changes.")
    raise SystemExit

doc = tomlkit.parse(CFG.read_text())
merge(doc, gui)
CFG.write_text(tomlkit.dumps(doc))
GUI.write_text("")
print(f"Merged {', '.join(gui)} into {CFG}")