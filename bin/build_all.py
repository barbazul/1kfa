#! /usr/bin/python

import os, sys

DEBUG = 1

def run(cmd):
    if DEBUG:
        print cmd
    os.system(cmd)

run('python resoultion_cards/process.py')
run('python resoultion_cards/process_tall.py')
run('python resoultion_cards/process_tenstep.py')
run('python resoultion_cards/process_print_and_play.py')
run('bash bin/build_pdf_guides.sh')