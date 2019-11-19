#' A function used to quantify the response in the region of interest normalized by F/Fo.
#'
#' It normalizes the intensity data during stimulus window by calculating an average Fo before stimulus, and then dviding the fluorescence values in this window by the background Fo.
#'
#'
#'
#' Normalizing first by an averaged background (Fo) right before stimulus corrects for photobleaching/drift.
#'
#'
#'
#' Inputs:
#' @Data = Dataframe containing fluorescence intensity data
#' @Conditions = vectory of integers indicating when
#' @averageWindow = the window to use prior to stimulus for calculating Fo
#'
#' i = odd index of conditions (corresponds of start of new condition)
#' j = index of response
#'
#'
#' @export
#'


quantDeltaF_Fo <- function(data, conditions, averageWindow){
  tempList <- list() # Need to declare empty list to store the data temporarily

  response <-   ((mean(data[conditions[i]-averageWindow:conditions[i],4]) -
                    mean(data[conditions[i]-averageWindow:conditions[i],4])) /
                   (mean(data[conditions[i]-averageWindow:conditions[i],4])))

  tempList[1] <- response

  j=1

  for (i in seq(1,(length(conditions)-1),2)){

    j = j + 1

    response <-   ((mean(data[conditions[i]:conditions[i+1],4]) -
                     mean(data[conditions[i]-averageWindow:conditions[i],4])) /
                     (mean(data[conditions[i]-averageWindow:conditions[i],4])))


    # if (response < 0){
    #   response = 0
    # }



    tempList[j] <- response

  }

  tempList <- t(tempList)



  return(data.frame(tempList))

}

