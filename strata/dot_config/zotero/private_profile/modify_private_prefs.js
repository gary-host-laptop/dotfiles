#!/usr/bin/env python3
import json
import re
import sys
from pathlib import Path

PREF_RE = re.compile(r'^user_pref\("([^"]+)",\s*(.*)\);\s*$')

home = Path.home()
data_dir = str(home / "Zotero")
base_dir = str(home / "strata/30-39_media/31_text/zotero")
dst_dir = str(Path(base_dir) / "articles")

MANAGED = [
    ("extensions.zotero.dataDir", json.dumps(data_dir)),
    ("extensions.zotero.useDataDir", "true"),
    ("extensions.zotero.baseAttachmentPath", json.dumps(base_dir)),
    ("extensions.zotero.saveRelativeAttachmentPath", "true"),
    ("extensions.zotmoov.dst_dir", json.dumps(dst_dir)),
    ("extensions.zotmoov.enable_automove", "true"),
    ("extensions.zotmoov.file_behavior", json.dumps("move")),
    ("extensions.zotmoov.enable_subdir_move", "false"),
    ("extensions.zotmoov.delete_files", "false"),
]
MANAGED_KEYS = {key for key, _ in MANAGED}
MANAGED_VALUES = dict(MANAGED)


def render(key):
    return f'user_pref("{key}", {MANAGED_VALUES[key]});'


def main():
    text = sys.stdin.read()
    newline = "\r\n" if "\r\n" in text else "\n"
    lines = text.splitlines(keepends=True)
    seen = set()
    output = []

    for line in lines:
        body = line.rstrip("\r\n")
        match = PREF_RE.match(body)
        if match and match.group(1) in MANAGED_KEYS:
            key = match.group(1)
            if key in seen:
                continue
            seen.add(key)
            output.append(render(key) + newline)
        else:
            output.append(line)

    for key, _ in MANAGED:
        if key not in seen:
            output.append(render(key) + newline)

    sys.stdout.write("".join(output))
    return 0


if __name__ == "__main__":
    sys.exit(main())
