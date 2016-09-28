#!/usr/bin/env python
# coding: utf-8
from mako.template import Template
from os import mkdir, chmod
from os.path import join, dirname, exists, abspath
from config import CONFIG
from config_mapping import MAPPING


def make_config(filepath):
    CONFIG_DIR = abspath(join(dirname(filepath), "mako"))
    PREFIX = dirname(dirname(dirname(CONFIG_DIR)))
    for name, outdir in MAPPING:
        with open(join(CONFIG_DIR, name)) as conf:
            tmpl = conf.read()

        T = Template(tmpl,
                     # disable_unicode=True,
                     encoding_errors='ignore',
                     default_filters=['str', 'n'],
                     input_encoding='utf-8',
                     output_encoding='',
                     )

        dirpath = join(PREFIX, outdir)
        if not exists(dirpath):
            mkdir(dirpath)
        filepath = join(dirpath, name)

        print(filepath)
        with open(filepath, 'w') as f:
            f.write(T.render(
                CONFIG=CONFIG,
                PREFIX=PREFIX,
            ))


        if "." not in name or name.endswith(".sh"):
            chmod(filepath, 0o755)


make_config(__file__)
