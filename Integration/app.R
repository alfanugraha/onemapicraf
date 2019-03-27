###*Initiate Library####
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyLP)
library(shinyBS)
library(slickR)
library(splitstackshape)
library(XML)
library(stringr)
library(raster)
library(rgdal)
library(rgeos)
library(DBI)
library(RPostgreSQL)
library(rpostgis)
library(cleangeo)
library(DT)
library(rgdal)
library(rgeos)
library(raster)

###*Define Variables####
source('variables.R')
source('kugi4.R')

###*Setting Up Interface####
ui <- source('interface.R')

#Integrasi
navbarMenu("Integrasi",
           tabPanel("Select Data", values="tabSelectIgd", 
                    uiOutput("listOfCompData"),
                    uiOutput("listOfIgdData"),
                    actionButton("unionButton", "Union")
           ),
           "----",
           "Viewer",
           tabPanel("Map Viewer")
)

Igd <- tryCatch({
  dbConnect(driver, dbname=pg_igd_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd )
}, error=function(e){
  print("Database connection failed")
  return(FALSE)
})

#read shapefile to R
igd <- readOGR(Igd)
igt <- readOGR(Db) 



uni <- union(igd, igt)

crop1 <- crop(igd, igt)

