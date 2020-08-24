#' A function to import the raw calcium imaging data
#'
#' This function will take the data obtained from ImageJ time-series without normalization.
#' It cleans up the data as well by removing the area and IntDen1 columns.
#' It also renames the columns from RawIntDenx to Cell x.
#'
#' The output of the function should be stored as a variable.
#' There are two outputs for this function:
#' One is a standard wide-format that is easy to look at manually.
#' The other is a 'long' format where the intensity data has been gathered under a key for the cell/ROI being analyzed.
#'
#'
#' @param file Path to a csv file that contains the time-series data for multiple cells obtained in ImageJ
#' @keywords Calcium Imaging
#' @export
#' @examples
#' CalciumExperiment191 <- importRawData('./Data/Wholeimage_Calcium_Experiment191.csv')
#'
#' Example of storing data:
#' wholeNormInt191 <- wholeCalciumExperiment191[[1]]
#' longWholeNormInt191 <-wholeCalciumExperiment191[[2]]



importRawData <- function(file) {

  # Inputs csv file data into dataframe
  rawCalcium <- read.csv(file)


  # Removes final datapoint of the movie
  rawCalcium <- dplyr::slice(rawCalcium, 1:(nrow(rawCalcium)-1))


  # Initial cleanup of data - removes time column and rawIntDen column leaving only Area and IntDen
  tempRawCalcium <- rawCalcium %>%
    dplyr::select(-1) %>%
    dplyr::select(seq(3,ncol(rawCalcium),3))



  # Reintigrates time column
  tempRawCalcium <- cbind(rawCalcium[1], tempRawCalcium)


  # Creates a long, tidy dataframe
  longRawCalcium <- tempRawCalcium %>%
    gather(key = Region, value = Intensity, starts_with('RawIntDen'))


  # Rename the regions
  longRawCalcium$Region <- gsub('RawIntDen','Cell ', longRawCalcium$Region)


  # Returns a list of the dataframes, tempRawCalcium is good for checking analysis and will be wide
  # longRawCalcium is suitable for graphing and is 'Tidy'
  return(list(tempRawCalcium, longRawCalcium))

}
