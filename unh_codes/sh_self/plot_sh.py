#! /usr/bin/env python
#############################################
# Add $AUTO_DIR/python to sys.path to import the Python modules defined by AUTO 07p.
import sys
sys.path.append('/home/aghor/auto-07p/python')

try:
    from auto.graphics import grapher_mpl as grapher
except ImportError:
    from auto.graphics import grapher
    print("Using plain TkInter for plotting. You can obtain better quality graphics")
    print("using matplotlib (http://matplotlib.sf.net).")

import matplotlib.pyplot as plt
import auto.graphics
from auto.graphics.plotter import plotter
from auto import parseB
from auto import parseS
from auto import parseC
from auto import AUTOutil
from auto import AUTOCommands as ac
#############################################
# method # 1: using parseB
p_sh1_obj = parseB.parseB(); p_sh11_obj = parseB.parseB();
p_sh12_obj = parseB.parseB(); p_sh13_obj = parseB.parseB();
b_sh1 = open('b.sh1', 'r')
b_sh11 = open('b.sh11', 'r')
b_sh12 = open('b.sh12', 'r')
b_sh13 = open('b.sh13', 'r')


p_sh1_obj.read(b_sh1)
p_sh11_obj.read(b_sh11)
p_sh12_obj.read(b_sh12)
p_sh13_obj.read(b_sh13)
#############################################
fig = plt.figure(0)  # Create a figure instance
ax = fig.gca()  # Get current axes
ax.plot(p_sh1_obj.branches[0]['r'], p_sh1_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
# ax.plot(p_sh11_obj.branches[0]['r'], p_sh11_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
ax.plot(p_sh12_obj.branches[0]['r'], p_sh12_obj.branches[0]['L2-NORM U(1)'], color='b', linewidth=2)
ax.plot(p_sh13_obj.branches[0]['r'], p_sh13_obj.branches[0]['L2-NORM U(1)'], color='b', linewidth=2)
ax.set_xlabel(r'$r$', fontsize=20)  # Set x label
ax.set_ylabel(r'$u$', fontsize=20)  # Set y label
plt.tight_layout()
ax.set_xlim([-0.05, 0.4])
ax.set_ylim([-0.5, 0.75])

fig.savefig('sh.png')
#############################################

fig = plt.figure(0)  # Create a figure instance
ax = fig.gca()  # Get current axes
ax.plot(p_sh1_obj.branches[0]['r'], p_sh1_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
ax.plot(p_sh11_obj.branches[0]['r'], p_sh11_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
ax.plot(p_sh12_obj.branches[0]['r'], p_sh12_obj.branches[0]['L2-NORM U(1)'], color='b', linewidth=2)
ax.plot(p_sh13_obj.branches[0]['r'], p_sh13_obj.branches[0]['L2-NORM U(1)'], color='b', linewidth=2)
ax.set_xlabel(r'$r$', fontsize=20)  # Set x label
ax.set_ylabel(r'$u$', fontsize=20)  # Set y label
plt.tight_layout()
ax.set_xlim([-0.05, 0.4])
ax.set_ylim([-0.5, 0.75])

fig.savefig('sh11.png')

#############################################
# method # 2: using plotter module in auto
# fsh1 = plotter(bifurcation_diagram_filename="b.sh1", stability=True, \
# AUTO_plotter="hide")
# fsh11 = plotter(bifurcation_diagram_filename="b.sh11", stability=True,\
# AUTO_plotter="hide")
#
# grapher.GUIGrapher.generatePostscript(fsh1)
# grapher.GUIGrapher.generatePostscript(fsh11)

#############################################
# method # 3: merging sh1 and sh11
# ac.merge("sh1", "sh11")
# fsh_merged = plotter(bifurcation_diagram_filename="b.sh11", stability=True, \
# AUTO_plotter="hide")
# grapher.GUIGrapher.generatePostscript(fsh_merged)
#############################################
