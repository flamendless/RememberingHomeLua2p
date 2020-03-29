#!/usr/bin/python3
import argparse
import sys
import xml.etree.ElementTree as ET

# In general the attributes I copy are not the ones that BMFont allows, but the ones that löve will read:
# https://github.com/love2d/love/blob/fc4847c69d6c9ad7ed84501197427b23400ae1b4/src/modules/font/BMFontRasterizer.cpp

# That means in general this script might generate files that might not be fully compliant BMFont files
# but they should work with löve


def attr_str(key, value):
    if value.isdigit() or (value[0] == "-" and value[1:].isdigit()):
        return "{}={}".format(key, value)
    else:
        return '{}="{}"'.format(key, value)


def join_attrs(attrs, whiteList):
    return " ".join(
        attr_str(key, value) for (key, value) in attrs.items() if key in whiteList
    )


def write_info(f, info):
    f.write("info {}\n".format(join_attrs(info.attrib, ["size", "unicode"])))


def write_common(f, common):
    f.write("common {}\n".format(join_attrs(common.attrib, ["lineHeight", "base"])))


def write_pages(f, pages):
    for page in pages:
        f.write("page {}\n".format(join_attrs(page.attrib, ["id", "file"])))


def write_chars(f, chars):
    # löve does not care about this, but I feel like I want to include it
    f.write("chars {}\n".format(join_attrs(chars.attrib, ["count"])))

    for char in chars:
        f.write(
            "char {}\n".format(
                join_attrs(
                    char.attrib,
                    [
                        "id",
                        "x",
                        "y",
                        "page",
                        "width",
                        "height",
                        "xoffset",
                        "yoffset",
                        "xadvance",
                    ],
                )
            )
        )


def write_kernings(f, kernings):
    # löve does not care about this either
    f.write("kernings {}\n".format(join_attrs(kernings.attrib, ["count"])))

    for kerning in kernings:
        f.write(
            "kerning {}\n".format(
                join_attrs(kerning.attrib, ["first", "second", "amount"])
            )
        )


def writeTree(f, tree):
    ignored_tags = ["distanceField"]
    for child in tree.getroot():
        if child.tag == "info":
            write_info(f, child)
        elif child.tag == "common":
            write_common(f, child)
        elif child.tag == "pages":
            write_pages(f, child)
        elif child.tag == "chars":
            write_chars(f, child)
        elif child.tag == "kernings":
            write_kernings(f, child)
        elif child.tag in ignored_tags:
            pass
        else:
            sys.exit("Unknown tag '{}'".format(child.tag))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("infile")
    parser.add_argument("outfile", help="'-' for stdout")
    args = parser.parse_args()

    tree = ET.parse(args.infile)
    if args.outfile == "-":
        writeTree(sys.stdout, tree)
    else:
        with open(args.outfile, "w") as f:
            writeTree(f, tree)


if __name__ == "__main__":
    main()
