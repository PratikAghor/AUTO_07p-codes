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

# clean the directory
ac.clean()
