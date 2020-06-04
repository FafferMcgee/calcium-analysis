#' A function to normalize calcium-sensitivie dye data
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
#' @param rawIntDen
#' @keywords Calcium Imaging
#' @export
#' @examples




normalizRawIntDen <- function(rawIntDen) {


  # Initial cleanup of data - removes time column and rawIntDen column leaving only Area and IntDen
  tempRawIntDen <- rawIntDen %>%
    dplyr::select(-1)


  # Normalizes intensities so it is on a scale of 0,1
  normInt <- data.frame(lapply(tempRawIntDen, function(x) ((x-min(x))/(max(x)-min(x)))))

  # Reintigrates time column
  normInt <- cbind(rawIntDen[1], normInt)


  # Creates a long, tidy dataframe
  longNormInt <- normInt %>%
    gather(key = Region, value = Intensity, starts_with('Cell'))


  # Returns a list of the dataframes, normInt is good for checking analysis and will be wide
  # longNormInt is suitable for graphing and is 'Tidy'
  return(list(normInt, longNormInt))

}
