#' A function to normalize calcium-sensitivie dye data
#'
#' This is a replacement to the deprecated 'normalizeCalciumData' function.
#' It is still included in the package because I don't want to have to redo any old code that may use that function.
#'
#' This was created because it is more explicit about the method of normalization and I anticipate having other normalization functions in the future.
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
#' CalciumExperiment191 <- minmaxCalciumData('./Data/Wholeimage_Calcium_Experiment191.csv')
#'
#' Example of storing data:
#' wholeNormInt191 <- wholeCalciumExperiment191[[1]]
#' longWholeNormInt191 <-wholeCalciumExperiment191[[2]]



minmaxCalciumData <- function(file) {

  # Inputs csv file data into dataframe
  rawCalcium <- read.csv(file)


  # Removes final datapoint of the movie
  rawCalcium <- dplyr::slice(rawCalcium, 1:(nrow(rawCalcium)-1))


  # Initial cleanup of data - removes time column and rawIntDen column leaving only Area and IntDen
  tempRawCalcium <- rawCalcium %>%
    dplyr::select(-1) %>%
    dplyr::select(-1*seq(0,ncol(rawCalcium),3))


  # Divides even column by odd columns to normalize intensity by area of the ROI used
  areaNormInt <- (tempRawCalcium[seq(0,ncol(tempRawCalcium),2)] / tempRawCalcium[seq(1,ncol(tempRawCalcium),2)])


  # Normalizes intensities so it is on a scale of 0,1
  normInt <- data.frame(lapply(areaNormInt, function(x) ((x-min(x))/(max(x)-min(x)))))

  # Reintigrates time column
  normInt <- cbind(rawCalcium[1], normInt)


  # Creates a long, tidy dataframe
  longNormInt <- normInt %>%
    gather(key = Region, value = Intensity, starts_with('IntDen'))


  # Rename the regions
  longNormInt$Region <- gsub('IntDen','Cell ', longNormInt$Region)


  # Returns a list of the dataframes, normInt is good for checking analysis and will be wide
  # longNormInt is suitable for graphing and is 'Tidy'
  return(list(normInt, longNormInt))

}
