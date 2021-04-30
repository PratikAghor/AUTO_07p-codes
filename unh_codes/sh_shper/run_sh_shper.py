#! /usr/bin/env python
#############################################
# Add $AUTO_DIR/python to sys.path to import the Python modules defined by AUTO 07p.
import sys
sys.path.append('/home/aghor/auto-07p/python')
from auto import runAUTO as ra
from auto import AUTOCommands as ac
#############################################
runner = ra.runAUTO()
# run1
r1 = ac.run(e='sh', c='sh.1', sv='sh1', runner=runner);

# run11
r11 = r1 + ac.run(r1, e='sh', c='sh.11', sv='sh11', runner=runner);

# run12
r12 = ac.run(r11, e='sh', c='sh.12', sv='sh12', runner=runner);

# run13
r13 = ac.run(r1, e='sh', c='sh.13', sv='sh13', runner=runner);

print("starting shper...")
r2 = ac.run(e='shper', c='shper.1', sv='shper1', runner=runner);

# run21
print("starting shper11...")
r21 = r2 + ac.run(r2, e='shper', c='shper.11', sv='shper11', runner=runner);

print("starting shper12...")
r22 = r21 + ac.run(r21, e='shper', c='shper.12', sv='shper12', runner=runner);

print("starting shper13...")
r23 = r22 + ac.run(r22, e='shper', c='shper.13', sv='shper13', runner=runner);

# run3
print("starting shper2...")
r3 = ac.run(e='shper', c='shper.2', sv='shper2', runner=runner);

#run31
print("starting shper21...")
r3 = r3 + ac.run(r3, e='shper', c='shper.21', sv='shper21', runner=runner);

#run31
print("starting shper22...")
r3 = r3 + ac.run(r3, e='shper', c='shper.22', sv='shper22', runner=runner);

# r = r1 + r2;
# r = r + r3;
#
# ac.save(r, 'sh_shper')

#ac.append('shper1')

# clean the directory
ac.clean()
