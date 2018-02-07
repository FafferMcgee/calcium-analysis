#' A function that calculates the area under the curve for a specified range in the data.
#'
#' Uses the auc function from the MESS package to calculate the area under the curve for all the regions in a specified dataframe.
#' It outputs this information as a wide dataframe.
#'
#'
#' @param dataframe A dataframe containing intensity data of a time series on a long format - gathered under the Cell ID#
#' @param min The value in the data to start integrating from
#' @param max The final value for the area you wish to integrate
#' @keywords MESS Calcium DRC
#' @export
#' @examples
#' auc <- integrateCurve(cellNormInt, 50, 250)
#'




integrateCurve <- function(dataframe,min,max){
  tempList <- list() # Need to declare empty list to store the data temporarily
  for (i in names(dataframe[2:ncol(dataframe)])){ # Goes from column 2 to last column - skipping the time column in position 1

    temp <- ( (MESS::auc(dataframe$X[min:max],dataframe[min:max,i])) ) # calculates AUC for one region and stores it in temp
    tempList[i] <- temp/length(min:max) # normalizes the area under the curve by the length of the area integrated
                                        # before storing it in the tempList - which will be a list of the integrations for all regions analyzed in 'dataframe'

  }
  return(data.frame(tempList)) # returns the list as a data frame
}
