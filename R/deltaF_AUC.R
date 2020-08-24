#' A function that calculates the area under the curve for a specified range in the data.
#'
#' Uses the auc function from the MESS package to calculate the area under the curve for all the regions in a specified dataframe.
#' It outputs this information as a wide dataframe.
#'
#'
#' @param dataframe A dataframe containing intensity data of a time series on a long format - gathered under the Cell ID#
#' @param begin The value in the data to begin integrating from
#' @param finish The final value for the area you wish to integrate
#' @keywords MESS Calcium DRC
#' @export
#' @examples
#' auc <- integrateCurve(cellNorbegint, 50, 250)
#'




deltaF_AUC <- function(dataframe,begin,finish){
  tempList <- list() # Need to declare empty list to store the data temporarily
  for (i in names(dataframe[2:ncol(dataframe)])){ # Goes from column 2 to last column - skipping the time column in position 1

    # Calculate delta F / Fo
    Fo = mean(dataframe[begin-10:begin,i])


    temp <- (MESS::auc(
      dataframe$X[begin:finish],(dataframe[begin:finish,i])/Fo
      )) # calculates AUC for one region and stores it in temp
    tempList[i] <- temp/length(begin:finish) # normalizes the area under the curve by the length of the area integrated
    # before storing it in the tempList - which will be a list of the integrations for all regions analyzed in 'dataframe'

  }
  return(data.frame(tempList)) # returns the list as a data frame
}
