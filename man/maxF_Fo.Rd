% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/maxF_Fo.R
\name{maxF_Fo}
\alias{maxF_Fo}
\title{A function used to quantify the response in the region of interest normalized by F/Fo.}
\usage{
maxF_Fo(data, conditions, averageWindow)
}
\description{
It normalizes the intensity data during stimulus window by calculating an average Fo before stimulus, and then dviding the fluorescence values in this window by the background Fo.
}
\details{
After this normalization, it looks for the maximum value in the same stimulus window and outputs this value as the 'response'.

Normalizing first by an averaged background (Fo) right before stimulus corrects for photobleaching/drift.
}
