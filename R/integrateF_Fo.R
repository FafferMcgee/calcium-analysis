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
#' @param data = Dataframe containing fluorescence intensity data
#' @param conditions = vectory of integers indicating when
#' @param averageWindow = the window to use prior to stimulus for calculating Fo
#'
#' i = odd index of conditions (corresponds of start of new condition)
#' j = index of response
#'
#'
#'


integrateF_Fo <- function(data, conditions, averageWindow){
  tempList <- list() # Need to declare empty list to store the data temporarily


  tempData <- ((data[conditions[i]-averageWindow:conditions[i],4]) -
                 mean(data[conditions[i]-averageWindow:conditions[i],4])) /
                 mean(data[conditions[i]-averageWindow:conditions[i],4])


  response <- (MESS::auc(data[conditions[i]-averageWindow:conditions[i],1], tempData))

  tempList[1] <- response

  j=1

  for (i in seq(1,(length(conditions)-1),2)){

    j = j + 1

    tempData <- ((data[conditions[i]:conditions[i+1],4]) -
                  mean(data[conditions[i]-averageWindow:conditions[i],4])) /
               mean(data[conditions[i]-averageWindow:conditions[i],4])



    response <- (MESS::auc(data[conditions[i]:conditions[i+1],1], tempData))


    # if (response < 0){
    #   response = 0
    # }



    tempList[j] <- response

  }

  tempList <- t(tempList)



  return(data.frame(tempList))

}

