#' A function that generates a tidy dataframe that groups the Cells/ROIs based upon the strength of their response at a specific drug concentration.
#'
#' This way when visualizing the individual data points on the DRC, you can see if a strong early response leads to a strong late respopnse
#'
#' @param dataframe A tidy dataframe that has
#' @param firstquartile Value of the first quartile for whatever concentration you want to separate responses by
#' @param thirdquartile Value of the third quartile for whatever concentration you want to separate responses by
#' @keywords Calcium DRC
#' @export
#' @examples
#' groupsData(longcellnormint, 0.073, 0.32)
#'




groupsData <- function(dataframe,firstquartile,thirdquartile){
  dataframe.group <- dataframe %>%
    dplyr::mutate(grp = ifelse(long$`3` <=firstquartile, 0,
                               ifelse(long$`3` >= thirdquartile,1,2)))

  superlong.dataframe.group <- dataframe.group %>%
    gather(key = "Concentration", value = "Response",-grp )


  superlong.group$Concentration <- as.numeric(superlong.group$Concentration)

  return(superlong.dataframe.group)
}





