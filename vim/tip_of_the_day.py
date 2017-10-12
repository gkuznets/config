#!/usr/bin/env python3

import random
import sys

tips = [
    "Use :A to alternate between *.h[pp] and *.c[pp] files",
    "Use <Leader>cf to format C and C++ code",
    "Use <Leader>> and <Leader>< to move between tabs",
    "Use <Leader>t to open new tab",
    "Use u/U in visual mode to change selected to text to lower/upper case",
    "Use zz to scroll so the current line is in the middle of the screen",
    "Use Ctrl+n to open NERDTree",
    "Use <Leader>ac to add autocorrection",
    "Use zg to add word under the cursor as a good word to the spellfile",
    "Use z= to correct spelling of the word under cursor",
    "Use <Leader>cc/<Leader>c<space> to comment/uncomment code",
    "Use <space>x to toggle [ ] checkbox in org mode",
    "Use <Leader>\" to enquote a word",
    "Use <Leader>C to switch b/w snake_case/lowerCamelCase/UpperCamelCase",
]

sys.stdout.write(random.choice(tips))
