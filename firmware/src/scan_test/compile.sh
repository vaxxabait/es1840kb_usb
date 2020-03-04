#!/bin/sh

msp430-gcc -Os -mmcu=msp430g2553 -Wall -o scantest.elf main.c