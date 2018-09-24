# initiate library
library(shiny)
library(shinydashboard)
library(shinythemes)
library(splitstackshape)
library(XML)
library(stringr)
library(raster)
library(rgdal)
library(DBI)
library(RPostgreSQL)
library(rpostgis)

source('variables.R')

ui <- source('interface.R')

# Define server 
server <- function(input, output, session) {
  pg_user<-"postgres"
  pg_db<-"postgres"
  pg_host<-"localhost"
  pg_port<-"5432"
  pg_pwd<-"root"
  
  driver <- dbDriver("PostgreSQL")
  DB <- dbConnect(
    driver, dbname=pg_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd
  )
  
  ## generate DATA page
  list_of_comp_data <- dbReadTable(DB, c("public", "list_of_comp_data"))
  
  output$comp_data <- DT::renderDataTable({
    DT::datatable(list_of_comp_data)
  })
  
  ## identify input from UPLOAD page
  observe({
    inShp <- input$shpData
    inShpType <- inShp$type
    inShpPath <- inShp$datapath
    print(inShpPath)
    
    if(is.null(inShp)){
      val = ""
    } else {
      file_name <- inShp$name
      temp_dir <- dirname(inShpPath)
      unzip(inShpPath, exdir = temp_dir)
      file_shp <- dir(temp_dir, pattern="*.shp$")
      val = str_remove(basename(file_shp), ".shp")
      # if(file.exists(paste0(dirtemp, val))){
      #   print("oke")
      # }
      val = paste0(val, "_", format(Sys.time(), "%Y%m%d%H%M%S"))
    }
    
    updateTextInput(session, inputId=mdEntity$vars[1], value=val)
  })
  
  
  #
  # shpName <- str_remove(basename(shpData), ".shp")
  # shpRead <- readOGR(shpData, shpName)
  # shpSRID<-tryCatch({pgSRID(DB, crs(shpRead), create.srid = TRUE)}, error=function(e){ })
  # pgEnvBatch <- paste("pg_env.bat", sep="")
  # pathEnv = ""
  # pathEnv[1] = paste0("@SET PATH=", postgre_path, "\\bin;%PATH%")
  # pathEnv[2] = paste0("@SET PGDATA=", postgre_path, "\\data")
  # pathEnv[3] = paste0("@SET PGUSER=", pg_user)
  # pathEnv[4] = paste0("@SET PGPORT=", pg_port)
  # pathEnv[5] = paste0("@SET PGLOCALEDIR=", postgre_path, "\\share\\locale\n")
  # 
  # createNewPGTbl = pathEnv
  # createNewPGTbl[6] = paste('shp2pgsql -I -s ', shpSRID , str_replace_all(string=shpRead, pattern="/", repl='\\\\'), shpName, ' | psql -d ', pg_db, sep="")
  # 
  # newBatchFile <- file(pgEnvBatch)
  # writeLines(createNewPGTbl, newBatchFile)
  # close(newBatchFile)
  # 
  # pgEnvBatchFile<-str_replace_all(string=pgEnvBatch, pattern="/", repl='\\\\')
  # system(pgEnvBatchFile)
  # 
  eventReactive(input$saveButton, {
    # source('xml_write.R')
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

