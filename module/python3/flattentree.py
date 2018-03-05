#! /usr/bin/env python3
import sys


def format_line(line):
    line = line.replace("\n", "").replace("\xa0", " ")
    indent_level = 0
    for l in line:
        if l == " ":
            indent_level += 1
        else:
            break
    line = line.replace(" ", "")
    return indent_level, line


path = []
pre_indent_level = -1
for line in sys.stdin:
    if not line:
        continue
    indent_level, line = format_line(line)
    if indent_level > pre_indent_level:
        path.append(line)
    elif indent_level == pre_indent_level:
        path = path[:-1] + [line]
    else:
        path = path[:-2] + [line]
    pre_indent_level = indent_level
    print("/".join(path))
