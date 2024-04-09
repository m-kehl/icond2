#ShinyApp to visualise measurement and forecast weather data provided
#to the public by DWD (Deutscher Wetterdienst; opendata.dwd.de)
#
#20.02.2024 - ShinyApp created by m-kehl (mkehl.laubfrosch@gmx.ch)


## -- A -- Preparation ---------------------------------------------------------
rm(list = ls())

## required packages
library(shiny)
library(shinydashboard)
library(shinyjs)
library(waiter)
library(miceadds)
library(rdwd)
library(terra)
library(lubridate)
library(RCurl)
library(curl)
library(R.utils)
library(dplyr)
library(r2symbols)
library(leaflet)

## source functions and input
source.all(paste0(getwd(),"/functions/"))
source(paste0(getwd(),"/input.R"),local = TRUE)

##set local system
Sys.setlocale("LC_TIME", "German")

## -- B -- User Interface ------------------------------------------------------
ui <- fluidPage(
  tags$head(
    ## define superordinate settings 
    # HTML style for tabsets and notifications
    tags$style(HTML(
      ".tabbable > .nav > li                 > a  {font-weight: bold; 
                                                  background-color: aquamarine; 
                                                  color:black}
      .tabbable > .nav > li[class=active]    > a {background-color: HoneyDew; 
                                                  color:black}
      .tabbable ul li:nth-child(1) { float: right; }
      .tabbable ul li:nth-child(2) { float: right; }
      .tabbable ul li:nth-child(3) { float: right; }
      .tabbable ul li:nth-child(4) { float: right; }
      .shiny-notification {position:fixed;
                            top: calc(13%);
                            left: calc(18%);
                            max-width: 450px;
                            background-color: HoneyDew;
                            color: black;
                            border-color: aquamarine}"
    ))
  ),
  # use shiny waiter
  useWaiter(),
  ## Title
  titlePanel(title=div(img(src="laubfrosch.jpg",width = 100,height = 100),
                       "Prognose- und Messdaten"), windowTitle = "ICON-D2"),
  
  ## Main Panel
  fluidRow(
    mainPanel(
      useShinyjs(),
      # define main_tabsets (ICON D2, measurement data, phenology, impressum)
      tabsetPanel(
        id = "main_tabsets",
        selected = "icond2",
        
        ## -- B.1 --  TabPanel 1: Impressum --------------------------------------------
        tabPanel("Impressum",
                 value = "impressum",
                 uiOutput("laubfrosch",style="float:right"),
                 h3("Kontakt"),
                 h4("M. Kehl"),
                 h4("mkehl.laubfrosch@gmx.ch"),
                 h4("Quellcode auf", tags$a(href="https://github.com/m-kehl/weather_icond2",
                                            "GitHub")),
                 h3("Haftungsausschluss"),
                 h4("Der Autor übernimmt keine Gewähr für die Richtigkeit, Genauigkeit,
            Aktualität, Zuverlässigkeit und Vollständigkeit der Informationen.
            Haftungsansprüche gegen den Autor wegen Schäden materieller oder
               immaterieller Art, die aus dem Zugriff oder der Nutzung bzw.
               Nichtnutzung der veröffentlichten Informationen, durch Missbrauch
               der Verbindung oder durch technische Störungen entstanden sind,
               werden ausgeschlossen."),
                 p(),
                 h4("Alle Angebote sind freibleibend. Der Autor behält es sich
               ausdrücklich vor, Teile der Seiten oder das gesamte Angebot ohne 
               gesonderte Ankündigung zu verändern, zu ergänzen, zu löschen oder
               die Veröffentlichung zeitweise oder endgültig einzustellen."),
                 h3("Haftungsausschluss für Inhalte und Links"),
                 h4("Verweise und Links auf Webseiten Dritter liegen ausserhalb
               unseres Verantwortungsbereichs. Es wird jegliche Verantwortung
               für solche Webseiten abgelehnt. Der Zugriff und die Nutzung
               solcher Webseiten erfolgen auf eigene Gefahr des jeweiligen Nutzers."),
                 h3("Urheberrechtserklärung"),
                 h4("Die Urheber- und alle anderen Rechte an Inhalten, Bildern, Fotos
               oder anderen Dateien auf dieser Website, gehören ausschliesslich
               den genannten Rechteinhabern. Für die Reproduktion jeglicher 
               Elemente ist die schriftliche Zustimmung des Urheberrechtsträgers
               im Voraus einzuholen."),
                 h3("Quelle Impressum"),
                 h4(tags$a(href="https://brainbox.swiss/impressum-generator-schweiz/",
                           "BrainBox Solutions"))
        ),
        ## -- B.4 --  TabPanel 4: ICON D2 --------------------------------------------------------------
        tabPanel("Modell ICON-D2",
                 value = "icond2",
                 column(3, 
                        br(),
                        column(1,
                               actionButton("info_icond2", label = NULL, icon = icon("info"),
                                            style="color: black; 
                                              background-color: HoneyDew;
                                              border-color: aquamarine",
                                            widht = "10%")),
                        column(10,
                               h4("Regionalmodell ICON-D2",width = "90%")),
                        br(),
                        br(),
                        hr(),
                        radioButtons(
                          inputId = "parameter",
                          label = "Parameter",
                          selected = character(0),
                          choiceNames = c("Regen","Schnee","Temperatur"),
                          choiceValues = c("rain_gsp","snow_gsp","t_2m")),
                        selectInput(
                          inputId = "bundesland",
                          label = "Bundesland",
                          choices = bundeslaender_coord$bundesland,
                          multiple = FALSE),
                        radioButtons(
                          inputId = "point_forecast",
                          label = "Punktvorhersage",
                          choiceNames = c("Landeshauptstadt","freie Koordinatenwahl"),
                          choiceValues = c("bhs","free")),
                        box(id = "box_free_coord",
                            width = '800px',
                            numericInput("free_lon",label = "longitude", value = 9.05222,
                                         step = 0.5, width = "50%"),
                            numericInput("free_lat",label = "latitude", value = 48.52266,
                                         step = 0.5, width = "50%")),
                        p("Datenbasis: ",
                          symbol("copyright"), "Deutscher Wetterdienst (opendata.dwd.de)")
                 ),
                 column(9,
                        leafletOutput("map_out"),
                        sliderInput("slider_time", 
                                    "Zeit", 
                                    min = ceiling_date(Sys.time(),unit = "hour"),
                                    max = ceiling_date(Sys.time(),unit = "hour") + 6 * 60 * 60,
                                    step = 3600,
                                    value = c(ceiling_date(Sys.time(),unit = "hour")),
                                    timeFormat = "%a %H:%M", ticks = T, animate = T,
                                    width = "95%")
                 )
                 # column(4,
                 #        plotOutput("bar_out")
                 # )
        )
      )
    )
  )
)



## -- C --  server -------------------------------------------------------------
server <- function(input, output, session) {
  
  ## -- C.1 --  TabPanel 1: Impressum --------------------------------------------
  
  # picture of laubfrosch
  output$laubfrosch <- renderUI({
    tags$img(src="laubfrosch_blau.jpg", height=250)
  })
  
  # change picture of laubfrosch on click
  onclick(
    "laubfrosch", {
      #on click -> changing color
      output$laubfrosch <- renderUI({
        tags$img(src="laubfrosch_rot.jpg", height=250)
      })
    })

  ## -- C.4 --  TabPanel 4: ICON d2  ----------------------------------------------------------------
  ## read and process icon d2 forecast data
  # read icon d2 forecast data
  icond2_data <- reactive(f_read_icond2(f_forecast_time(),input$parameter))
  # read boundary-coordinates for specified Bundesland
#  square_coord <- reactive(f_spatvector(input$bundesland))
  # postprocess icon d2 forecast data
  icond2_processed <- reactive(f_process_icond2(icond2_data(),input$parameter))
  icond2_layer <- reactive(f_subset_icond2(input$slider_time,icond2_processed()))
  colorpal <- reactive(colorNumeric(c("peachpuff1","pink","plum3","maroon1","red","red4","gold","lawngreen"),
                                    domain = c(min(terra::values(icond2_processed()),na.rm = T),
                                                max(terra::values(icond2_processed()),na.rm = T)),
                                    na.color = "transparent"))
  # adapt forecast data for specified Bundesland
  #icond2_state <- reactive(f_cut_forecast(icond2_processed(),square_coord()))
  # read coordinates for point forecast
  point_coord <- reactive(f_point_coord(input$bundesland, input$point_forecast,
                                        input$free_lon, input$free_lat))
  # produce point forecast out of icon d2 forecast data
  point_forecast <- reactive(
    terra::extract(icond2_processed(), point_coord()[[1]], raw = TRUE, ID = FALSE)
  )
  # specify when forecast data was calculated
  output$forecast_time <- renderText(paste0("Forecast time is: ", f_forecast_time()))
  
  ## show information box
  observeEvent(input$info_icond2, {
    f_infotext(input$main_tabsets)
  })
  
  output$map_out <- renderLeaflet(
    leaflet() %>% 
      #addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      #addRasterImage(layer_1(), col = pal,opacity = 0.8,layerId = "first") %>%  
      setMaxBounds(lng1 = -3.834759, lat1 = 43.170241, lng2=20.219425, lat2=58.052226) %>%
      #addRectangles(lng1 = -3.5, lat1 = 42.2, lng2 = 20, lat2 = 58, fill = FALSE) %>%
      addPolygons(lng = c(-0.326501,5.470697,10.331397,13.519183,17.628903,20.219425,13.030434,7.577484,-3.834759),
                  lat = c(43.170241,43.535726,43.646881,43.600792,43.362164,57.637294,58.032444,58.052226,57.333792),
                  fill =FALSE)
  )
  
  observe({
    if (length(input$parameter) == 0){
      
    } else{
      iconlayer <- icond2_layer()
      mapModifier <- leafletProxy(
        "map_out", session)
      mapModifier %>%
        clearImages() %>%
        addRasterImage(iconlayer, col = colorpal(),opacity = 0.8)
    }
  })
  
  observeEvent(input$bundesland,{
    mapModifier <- leafletProxy(
      "map_out", session)
    mapModifier %>%
      setView(zoom = bundeslaender_coord$zoom[bundeslaender_coord$bundesland == input$bundesland],
              lng = bundeslaender_coord$mittel_lon[bundeslaender_coord$bundesland == input$bundesland],
              lat = bundeslaender_coord$mittel_lat[bundeslaender_coord$bundesland == input$bundesland])
  })

  
  
  # observeEvent(icond2_layer(),{
  # 
  # })
  # ## plot forecast data
  # observe({
  #   # placeholder-plot if no parameter is chosen in UI
  #   if (length(input$parameter) == 0){
  #     output$map_out <- renderPlot(
  #       f_plot_placeholder()
  #     )
  #   } else{
  #     # plot parameter chosen in UI on map
  # 
  #   }
  #   
  # })
  # 
  # observeEvent(input$slider_time,{
  #   #icond2_processed_2 <- reactive(ifel(icond2_processed() < 0.3, NA, icond2_processed()))
  #   #layer_8 <- subset(icond2_processed(),c(8))
  #   # pal <- colorNumeric(c("peachpuff1","pink","plum3","maroon1","red","red4","gold","lawngreen"),domain = c(min(values(icond2_processed()),na.rm = T),
  #   #                                                                                                         max(values(icond2_processed()),na.rm = T)),
  #   #                     na.color = "transparent")
  #   
  #    leafletProxy("map_out") %>%
  #      removeImage(layerId = "first") # %>%
  #      #addRasterImage(subset(icond2_processed(),8), col = pal(),opacity = 0.8,layerId = "first")
  #   
  #   print("and here we are also")
  # })
  # observeEvent(icond2_layer(),{
  # 
  #   print("and here we are again")
  #   req(icond2_layer())
  #   #icond2_processed_2 <- reactive(ifel(icond2_processed() < 0.3, NA, icond2_processed()))
  #   #layer_8 <- subset(icond2_processed(),c(8))
  #   # pal <- colorNumeric(c("peachpuff1","pink","plum3","maroon1","red","red4","gold","lawngreen"),domain = c(min(values(icond2_processed()),na.rm = T),
  #   #                                                                                                         max(values(icond2_processed()),na.rm = T)),
  #   #                     na.color = "transparent")
  #   
  #   hello <- leafletProxy("map_out",data = isolate(icond2_layer()),session) %>%
  #     addCircleMarkers(lng = c(8),lat = c(45)) %>%
  #     #removeImage(layerId = "first") # %>%
  #     addRasterImage(isolate(icond2_layer()),opacity = 0.8)
  #   
  # 
  # })
  # 
  #     # plot point forecast
  # #     if (!is.na(input$free_lon) && !is.na(input$free_lat)){
  # #       output$bar_out <- renderPlot(
  # #         f_barplot_icond2(point_forecast(),input$slider_time,input$parameter,
  # #                          input$point_forecast,
  # #                          bundeslaender_coord$landeshauptstadt[bundeslaender_coord$bundesland == input$bundesland])
  # #       )
  # #     } else{
  # #       # placeholder-barplot if no parameter is chosen in UI
  # #       output$bar_out <- renderPlot(
  # #         f_barplot_icond2_placeholder()
  # #       )
  # #     }
  #    
  
  ## adapt UI if user wishes free coordinates
  observeEvent(input$point_forecast,{
    shinyjs::toggle("box_free_coord")
  })
  
}
shinyApp(ui, server)
