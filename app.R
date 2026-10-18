#ShinyApp to visualize measurement and forecast weather data provided
#to the public by DWD (Deutscher Wetterdienst; opendata.dwd.de)
#
#20.02.2024 - ShinyApp created by m-kehl (mkehl.laubfrosch@gmail.com)
#             code available via GitHub (https://github.com/m-kehl/weather_icond2)
#
#This ShinyApp is belongs to the Laubfrosch project by m-kehl and is publicly
#accessible via https://laubfrosch.shinyapps.io/weather-icond2/. The Laubfrosch
#project aims to show and explore the possibilities with OGD (open governmental data),
#in example with its visualization or representation in a generally comprehensible format.


## -- A -- Preparation ---------------------------------------------------------
rm(list = ls())

## required packages
library(shiny)               #to create ShinyApp
library(shinybrowser)        #to detect screen size
library(shinydashboard)      #to create boxes for UI
library(shinyjs)             #to use css style
library(waiter)              #to show waiters while data is downloaded/processed
library(rdwd)                #to access data provided by DWD (opendata.dwd.de)
library(terra)               #to visualize Raster Data
library(lubridate)           #to handle date and time
library(RCurl)               #to download data provided by DWD
library(curl)                #to read meta data
library(dplyr)               #to handle data frames
library(leaflet)             #to represents data on a map
library(R.utils)             #neede by readDWD() when used online via shinyapp.io

## source functions and input
sapply(list.files(pattern="[.]R$", path=paste0(getwd(),"/functions/"), full.names=TRUE), source)
source(paste0(getwd(),"/input.R"),local = TRUE)

## -- B -- User Interface ------------------------------------------------------
ui <- fluidPage(
  ## define superordinate settings 
  # load CSS style for the different elements (tabsets, plots, text, etc)
  tags$head(
    tags$link(rel = "stylesheet", href = "style.css")
  ),
  
  # activate shiny waiter,shinybrowser and shinyjs
  useWaiter(),
  #waiterShowOnLoad(),
  shinybrowser::detect(),
  useShinyjs(),
  
  ## -- B.2 --  TabPanel 2: phenology  -------------------------------------------
  icond2UI("icond2")
)

## -- C --  Server -------------------------------------------------------------
server <- function(input, output, session) {
  
  ## -- C.3 --  TabPanel 3: measurement data ----------------------------------------------------------------
  # second input not reactive -> no other option in this app.R
  icond2Server("icond2","icond2")
  
}
shinyApp(ui, server)
