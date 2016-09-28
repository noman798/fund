#!/usr/bin/env python
# coding: utf-8
from mako.template import Template
from os import mkdir, chmod
from os.path import join, dirname, exists, abspath
from config import CONFIG
from glob import glob


def make_config(filepath):
    CONFIG_DIR = abspath(join(dirname(filepath), "tmpl"))
    PREFIX = dirname(dirname(dirname(CONFIG_DIR)))
    for path in glob(join(CONFIG_DIR, "**/*.*")):
        path = path[1 + len(CONFIG_DIR):]
        with open(join(CONFIG_DIR, path)) as conf:
            tmpl = conf.read()

        T = Template(
            tmpl,
            # disable_unicode=True,
            encoding_errors='ignore',
            default_filters=['str', 'n'],
            input_encoding='utf-8',
            output_encoding='',
        )

        filepath = join(PREFIX, path)
        dirpath = dirname(filepath)
        if not exists(dirpath):
            mkdir(dirpath)

        print(filepath)
        with open(filepath, 'w') as f:
            f.write(T.render(
                CONFIG=CONFIG,
                PREFIX=PREFIX,
            ))

        if "." not in path or path.endswith(".sh"):
            chmod(filepath, 0o755)


make_config(__file__)
