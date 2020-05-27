#! /usr/bin/env python
#############################################
# Add $AUTO_DIR/python to sys.path to import the Python modules defined by AUTO 07p.
import sys
sys.path.append('/home/aghor/auto-07p/python')

from pylab import *
import auto.graphics
from auto import parseB
#############################################
p_sh_obj = parseB.parseB()
b_sh1 = open('b.sh1', 'r')
b_sh11 = open('b.sh11', 'r')

p_sh_obj.read(b_sh1)
p_sh_obj.read(b_sh11)

print(p_sh_obj.branches[:2])
print(p_sh_obj.branches[0].keys())
#
# print(sh1.branches[0]['L2-NORM U(1)'])
plot(p_sh_obj.branches[0]['PAR(3)'], p_sh_obj.branches[0]['L2-NORM U(1)'])
show()
