library(dplyr)

data <-  read.csv('file:///D:/CellBasedImaging/RezaLab/20190425MRS_WT_Casr_CalciumTitrations/Data/WholeImage_Calcium_Experiment139.csv')

averageWindow = 15

conditions <- c(averageWindow, 30, 50, 75, 95, 135, 155, 205, 225, 270, 290, 365, 385, 455, 475, 570, 590, 645, 665)

data <- data %>%
  dplyr::select(X,IntDen1)


responseVector <- rep(NA,((length(conditions))/2)+1 )

for (i in seq_along(conditions[-length(conditions)])){ # iterate along the indexes of conditions, but omitting the final value

  if (i %% 2 == 0){
    # Do something
  } else {
    # Do some other thing
  }

  # calculate the indexes of the background region to calculate Fo
  frame1 <- conditions[i]-averageWindow+1
  frame2 <- conditions[i]

  # calculate Fo by finding average between the two frames
  Fo <-  mean(data$IntDen1[frame1:frame2])


  response <- max((data$IntDen1[conditions[i]:conditions[i+1]] / Fo))


  #responseVector[i] <- response
  #return(responseVector)

  # print(i)
  # print(conditions[i]-averageWindow+1)
  # print(conditions[i])
  print(Fo)
  print(response)
  # print(frame1)
  # print(frame2)

}




test2 <- c(data$IntDen1[conditions[1]-averageWindow+1:conditions[1]])

mean(test2)

mean(data$IntDen1[conditions[14]-averageWindow+1:conditions[14]])

data$IntDen1[conditions[14]-averageWindow+1]
data$IntDen1[conditions[14]]

data$IntDen1[conditions[14]-averageWindow+1:conditions[14]]



i = 1
while (i <= length(conditions)){
  print(i)
  i <- i + 1
}

# 30, 50, 75, 95, 135, 155, 205, 225, 270, 290, 365, 385, 455, 475, 570, 590, 645, 665
#
# 1-15,1 Fo
# 1,2 Max
# 3-15, 3 Fo
# 3,4 max
# 5-15,5 Fo
# 5,6 Max
# 7-15,7 Fo
# 7, 8 Max
# 9-15,9

backgroundIndex <-  seq(1,length(conditions),2)

# for (i in backgroundIndex){
#   print(conditions[i]-15)
# }
#
# responseIndex <- seq(2,length(conditions),2)
#
# for (i in responseIndex){
#   print(conditions[(i-1):i])
# }

for (i in backgroundIndex){
  print(c(conditions[i]-15,conditions[i]))
  print(c(conditions[i],conditions[i+1]))
}

