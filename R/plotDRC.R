#' A function that generates a dose-response curve for cellbased calcium data (or any multi-ROI based data).
#'
#'
#'
#' @param dataframe A tidy dataframe that has
#' @param maxdose The highest dose used in the dose response curve
#' @keywords MESS Calcium DRC
#' @export
#' @examples
#' plotDRC(longcellnormint.group, 10)
#'



plotDRC <- function(dataframe, maxdose){
  newdata <- expand.grid(conc=exp(seq(log(0.5),log(maxdose),length=100))) # sets the parameters for new data
                                                                     # sets a sequence from log(a) to log(b) with a length of 100
                                                                     # these are used as the X values to plot the titration curve
  pm <- predict(calcium050.LL.4, newdata=newdata, interval="confidence") # predicts a model with confidence interval for the X values generated


  newdata$p <- pm[,1] # Y values for the predicted model
  newdata$pmin <- pm[,2] # lower bound for confidence interval
  newdata$pmax <- pm[,3] # upper bound for confidence interval


  ggplot(dataframe, aes(x = Concentration, y = Response)) +
    geom_point(aes(color=factor(grp)),alpha=0.35, size =2.5) + # plots the individual data points for each cell/ROI
    geom_ribbon(data = newdata, aes(x=conc, y=p, ymin=pmin, ymax=pmax), alpha=0.2) + # plots the confidence interval as a ribbon
    geom_line(data=newdata, aes(x=conc,y=p)) + # plots the actual titration/dose response curve
    coord_trans(x="log") +
    xlab("Calcium (mM)") + ylab("Intensity (AU)") + theme(legend.position="none") +
    theme(axis.text=element_text(size=18),
          axis.title=element_text(size=22,face="bold"))
}
