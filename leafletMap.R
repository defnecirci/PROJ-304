#turkey map
library(sf)
library(raster)
library(dplyr)
library(spData)
# for static and interactive maps
library(leaflet) # for interactive maps
library(mapview) # for interactive maps
library(ggplot2) # tidyverse data visualization package
library(shiny)   # for web applications
library(htmltools)
library(jsonlite)
library(geojsonio )
library(rjson)
library(PKI)
json_file <- "/Users/apple/Downloads/geo-countries_zip/archive/countries.geojson"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
#print(json_data$resources$name)
#for(i in 1:length(json_data$resources$datahub$type)){
#  if(json_data$resources$datahub$type[i]=='derived/csv'){
#    path_to_file = json_data$resources$path[i]
#    data <- read.csv(url(path_to_file))
#    print(data)
#  }
#}
#json_file <- "~/Desktop/map.geojson"
#https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json
states <- 
  geojson_read( 
    x = "/Users/apple/Downloads/geo-countries_zip/archive/countries.geojson"
    , what = "sp"
  )
#/Users/apple/Downloads/geo-countries_zip/archive/countries.geojson
#https://datahub.io/core/geo-countries/datapackage.json
#states2<- 
#  geojson_read( 
#    x = "https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_admin_0_countries.geojson"
#    , what = "sp"
#  )
#https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_admin_0_countries.geojson
#https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_admin_0_countries.geojson
#<script src="https://gist.github.com/erdem/8c7d26765831d0f9a8c62f02782ae00d.js"></script>

#options = leafletOptions(minZoom = -3, maxZoom = 5.3)
#df,states, options = leafletOptions(minZoom = -3, maxZoom = 5.3)

#labels <- sprintf(
#  "<strong>%s</strong><br/>%g people / mi<sup>2</sup>",
#  states$name, states$density
#) %>% lapply(htmltools::HTML)
GET("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", authenticate(":", ":", type="ntlm"), write_disk(al <- tempfile(fileext = ".csv")))
deathdata <- read.csv(al)
deathdata<-aggregate(X5.30.20 ~ Country.Region, deathdata, sum)
#deathdata<- read.csv("deathdata.csv")




deathdata$X5.30.20log2=log2(deathdata$X5.30.20)
deathdata<-deathdata[!(deathdata$X5.30.20log2)==-Inf,]
levels(deathdata$Country.Region)[12]<- "The Bahamas"
levels(deathdata$Country.Region)[30]<- "Cape Verde"
levels(deathdata$Country.Region)[28]<- "Myanmar"
levels(deathdata$Country.Region)[40]<- "Republic of Congo"
levels(deathdata$Country.Region)[47]<-"Czech Republic"
levels(deathdata$Country.Region)[41]<-"Democratic Republic of the Congo"
levels(deathdata$Country.Region)[43]<-"Ivory Coast"
levels(deathdata$Country.Region)[73] <-"Guinea Bissau"
levels(deathdata$Country.Region)[92] <-"South Korea"
levels(deathdata$Country.Region)[128] <-"Macedonia"
levels(deathdata$Country.Region)[150] <- "Republic of Serbia"
 

      




