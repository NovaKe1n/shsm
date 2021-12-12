#!/usr/bin/python3

#title|str2rev
#version|1.0
#author|0ero1ne
#info|print a given string forward, backward, mirror and rhombus

import sys
import argparse

parser = ['-f','-b','-m','-r']

def forward(s):
	for x,c in enumerate(s):
		#print " "*len(s)+s[:c+1]
		print(s[:x+1])


def backward(s):
	for x in range(len(s), 0, -1):
		#print " "*len(s)+s[:x]
		print(s[:x])

def mirror(s):
	for x,c in enumerate(s):
		#print " "*len(s)+s[:c+1]
		print(s[:x+1])
	for x in range(len(s)-1, 0, -1):
		#print " "*len(s)+s[:x]
		print(s[:x])

def rhombus(s):
	for c,x in enumerate(s):
		print(" "*(len(s)-c)+s[c::-1]+s[1:c+1])

	for x in range(len(s)-2, -1, -1):
		print(" "*(len(s)-x)+s[x::-1]+s[1:x+1])

def main():
	if ( (len(sys.argv) > 2) and (sys.argv[1] in parser) ):
		if sys.argv[1] == '-f': forward(sys.argv[2])
		if sys.argv[1] == '-b': backward(sys.argv[2])
		if sys.argv[1] == '-m': mirror(sys.argv[2])
		if sys.argv[1] == '-r': rhombus(sys.argv[2])
	else:
		print("Usage: "+sys.argv[0].split('/')[-1]+" [-f (forward)] [-b (backward)] [-m (mirror)] [-r (rhombus)] [STRING]")

main()
