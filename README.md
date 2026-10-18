## Laubfrosch_icond2

Laubfrosch_icond2 is an interactive web application built with **R Shiny** to 
visualize forecast weather data.

It allows users to explore open source data published by DWD (Deutscher Wetterdienst; opendata.dwd.de)
of forecast weather parameters (temperature, precipitation, pressure, cloud cover).
The numerical forecast model used is ICON-D2, which is run six times
a day by DWD.
More information about ICON-D2 may be found at: https://www.dwd.de/DE/forschung/wettervorhersage/num_modellierung/01_num_vorhersagemodelle/regionalmodell_icon_d2.html?nn=512942
In this RShiny project, ICON-D2 data is represented 2dim on a leaflet map and 1dim as point forecast.
The forecast area includes germany and parts of its neighbouring countries.

## Table of Contents

- [Live Application](#live-application)
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Run the Application Locally](#run-the-application-locally)
- [Usage](#usage)
- [Data Sources](#data-sources)
- [Dependencies](#dependencies)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [Contact](#contact)

## Live Application

The application is deployed on Posit Cloud and can be accessed through a web browser.

**Live app:** [Open the application](https://laubfrosch-icond2.share.connect.posit.cloud/)

**Source code:** [GitHub repository](https://github.com/m-kehl/icond2)

No local R installation is required to use the deployed version. However, the
deployed version is slow as the free deployment plan of Posit Cloud is used and
a local installation might be favorable.

## Features

The application provides the following functionality:

- **Map:** Laubfrosch_icond2 visualizes forecast data
(temperature, precipitation, pressure, cloud cover) 2dim on a map for Germany and its surrounding
countries.
- **Point forecast:** It shows additionally the point forcast for any location
in this region. The location can be chosen on the map or via lon/lat.
- **Table:** The point forecast is also displayed numerically in a table.
- **Interactive interface:** The user can choose the parameter, time, and location
for the visualized data.

## Repository Structure

The repository contains the application source code and any supporting files required to run it.

```text
icond2/
├── app.R                 # Main Shiny application
├── input.R               # input data, e.g., lon/lat for Bundeshauptstädte
├── R/                    # functions required to run the app, including Shiny server and UI function
├── www/                  # Static assets (style.css)
├── .gitignore            # Files excluded from version control
└── README.md             # Project documentation
```

## Requirements

To run the application locally, you need:

- **R:** A recent version of R.
- **Git:** Required if you want to clone the repository.
- **Internet access:** Required to clone the repository and install R packages.

## Installation

### 1. Install R and Git

Download and install R from [CRAN](https://cran.r-project.org/).
Download and install Git from [git-scm](https://git-scm.com/)

### 2. Clone the repository

Set up your git connection via html or SSH.

Then open a terminal and run (first line for html, second line for SSH):

```bash
git clone git@github.com:m-kehl/icond2.git¨
git clone https://github.com/m-kehl/icond2.git
```

Alternatively, download the repository as a ZIP file from GitHub and extract it locally.

### 3. Open the project

Open the project directory in RStudio, or set the working directory to the repository root in your R session.

```r
setwd("path/to/your/project")
```

Replace the path with the location of your local project directory.

## Run the Application Locally

### 1. Install dependencies

Install the packages required by the application.

For example:

```r
install.packages(c(
  "shiny",          # To create ShinyApp
  "shinybrowser",   # To detect screen size
  "shinydashboard", # To create boxes for UI
  "shinyjs",        # To use CSS styles
  "waiter",         # To show waiters while data is downloaded/processed
  "rdwd",           # To access data provided by DWD (opendata.dwd.de)
  "terra",          # To visualize raster data
  "lubridate",      # To handle date and time
  "RCurl",          # To download data provided by DWD
  "curl",           # To read metadata
  "dplyr",          # To handle data frames
  "leaflet",        # To create interactive maps
  "R.utils"         # Neede by readDWD() when used online via shinyapp.io/Posit Cloud

))

```

### 2. Launch the application

From the R console, run:

```r
shiny::runApp()
```

Alternatively, specify the application directory:

```r
shiny::runApp("path/to/your/project")
```

If using RStudio, open `app.R` and click **Run App**.

The application should open in your default web browser or in the RStudio Viewer.

## Usage

Once the application is running:

1. Open the application in your browser.
2. Select the desired variables.
3. Explore the generated visualizations.

## Data Sources

Laubfrosch_icond2 uses open government data provided by Deutscher Wetterdienst (DWD)
(ftp://opendata.dwd.de/weather/nwp/icon-d2/grib/).
It also uses data provided by openstreetmap (https://www.openstreetmap.org/copyright/)
accessed via leaflet to deploy the map.

## Dependencies

The application relies on R packages for its functionality.

| Package | Purpose |
|---|---|
| `shiny` | Create interactive web applications |
| `shinybrowser` | Detect the user's browser and screen size |
| `shinydashboard` | Create dashboard layouts and UI boxes |
| `shinyjs` | Add JavaScript functionality and manipulate CSS styles |
| `waiter` | Display loading screens and indicators while data is downloaded or processed |
| `rdwd` | Access and download meteorological data from the German Weather Service (DWD) Open Data server |
| `terra` | Read, process, and visualize raster and spatial data |
| `lubridate` | Handle and manipulate dates and times |
| `RCurl` | Download data from URLs, including DWD data |
| `curl` | Transfer data from URLs and retrieve metadata |
| `dplyr` | Manipulate, filter, and transform data frames |
| `leaflet` | Create interactive maps and visualize spatial data |
| `R.utils` | Neede by readDWD() when used online via shinyapp.io/Posit Cloud |

## Deployment

The application is deployed on Posit Cloud, while the source code is maintained in GitHub.

### Access the deployed application

Use the live application link provided above. Users can interact with the deployed
version without installing R or downloading the source code.

## Contributing

Contributions, suggestions, and bug reports are welcome.

To contribute:

1. Fork the repository.
2. Create a new branch for your changes.
3. Implement and test your changes locally.
4. Submit a pull request describing the changes.

Please include enough information to reproduce any reported issues.

## Contact

For questions, suggestions, or bug reports, please contact:

- **Author:** M. Kehl
- **Email:** mkehl.laubfrosch@gmail.com
- **GitHub:** https://github.com/m-kehl
