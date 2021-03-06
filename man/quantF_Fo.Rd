% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantF_Fo.R
\name{quantF_Fo}
\alias{quantF_Fo}
\title{A function used to quantify the response in the region of interest normalized by F/Fo.}
\usage{
quantF_Fo(data, conditions, averageWindow)
}
\description{
It normalizes the intensity data during stimulus window by calculating an average Fo before stimulus, and then dviding the fluorescence values in this window by the background Fo.
}
\details{
Normalizing first by an averaged background (Fo) right before stimulus corrects for photobleaching/drift.



Inputs:
Data = Dataframe containing fluorescence intensity data
Conditions = vectory of integers indicating when
averageWindow = the window to use prior to stimulus for calculating Fo

i = odd index of conditions (corresponds of start of new condition)
j = index of response
}
