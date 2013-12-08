#! /usr/bin/env python
#-*- coding: utf-8 -*-

import re
import os
import sys


def read_file(name):

    return open(name, 'r').read()


def write_file(name, content):
    try:
        f = open(name, 'w')
        f.write(content)
        f.close()
        return True
    except:
        return False

help_message = """
usage: ovpn2tblk [myprofile.ovpn]
"""

try:
    m = re.search('(.+)\.ovpn', sys.argv[1])
    directory = m.group(1)
    os.makedirs(directory)

    f = read_file(sys.argv[1])

    # Saves the ca.crt file
    m = re.search('(<ca>.+</ca>)', f, re.DOTALL)
    write_file(directory + "/ca.crt", m.group(1))

    # Saves the client.crt file
    m = re.search('(<cert>.+</cert>)', f, re.DOTALL)
    write_file(directory + "/client.crt", m.group(1))

    # Saves the client.key file
    m = re.search('(<key>.+</key>)', f, re.DOTALL)
    write_file(directory + "/client.key", m.group(1))

    f = re.sub('(<ca>.+</ca>)', 'ca ca.crt', f, flags=re.DOTALL)
    f = re.sub('(<cert>.+</cert>)', 'cert client.crt', f, flags=re.DOTALL)
    f = re.sub('(<key>.+</key>)', 'key client.key', f, flags=re.DOTALL)

    write_file(directory + "/" + sys.argv[1], f)
    os.rename(directory, directory + '.tblk')
except:
    print help_message
