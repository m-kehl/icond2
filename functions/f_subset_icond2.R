f_subset_icond2 <- function(input_time,icond2_processed){
  converter <- f_time_converter()
  ii <- converter[["rain_gsp"]][converter$time == input_time]
  sub <- subset(icond2_processed,c(ii))
  return(sub)
}