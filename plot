#!/usr/bin/python

from __future__ import division
from numpy import *
import getopt
import matplotlib.pyplot as plt
import subprocess
import sys
import tempfile

# Use quicklook instead of printing to STDOUT
preview = False

try:                                
    opts, args = getopt.getopt(sys.argv[1:], "p")
except getopt.GetoptError:
    print "Unsupported option"
    sys.exit(2)
for opt, arg in opts:
    if opt in ("-p"):
        preview = True

fcns = args[0].split(';')
minx = eval(args[1])
maxx = eval(args[2])
plt.xlim(minx, maxx)
try:
  miny = float(args[3])
  maxy = float(args[4])
  plt.ylim(miny, maxy)
except IndexError:
  pass

x = linspace(minx, maxx, 100)
for i, f in enumerate(fcns):
  y = eval(f)
  plt.plot(x, y, "-", linewidth=2)
plt.minorticks_on()
plt.grid(which='both', color='#aaaaaa')

if (preview):
    with tempfile.NamedTemporaryFile(mode='w', suffix='.png') as f:
        plt.savefig(f.name, format='png')
        subprocess.check_call(['qlmanage', '-p', f.name], stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
else:
    plt.savefig(sys.stdout, format='png')

