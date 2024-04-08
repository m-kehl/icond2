## file for all fixed data used by app.R
# -> federal states with according state capital and coordinates
# -> names of all plantspecies for which phenological data are available at
#    opendata.dwd.de
# -> all phase names and according phase ids for which phenological data are
#    available
# -> meteorological parameters with according names, units, axes for plot, etc

## federal states with according state capital and coordinates
bundeslaender_coord <- data.frame(
  bundesland = c("Baden-Wuerttemberg", "Bayern","Berlin",                
                 "Brandenburg", "Bremen", "Hamburg",               
                 "Hessen", "Mecklenburg-Vorpommern", "Niedersachsen",         
                 "Nordrhein-Westfalen", "Rheinland-Pfalz", "Saarland",        
                 "Sachsen", "Sachsen-Anhalt", "Schleswig-Holstein",
                 "Thueringen"),
  lon1 = c(7,8.5,12,11,7.5,9,7.5,10.5,6,5,5.5,6,11.5,10,8,9),
  lon2 = c(11,14,15,15,9.5,11,10.5,15,12,10,9,7.5,15.5,13.5,11.5,13.5),
  lat1 = c(47,47,52,51,53,53,49,52.5,51,50,48.5,49,50,50.5,53,50),
  lat2 = c(50,51,53,54,54,54.5,52,55,54,53,51,50,52,53.5,55,52),
  mittel_lon =  c(9.00, 11.25, 13.28, 13.00,  8.50, 10.00,  9.00, 12.75, 9.00,  7.50,  7.25,  6.9,
   13.50, 11.75,  9.75, 11.25),
  mittel_lat = c(48.50, 49.00, 52.50, 52.50, 53.50, 53.6, 50.50, 53.75, 52.50, 51.50, 49.75, 49.4,
        51.00, 52.00, 54.00, 51.00),
  zoom = c(7,7,9,7,8,9,7,8,7,7,7,9,8,8,7,7),
  landeshauptstadt = c("Stuttgart","Muenchen","Berlin","Potsdam","Bremen","Hamburg",
                       "Wiesbaden","Schwerin","Hannover","Duesseldorf","Mainz",
                       "Saarbruecken","Dresden","Magdeburg","Kiel","Erfurt"),
  lon_point = c(9.182932,11.581981,13.404954,13.064473,8.8016937, 9.993682,8.239761,
                11.401250, 9.732010,6.773456,8.247253,6.996933, 13.737262,11.627624,
                10.122765,11.029880),
  lat_point = c(48.775846,48.135125,52.520007,52.390569,53.0792962,53.551085,50.078218,
                53.635502,52.375892,51.227741,49.992862,49.240157,51.050409,52.120533,
                54.323293,50.984768))
