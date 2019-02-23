# Calcium-Analysis R Package

Author: Michael Schamber

Purpose: Created to speed the analysis of calcium mobilization data collected in the Reza Lab. 

There are a number of helper functions for tidying, organizing, and normalizing the data from individual cells so that they can be compared to one another. The ultimate goal is to use the calcium mobilization data to calculate a dose response curve (using the DRC package) and estimate the EC<sub>50</sub>. 

# Package Installation Guide

**(This is to be isnerted at a later date, for now contact me directly)**

# Initial analysis of data

I use [Fiji](https://fiji.sc/ "Fiji's Homepage") for the analysis of the raw movies.

There is a little setup to be done to ensure the data extracted from the movie is in a format usable by this R package.

## Raw-Data Analysis in Fiji

The first thing to do is set up the appropriate measurements. In Fiji go to Analyze > Set Measurements. As shown below:

![Set Measurements](/figures/set-measurements.png)

This will bring up the Set Measurements dialogue box:

![Measurements Window](/figures/measurement-window.png)

Make sure that the Area and Integrated Density dialog boxes are selected. Those are the only two that should be selected for this package. This 'pipeline' can still be used if there are other measurements selected; however, I will need to tweak the functions for your specific data format.

Make sure that you have split the channels on your time-series so that you are only working with the channel that corresponds to your calcium-dye fluorescence intensities. Otherwise Fiji will analyze your data and you'll have multiple channels of data inter-weaved together, which will be a pain to tease apart. 

After you have selected all the Regions of Interests (ROIs) that you wish to analye, you are ready to analyze your time-series.

From the ROI manager, select More >> and then Multi Measure.

![Multi-Measure](/figures/multi-measure.png)

After Fiji analyzes your calcium channel, it will open a results dialogue box. 

![Results](/figures/results.png)

From here, select *File > Save As*  and then save your data as a .csv file format. **This is important!** The work-flow assumes your data is in a comma-separated value format.

Now that you have saved your raw data, it would be wise to save the ROIs you created to the movie file. To do that.... (Will be filled in later)

# Analyzing the data in Rstudio with the Calcium-Analysis package

## Setting up your analysis file 

You can create a new R file or a new R markdown file. *(I would recommend making it a markdown file)*

You can do this as follows:

![New Markdown](/figures/new-markdown.png)

There are a number of packages that are needed for performing this analysis. They are as follows:

```R
library(ggplot2)
library(dplyr)
library(tidyr)
library(plyr)
library(MESS)
library(sandwich)
library(lmtest)
library(multcomp)
library(drc)
library(CalciumAnalsysis)
```

If you don't have one of those packages installed, you can install it with the `install.packages('Package name')` command. For example, you would install ggplot2 with `install.packages('ggplot2')` 

And if you wish to install multiple packages at once, you may install them as a list: `install.packages(c('ggplot2', 'dplyr', 'tidyr'))`

