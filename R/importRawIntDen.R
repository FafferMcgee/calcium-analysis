#' A function to calculate mean fluorescence intensity from
#'
#' This function will take the data obtained from ImageJ time-series and normalize them to each ROI.
#' It cleans up the data as well by removing the time column and rawIntDen column obtained from the ImageJ csv.
#' It also renames the columns from IntDenx to Cell x.
#'
#' It sets the maximum intensity in the time series to 1, and the minimum to 0.
#' This allows the ROI's analyzed to be compared to one another.
#'
#' The output of the function should be stored as a variable.
#' There are two outputs for this function:
#' One is a standard wide-format that is easy to look at manually.
#' The other is a 'long' format where the intensity data has been gathered under a key for the cell/ROI being analyzed.
#'
#' Normalization method: (x-min(x)) / (max(x)-min(x)
#' @param file Path to a csv file that contains the time-series data for multiple cells obtained in ImageJ
#' @keywords Calcium Imaging
#' @export
#' @examples
#' CalciumExperiment191 <- normalizeCalciumData('./Data/Wholeimage_Calcium_Experiment191.csv')
#'
#' Example of storing data:
#' wholetempRawCalcium191 <- wholeCalciumExperiment191[[1]]
#' longWholetempRawCalcium191 <-wholeCalciumExperiment191[[2]]



importRawIntDen <- function(file) {

  # Inputs csv file data into dataframe
  rawCalcium <- read.csv(file)


  # Removes final datapoint of the movie
  rawCalcium <- dplyr::slice(rawCalcium, 1:(nrow(rawCalcium)-1))


  # Initial cleanup of data - removes time column and rawIntDen column leaving only Area and IntDen
  tempRawCalcium <- rawCalcium %>%
    dplyr::select(seq(1,ncol(rawCalcium),3))


  # Creates a long, tidy dataframe
  longtempRawCalcium <- tempRawCalcium %>%
    gather(key = Region, value = Intensity, starts_with('RawIntDen'))


  # Rename the regions
  longtempRawCalcium$Region <- gsub('RawIntDen','Cell ', longtempRawCalcium$Region)


  # Returns a list of the dataframes, tempRawCalcium is good for checking analysis and will be wide
  # longtempRawCalcium is suitable for graphing and is 'Tidy'
  return(list(tempRawCalcium, longtempRawCalcium))

}
