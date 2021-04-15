=====================================SUMMARY==========================================

DNAmotor.m is a script that runs and visualizes the trajectory of the particle

SimulateMotorDNA.m is a function that can be called from other scripts, which does NOT visualize the trajectory, only calculates and stores the trajectory data.

===================================MAJOR INPUTS=======================================

n = size of DNA array (n x n array)
N = size of RNA array (N x N array)
ne = number of enzymes
brownianFrequency = particle vibration frequency in Hz
Kon = binding constant in Hz
Koff = unbinding constant in Hz
Kcat = 3 cleavage constant in Hz
timeStep = resolution in seconds
tMax = total time simulated in seconds
density = fraction of DNA molecules present
nSpan = size of DNA array used to calculate the number of DNA molecules available. Increasing n and keeping nSpan constant increases span.

===================================MAJOR OUTPUTS======================================

t = time array (1 column, tMax/timeStep rows). Each element is a time point.
p = position array (2 columns, tMax/timeStep rows). Each row corresponds the time point in the array "t". The first column is the x-position, the second column is the y-position.

===================================-------------======================================