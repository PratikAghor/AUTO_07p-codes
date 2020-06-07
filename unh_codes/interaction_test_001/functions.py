#! /usr/bin/env python
"""
Given localized solution(s) in 1d, play around
Currently specific for localized solutions of 1d Swift-Hohenberg eqn

the provided input files should be in the form readable by AUTO-07p
In this case, the files will contain 5 columns, x, u0, u1, u2, u3
where, u0 = u, u1 = ux, u2 = uxx, u3 = uxxx

Author: Pratik Aghor
"""
############################
import numpy as np
from numpy import *
############################
############################
def shrink_n_times(n=1, infilename=None):
    """
    shrink a localized solution to (1/n)th of a domain
    keeping periodic bc and Nx intact
    """
    print("making n an integer...")
    n = int(n)

    if (infilename != None):
        localized_sol = np.loadtxt(infilename)
        Nx = len(localized_sol)
        if(Nx % n == 0):
            print("n divedes Nx, good to go...")
            new_xmax = localized_sol[int(Nx/n)-1, 0]
            print("new_xmax = ", new_xmax)

            x_min = localized_sol[0, 0]
            dx    = (new_xmax-x_min)/(Nx-1)
            x = arange(x_min, new_xmax + dx, dx)

            shrunk_localized_sol = localized_sol
            shrunk_localized_sol[:, 0] = x

            if(".dat" in infilename):
                sol_name = infilename.replace(".dat", "")
                np.savetxt("shrunk_"+str(n)+"_times_" \
                + sol_name + ".dat", shrunk_localized_sol)
            else:
                print("infilename must be .dat type")

        else:
            print("n must divede Nx, quitting...")

    else:
        print("Please give the input filename infilename=file.dat")

    return 0
############################
def shrink_n_times(n=1, infilename=None):
    """
    shrink a localized solution to (1/n)th of a domain
    keeping periodic bc and Nx intact
    we keep the x_min the same here
    """
    print("making n an integer...")
    n = int(n)

    if (infilename != None):
        localized_sol = np.loadtxt(infilename)
        Nx = len(localized_sol)
        if(Nx % n == 0):
            print("n divedes Nx, good to go...")
            new_xmax = localized_sol[int(Nx/n)-1, 0]
            print("new_xmax = ", new_xmax)

            x_min = localized_sol[0, 0]
            dx    = (new_xmax-x_min)/(Nx-1)
            x = arange(x_min, new_xmax + dx, dx)

            shrunk_localized_sol = localized_sol
            shrunk_localized_sol[:, 0] = x

            if(".dat" in infilename):
                sol_name = infilename.replace(".dat", "")
                np.savetxt("shrunk_"+str(n)+"_times_" \
                + sol_name + ".dat", shrunk_localized_sol)
            else:
                print("infilename must be .dat type")

        else:
            print("n must divede Nx, quitting...")

    else:
        print("Please give the input filename infilename=file.dat")

    return 0
############################
