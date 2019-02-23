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

If you are using a markdown format as suggested, you will need to insert a new R chunk for each segment/step of code you wish to execute. You can do this as shown here:

![New Chunk](/figures/insert-chunk.png)

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

That chunk of code is responsible for letting RStudio know to load those packages so that you can use them in your analysis. It should be the first chunk of code in your markdown file.

If you don't have one of those packages installed, you can install it with the `install.packages('Package name')` command. For example, you would install ggplot2 with `install.packages('ggplot2')` 

And if you wish to install multiple packages at once, you may install them as a list: `install.packages(c('ggplot2', 'dplyr', 'tidyr'))`

## Running a chunk of code.

For each chunk of code, there is a green 'play' triangle in the top right corner. Simply click that button to run the code in the chunk. Shown below:

![Run Chunk](/figures/run-chunk.png)

## Importing your data

The next step is to import your data into RStudio so that you can work with it. 

First, you should set the working directory with the `setwd('path/to/your/data/')` at the top of the chunk.

Following that, we can read in and normalize the data all at once with the 'minmaxCalciumData' function. This function takes a single argument, which is your data file for a single experiment. This function takes your data as an input, and then it normalizes the fluorescence intensity for each cell based on the maximum and minimum fluorescence intensity for each ROI independently. The function returns a list of normalized data one in a 'wide' format and another in a 'long' format.

It is used as follows: 
```
Experiment23CalciumData <- minmaxCalciumData('Experiment23Data.csv')
normalizedIntensity23 <- Experiment23CalciumData[[1]]
longNormalizedIntensity23 <- Experiment23CalciumData[[2]]
```

Here is the difference between the wide and long data:

**Insert Images Here**

## Defining your condition change timepoints

For calculating the DRC and for making clear plots that indicate when you changed the condition the cells were exposed to, you need to manually specify those time points (as frame #s - **THIS IS IMPORTANT**). Because the data in the CSV has no time coomponent, only frame #.

To continue the example, I would specific the conditions for Experiment23 as follows:
```
conditions23 <- c(25, 100, 150, 225, 275, 350)
```
This would imply that I put it into the first condition at fram 25, and at frame 100 i began to wash it out. Then at frame 150, I moved to the second condition, and washed it out, etc. 

## Plotting your data

Now we are ready to plot the data and begin looking at it so we can qualitatively check to make sure the data is suitable for further analysis or additional cleaning. 

I created a plotting function to cleanly plot data from each experiment. It is the function `plotsCellCalciumData(data, conditions, columns)`

This function takes three arguments:
1) your data in 'long' format e.g. longNormalizedIntensity23
2) Your list of conditions e.g. conditions23
3) The number of columns you want your figure to have e.g. 10

It would like like this: `plotsCellCalciumData(longNormalizedIntensity23, conditions23, 10)`

The number of columns you want to specify will depend upon the total number of ROIs you analyzed in that given movie. You can easily change the number and re-run the chunk of code to re-plot your data. 


# Quantifying the strength of response

....
_**This will be added later**_
....