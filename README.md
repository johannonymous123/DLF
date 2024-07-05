# DLF
This repository contains the code used to verify the results in the paper: A Dynamic Likelihood Approach to Filtering for Advection Diffusion Dynamics. The paper is currently available here http://www.arxiv.org/abs/2406.06837 and submitted to The Monthly Weather Review.

The file 'Input.m' contains all user-defined parameters. Change these parameters to your liking, then run the script 'main.m', which coordinates all relevant scripts, i.e. generates a truth, and observations and then runs a DLF and a KF model.
The main parameters to change to reproduce the results from the paper are the diffusion constant D, the number of observations at each observation time, and the number of runs, as well as whether uncertainties in the initial amplitude, phase, or phase speed are present.


