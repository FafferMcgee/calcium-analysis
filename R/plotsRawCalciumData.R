

#' A function to plate normalized calcium data
#'
#' This function will plot the calcium data for individual ROI's.
#' It can also be used to plot the whole field of view (if data is available for that).
#' But it was designed to be able to simultaneously plot all the individual cell-based ROI's.
#'
#' @param data A dataframe containing intensity data of a time series on a long format - gathered under the Cell ID#
#' @param conditions A simple list or vector of timepoints where the conditions the cells were exposed to were changed.
#' @param columns An integer representing the number of columns you would like your plot to have.
#' @keywords ggplot2 plot calcium
#' @export
#' @examples
#' conditions191 <- c(50,100,150,230)
#' plotsRawCalciumData(longWholeNormInt191, conditions191, 5)



plotsRawCalciumData <- function(data, conditions = c(0), columns) {

  # This is a function for plotting calcium data. It was intended for use with single cell-based data,
  # but it can work with multiple whole-region analysis as well.
  #
  # It takes the dataframe, and a list of ints that denote the start and end of 'conditions.'
  # The last argument is the number of columns you would like to have in the final facet_wrap graphing.

  ggplot(data = data, aes(x=X, y=Intensity)) +
    geom_line(aes(colour=Region)) +
    facet_wrap( ~ Region, ncol=columns) +
    theme(legend.position = "none") +
    xlab("Time(s)") +
    ylab("Integrated Intensity (a.u.)") +
    geom_vline(xintercept=conditions, alpha = 0.3)

}
