#!/usr/bin/python3

#title|secret
#version|0.6-a2
#author|0ero1ne
#info|hide a string into a table of random characters

# TODO
# - need a menu
# - function to decrypt
# EOT

import sys
import math
import random
import string
import datetime

# Set message to argument 1 (just for debug here)
if len(sys.argv) > 1:
    message = sys.argv[1]
else:
    print("Give me a string!")
    exit(0)

# Set the array for the key
key = []

# Set the table
table = []

# The lenght of the crypt table is the lenght
# of the message times a random number between
# 1337 and 6666
t_lenght = len(message)*random.randint(1337,6666)

# Creating the table
for x in range(0,t_lenght):
	table.append(random.choice(string.ascii_letters))

# Creating the last position to start from the iteration
# when inserting the message into the table and into the 
# key
char = int((t_lenght-(int(t_lenght/random.randint(8,12)))))

# Inserting the message in the table and creating the key
for c,y in enumerate(message):
	bit = int(char/int(len(message)-c))
	table[bit] = y
	key.append(bit)

# DEBUGGING OPTIONS
#print(table)
#print("Table len =>",t_lenght)
#print("Key =>",key)
#print("Char =>",char)
#print("Message =>",message)

# Iteration of the key into the table to verify if 
# the crypting was correct
#for obj in key:
#	print(table[obj])

# Creating the file with the table and printing the key
print("\nKey:",key)

filename = "/tmp/"+datetime.datetime.now().strftime("%d%m%y_%H%M%S")+".txt"

with open(filename, 'a') as out:
    out.write(str(table))

print("\nFile:",filename,"\n")
