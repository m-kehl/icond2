f_subset_icond2 <- function(input_time,icond2_processed,timesteps){
  ## function to retrieve one layer out of SpatRaster for
  #  the time specified with input_time
  # - input_time: POSIXct; date/time for layer in question
  # - icond2_processed: SpatRaster; data from which layer is retrieved, ie 
  #                                 result of f_process_icond2()
  # - timesteps: array -> c(integer,integer), indicating hours from now between
  #                         which the forecasts products are downloaded
  
  if (!(input_time %in% time(icond2_processed))){
    input_time <- ceiling_date(Sys.time(),unit = "hour") + (timesteps[1] - 1) * 60 * 60
  }
  sub <- icond2_processed[[time(icond2_processed) == input_time]]
  return(sub)
}