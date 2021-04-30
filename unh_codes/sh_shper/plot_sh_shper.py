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
p_sh1_obj = parseB.parseB(); p_sh11_obj = parseB.parseB();
p_sh12_obj = parseB.parseB(); p_sh13_obj = parseB.parseB();
p_shper1_obj = parseB.parseB(); p_shper2_obj = parseB.parseB()
p_shper11_obj = parseB.parseB(); p_shper12_obj = parseB.parseB();
p_shper13_obj = parseB.parseB();
p_shper21_obj = parseB.parseB(); p_shper22_obj = parseB.parseB();


b_sh1 = open('b.sh1', 'r')
b_sh11 = open('b.sh11', 'r')
b_sh12 = open('b.sh12', 'r')
b_sh13 = open('b.sh13', 'r')
b_shper1 = open('b.shper1', 'r')
b_shper11 = open('b.shper11', 'r')
b_shper12 = open('b.shper12', 'r')
b_shper13 = open('b.shper13', 'r')


b_shper2 = open('b.shper2', 'r')
b_shper21 = open('b.shper21', 'r')
b_shper22 = open('b.shper22', 'r')

# b_sh_shper = open('b.sh_shper', 'r')

p_sh1_obj.read(b_sh1)
p_sh11_obj.read(b_sh11)
p_sh12_obj.read(b_sh12)
p_sh13_obj.read(b_sh13)

p_shper1_obj.read(b_shper1)
p_shper11_obj.read(b_shper11)
p_shper12_obj.read(b_shper12)
p_shper13_obj.read(b_shper13)

p_shper2_obj.read(b_shper2)
p_shper21_obj.read(b_shper21)
p_shper22_obj.read(b_shper22)

# p_sh_shper_obj.read(b_sh_shper)

fig = plt.figure(0)  # Create a figure instance
ax = fig.gca()  # Get current axes
ax.plot(p_sh1_obj.branches[0]['r'], p_sh1_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
ax.plot(p_sh11_obj.branches[0]['r'], p_sh11_obj.branches[0]['L2-NORM U(1)'], color='k', linewidth=2)
ax.plot(p_shper1_obj.branches[0]['r'], p_shper1_obj.branches[0]['L2-NORM U(1)'], color='r', linewidth=2)
ax.plot(p_shper11_obj.branches[0]['r'], p_shper11_obj.branches[0]['L2-NORM U(1)'], color='r', linewidth=2)
ax.plot(p_shper12_obj.branches[0]['r'], p_shper12_obj.branches[0]['L2-NORM U(1)'], color='r', linewidth=2)
ax.plot(p_shper13_obj.branches[0]['r'], p_shper13_obj.branches[0]['L2-NORM U(1)'], color='r', linewidth=2)
ax.plot(p_shper2_obj.branches[0]['r'], p_shper2_obj.branches[0]['L2-NORM U(1)'], color='g', linewidth=2)
ax.plot(p_shper21_obj.branches[0]['r'], p_shper21_obj.branches[0]['L2-NORM U(1)'], color='g', linewidth=2)
ax.plot(p_shper22_obj.branches[0]['r'], p_shper22_obj.branches[0]['L2-NORM U(1)'], color='g', linewidth=2)

ax.set_xlabel(r'$r$', fontsize=20)  # Set x label
ax.set_ylabel(r'$||u||$', fontsize=20)  # Set y label
ax.set_xlim([-0.02, 0])
ax.set_ylim([0, 0.2])

fig.savefig('sh_snaking.png')


#############################################
# method # 3: merging sh1 and sh11
# ac.merge("sh1", "sh11")
# fsh_merged = plotter(bifurcation_diagram_filename="b.sh11", stability=True, \
# AUTO_plotter="hide")
# grapher.GUIGrapher.generatePostscript(fsh_merged)
#############################################
