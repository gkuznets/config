#!/usr/bin/env python

import sys

# foo/bar/baz -> f/b/baz
def collapse(path, lenght_limit):
    length = len(path)
    parts = path.split('/')
    for i in range(len(parts) - 1):
        if len(parts[i]) == 0:
            continue
        length -= (len(parts[i]) - 1)
        parts[i] = parts[i][:1]
        if length < lenght_limit:
            break
    return '/'.join(parts)


if len(sys.argv) < 2:
    sys.exit(0)

path = sys.argv[1]

if len(sys.argv) >= 3:
    length_limit = int(sys.argv[2])

if len(path) >= length_limit:
    path = collapse(path, length_limit)

sys.stdout.write(path)
