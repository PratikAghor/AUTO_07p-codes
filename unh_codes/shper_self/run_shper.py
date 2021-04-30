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
print("starting run1...")
r1 = ac.run(e='shper', c='shper.1', sv='shper1', runner=runner);

# run11
print("starting run11...")
r1 = r1 + ac.run(r1, e='shper', c='shper.11', sv='shper1', runner=runner);

# # run2
print("starting run2...")
r2 = ac.run(e='shper', c='shper.2', sv='shper2', runner=runner);
#ac.append('shper1')

r = r1 + r2;
ac.save(r, 'sh_shper')
# run3
# print("starting run3...")
# r3 = ac.run(e='shper', c='shper.3', sv='shper3', runner=runner);
# # ac.append('shper')
# # run4
# print("starting run4...")
# r4 = ac.run(e='shper', c='shper.4', sv='shper4', runner=runner);
# # ac.append('shper')
# # run5
# print("starting run5...")
# r5 = ac.run(e='shper', c='shper.5', sv='shper5', runner=runner);
# ac.append('shper')
# clean the directory
ac.clean()
#############################################
