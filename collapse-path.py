#!/usr/bin/env python3

import sys


def collapse_part(part):
    if part.find("-"):
        return "-".join(p[0] for p in part.split("-"))
    return part[0]


# foo/bar/baz -> f/b/baz
# boo/bar-zip/baz -> f/b-z/b
def collapse(path, lenght_limit):
    length = len(path)
    parts = path.split('/')
    for i in range(len(parts) - 1):
        if len(parts[i]) == 0:
            continue
        collapsed_part = collapse_part(parts[i])
        length -= (len(parts[i]) - len(collapsed_part))
        parts[i] = collapsed_part
        if length < lenght_limit:
            break
    return '/'.join(parts)


if len(sys.argv) < 2:
    sys.exit(0)

path = ' '.join(sys.argv[1:-1])

if len(sys.argv) >= 3:
    length_limit = int(sys.argv[-1])

if len(path) >= length_limit:
    path = collapse(path, length_limit)

sys.stdout.write(path)
