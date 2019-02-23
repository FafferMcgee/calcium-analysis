# Calcium-Analysis R Package

Author: Michael Schamber

Purpose: Created to speed the analysis of calcium mobilization data collected in the Reza Lab. 

There are a number of helper functions for tidying, organizing, and normalizing the data from individual cells so that they can be compared to one another. The ultimate goal is to use the calcium mobilization data to calculate a dose response curve (using the DRC package) and estimate the EC<sub>50</sub>. 

# Package Installation Guide

**(This is to be isnerted at a later date, for now contact me directly)**

# Initial analysis of data

I use [Fiji](https://fiji.sc/ "Fiji's Homepage") for the analysis of the raw movies.

There is a little setup to be done to ensure the data extracted from the movie is in a format usable by this R package.

## Raw-Data Analysis

The first thing to do is set up the appropriate measurements. In Fiji go to Analyze > Set Measurements. As shown below:

![Set Measurements](/figures/set-measurements.png)

This will bring up the Set Measurements dialogue box:

![Measurements Window](/figures/measurement-window.png)