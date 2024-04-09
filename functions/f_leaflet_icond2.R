f_leaflet_icond2 <- function(icond2_data){
  # icond2_data <- f_read_icond2(f_forecast_time(),"rain_gsp")
  # icond2_processed <- f_process_icond2(icond2_data,"rain_gsp")
  # icond2_processed_2 <- ifel(icond2_processed < 0.3, NA, icond2_processed)
  
  # icond2_processed_2 <- ifel(icond2_data < 0.3, NA, icond2_data)
  
  layer_1 <- subset(icond2_data,c(1))
#  layer_8 <- subset(icond2_processed_2,c(7))
  
  # cuting <- cut(icond2_processed[,,1],breaks = c(0.3,1,2,4,8,15,30,60,120))
  
  #temp
  # pal <- colorNumeric(c("transparent","#FFFFCC", "#41B6C4","#0C2C84"),domain = c(min(values(icond2_processed),na.rm = T),
  #                                                                                max(values(icond2_processed),na.rm = T)),
  #                     na.color = "transparent")
  
  #rain/snow
  pal <- colorNumeric(c("peachpuff1","pink","plum3","maroon1","red","red4","gold","lawngreen"),domain = c(min(values(icond2_data),na.rm = T),
                                                                                                          max(values(icond2_data),na.rm = T)),
                      na.color = "transparent")
  # pal <- colorFactor(c("peachpuff1","pink","plum3","maroon1","red","red4","gold","lawngreen"),
  #                      levels = levels(cuting),na.color = "transparent")
  print("here we are")
  map  <- leaflet() %>% 
    #addTiles() %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    addRasterImage(layer_1, col = pal,opacity = 0.8,layerId = "first") %>%  
    #setMaxBounds(lng1 = -3.5, lat1 = 42.2, lng2=20, lat2=58) %>%
    addRectangles(lng1 = -3.5, lat1 = 42.2, lng2 = 20, lat2 = 58, fill = FALSE) #%>%
    # setView(lng = 9,lat = 48,zoom = 8) #     %>%
    # addLegend(pal = pal, values = values(icond2_processed_2),title = "Rain [mm/h]")
    # 
}