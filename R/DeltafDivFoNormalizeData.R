#' A function to normalize calcium-sensitivie dye data
#'

#' @param file Path to a csv file that contains the time-series data for multiple cells obtained in ImageJ
#' @keywords Calcium Imaging
#' @export
#' @examples
#' CalciumExperiment191 <- minmaxCalciumData('./Data/Wholeimage_Calcium_Experiment191.csv')
#'
#' Example of storing data:
#' wholeNormInt191 <- wholeCalciumExperiment191[[1]]
#' longWholeNormInt191 <-wholeCalciumExperiment191[[2]]


DeltafDivFoNormalizeData <- function(file) {

  # Inputs csv file data into dataframe
  rawCalcium <- read.csv(file)


  # Removes final datapoint of the movie
  rawCalcium <- dplyr::slice(rawCalcium, 1:(nrow(rawCalcium)-1))


  # Initial cleanup of data - removes time column and rawIntDen column leaving only Area and IntDen
  tempRawCalcium <- rawCalcium %>%
    dplyr::select(-1) %>%
    dplyr::select(-1*seq(2,ncol(rawCalcium),3))


  # Divides even column by odd columns to normalize intensity by area of the ROI used
  areaNormInt <- (tempRawCalcium[seq(0,ncol(tempRawCalcium),2)] / tempRawCalcium[seq(1,ncol(tempRawCalcium),2)])


  # Normalizes intensities so it is on a scale of 0,1
  normInt <- data.frame(lapply(areaNormInt, function(x) ((x - (mean(x[10:25]))) / mean(x[10:25])) ))

  # Reintigrates time column
  normInt <- cbind(rawCalcium[1], normInt)


  # Creates a long, tidy dataframe
  longNormInt <- normInt %>%
    gather(key = Region, value = Intensity, starts_with('RawIntDen'))


  # Rename the regions
  longNormInt$Region <- gsub('RawIntDen','Cell ', longNormInt$Region)


  # Returns a list of the dataframes, normInt is good for checking analysis and will be wide
  # longNormInt is suitable for graphing and is 'Tidy'
  return(list(normInt, longNormInt))

}
