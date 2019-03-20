#! /usr/bin/python

import os, sys

DEBUG = 1

def run(cmd):
    if DEBUG:
        print cmd
    os.system(cmd)

run('cd resolution_cards; python process.py')
run('cd resolution_cards; python process_tall.py')
run('cd resolution_cards; python process_tenstep.py')
run('cd resolution_cards; python process_print_and_play.py')
run('bash bin/build_pdf_guides.sh')
