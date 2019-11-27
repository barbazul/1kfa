#! /usr/bin/env python2
# -*- coding: utf-8 -*-


from cards import cards as deck
from random import shuffle

chars = '🂠 🃟 ٭ ■ ⚔♛♞⚒🀆🀫🀰  🀹  🀺   🀻  🀼   🁀  🁁  🁂  🁃  '
anvil = '⚒'
blades = '⚔'
crown = '♛'
dragon = '♞'
cardback = '🂠'
cardup = '🃟'
RED="\033[0;31m"
BLU="\033[0;34m"
BLU1="\033[1;34m"
GRN="\033[0;32m"
GRN1="\033[1;32m"
YEL="\033[0;33m"
YEL1="\033[1;33m"
NOCOLOR="\033[0m"


p1 = {
  'deck': deck,
  'resolving': [],
  'discard': [],
  'exhaustion': [],
  'tokens': []
}

shuffle(p1['deck'])

def flip():
    card = p1['deck'].pop()
    p1['resolving'].append(card)

def discard():
    [p1['discard'].append(card) for card in p1['resolving']]
    p1['resolving'] = []


def red(s):
    return RED + s + NOCOLOR
def green(s):
    return GRN + s + NOCOLOR
def yellow(s):
    return YEL + s + NOCOLOR
def blue(s):
    return BLU + s + NOCOLOR

def face(card):
    a = red('%s %s' % (anvil, card['a']))
    b = blue('%s %s' % (blades, card['b']))
    c = yellow('%s %s' % (crown, card['c']))
    d = green('%s %s' % (dragon, card['d']))
    return ' '.join([a, b, c, d])

def print_state():
  deck = cardback + 'x%s' % len(p1['deck'])
  resolving = ',  '.join([face(card) for card in p1['resolving']])
  discard = cardup + 'x%s' % len(p1['discard'])
  print '| %s | %s | %s |' % (deck, resolving, discard)


flip()
discard()
flip()
flip()
print_state()

