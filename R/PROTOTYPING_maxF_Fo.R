# library(dplyr)
#
# # make sure no specific links to a file are uncommented before pushing to github
# # data <-  read.csv('file:///H:/CellBasedImaging/RezaLab/20190425MRS_WT_Casr_CalciumTitrations/Data/WholeImage_Calcium_Experiment139.csv')
#
# conditions <- c(30, 50, 75, 95, 135, 155, 205, 225, 270, 290, 365, 385, 455, 475, 570, 590, 645, 665)
#
# #data <- data %>%
# #  dplyr::select(X,IntDen1)
#
# averageWindow = 15
#
# responseVector <- rep(NA,((length(conditions))/2)+1 )
#
# for (i in seq_along(conditions[-length(conditions)])){ # iterate along the indexes of conditions, but omitting the final value
#
#   # calculate the indexes of the background region to calculate Fo
#   frame1 <- conditions[i]-averageWindow+1
#   frame2 <- conditions[i]
#
#   # calculate Fo by finding average between the two frames
#   Fo <-  mean(data$IntDen1[frame1:frame2])
#
#
#   response <- max((data$IntDen1[conditions[i]:conditions[i+1]] / Fo))
#
#
#   #responseVector[i] <- response
#   #return(responseVector)
#
#   # print(i)
#   # print(conditions[i]-averageWindow+1)
#   # print(conditions[i])
#   print(Fo)
#   print(response)
#   # print(frame1)
#   # print(frame2)
#
# }
#
#
#
#
# test2 <- c(data$IntDen1[conditions[1]-averageWindow+1:conditions[1]])
#
# mean(test2)
#
# mean(data$IntDen1[conditions[14]-averageWindow+1:conditions[14]])
#
# data$IntDen1[conditions[14]-averageWindow+1]
# data$IntDen1[conditions[14]]
#
# data$IntDen1[conditions[14]-averageWindow+1:conditions[14]]
#
#
#
#
#
#
#
#
#
#
#
