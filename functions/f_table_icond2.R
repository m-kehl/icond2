f_table_icond2 <- function(timesteps,point_forecast,mouse,type,parameter,
                           free_lon,free_lat){
  if ((is.null(mouse) & type == "mouse") | (((is.na(free_lon) | is.na(free_lat)) & type == "free"))){
    table_icond2 <- data.frame(Zeit = c(NULL),Wert = c(NULL))
  } else{
    if (parameter == "tot_prec"){
      table_icond2 <- data.frame(Zeit = paste0(format(as.POSIXct(seq(timesteps[1],
                                                                     timesteps[2], by = "hour"),
                                                                 tz="Europe/Paris") -60*60,format ="%d.%m.%Y %H:%M")," - ",
                                               format(as.POSIXct(seq(timesteps[1],
                                                                     timesteps[2], by = "hour"),
                                                                 tz="Europe/Paris"),format ="%H:%M")),
                                 Wert = as.numeric(point_forecast[1,]))
    } else{
      table_icond2 <- data.frame(Zeit = paste0(format(as.POSIXct(seq(timesteps[1],
                                                                     timesteps[2], by = "hour"),
                                                                 tz="Europe/Paris"),format ="%d.%m.%Y %H:%M")),
                                 Wert = as.numeric(point_forecast[1,2:ncol(point_forecast)]))
    }
    
    if (parameter == "tot_prec"){
      table_text <- "Wert [mm/h]"
    } else if (parameter == "t_2m"){
      table_text <- "Wert [\u00B0C]"
    } else if (parameter == "clct"){
      table_text <- "Wert [%]"
    } else if (parameter == "pmsl"){
      table_text <- "Wert [hPa]"
    }
    colnames(table_icond2)[2] <- table_text
    
  } 

  
  return(table_icond2)
}