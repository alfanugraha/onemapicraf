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

ui <- navbarPage(title = appsTitle, theme = shinytheme("cerulean"),
  tabPanel("Data", icon = icon("database"),
    DT::dataTableOutput("comp_data")
  ),
  tabPanel("Upload", icon = icon("upload"),
       h2("Upload Data"),
       fileInput("shpData", "Upload Shapefile", buttonLabel="Browse...", placeholder="No file selected", accept = c('shp', 'SHP', 'ESRI Shapefiles [OGR]', '.shp', '.SHP')),
       tabBox(title="Metadata",
              id = "tabMetadata", width = "300px",
              tabPanel(appsMenu$menuItem[1],
                       textInput(mdEntity$vars[1], mdEntity$name[1], value="", width=NULL, placeholder=""), 
                       textInput(mdEntity$vars[2], mdEntity$name[2], value="", width=NULL, placeholder=""),
                       textInput(mdEntity$vars[3], mdEntity$name[3], value="", width=NULL, placeholder=""),
                       textInput(mdEntity$vars[4], mdEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(mdEntity$vars[5], mdEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(mdEntity$vars[6], mdEntity$name[6], value="", width=NULL, placeholder=""),
                       dateInput(mdEntity$vars[7], mdEntity$name[7]),
                       textInput(mdEntity$vars[8], mdEntity$name[8], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[2],
                       textInput(ctEntity$vars[1], ctEntity$name[1], value="", width=NULL, placeholder="Fill the name"),
                       textInput(ctEntity$vars[2], ctEntity$name[2], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[3], ctEntity$name[3], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[4], ctEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[5], ctEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[6], ctEntity$name[6], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[7], ctEntity$name[7], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[8], ctEntity$name[8], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[9], ctEntity$name[9], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[10], ctEntity$name[10], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[11], ctEntity$name[11], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[12], ctEntity$name[12], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[13], ctEntity$name[13], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[14], ctEntity$name[14], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[15], ctEntity$name[15], value="", width=NULL, placeholder=""),
                       textInput(ctEntity$vars[16], ctEntity$name[16], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[3],
                       textInput(sriEntity$vars[1], sriEntity$name[1], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[2], sriEntity$name[2], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[3], sriEntity$name[3], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[4], sriEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[5], sriEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[6], sriEntity$name[6], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[7], sriEntity$name[7], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[8], sriEntity$name[8], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[9], sriEntity$name[9], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[10], sriEntity$name[10], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[11], sriEntity$name[11], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[12], sriEntity$name[12], value="", width=NULL, placeholder=""),
                       textInput(sriEntity$vars[13], sriEntity$name[13], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[4],
                       textInput(refSysEntity$vars[1], refSysEntity$name[1], value="", width=NULL, placeholder=""),
                       dateInput(refSysEntity$vars[2], refSysEntity$name[2]),
                       textInput(refSysEntity$vars[3], refSysEntity$name[3], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[4], refSysEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[5], refSysEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[6], refSysEntity$name[6], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[7], refSysEntity$name[7], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[8], refSysEntity$name[8], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[9], refSysEntity$name[9], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[10], refSysEntity$name[10], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[11], refSysEntity$name[11], value="", width=NULL, placeholder=""),
                       textInput(refSysEntity$vars[12], refSysEntity$name[12], value="", width=NULL, placeholder="") 
              ),
              tabPanel(appsMenu$menuItem[5], 
                       textInput(idInfoEntity$vars[1], idInfoEntity$name[1], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[2], idInfoEntity$name[2], value="", width=NULL, placeholder=""),
                       dateInput(idInfoEntity$vars[3], idInfoEntity$name[3]),
                       textInput(idInfoEntity$vars[4], idInfoEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[5], idInfoEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[6], idInfoEntity$name[6], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[7], idInfoEntity$name[7], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[8], idInfoEntity$name[8], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[9], idInfoEntity$name[9], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[10], idInfoEntity$name[10], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[11], idInfoEntity$name[11], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[12], idInfoEntity$name[12], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[13], idInfoEntity$name[13], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[14], idInfoEntity$name[14], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[15], idInfoEntity$name[15], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[16], idInfoEntity$name[16], value="", width=NULL, placeholder=""),
                       textInput(idInfoEntity$vars[17], idInfoEntity$name[17], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[6],
                       textInput(disInfoEntity$vars[1], disInfoEntity$name[1], value="", width=NULL, placeholder="Fill the name"),
                       textInput(disInfoEntity$vars[2], disInfoEntity$name[2], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[3], disInfoEntity$name[3], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[4], disInfoEntity$name[4], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[5], disInfoEntity$name[5], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[6], disInfoEntity$name[6], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[7], disInfoEntity$name[7], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[8], disInfoEntity$name[8], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[9], disInfoEntity$name[9], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[10], disInfoEntity$name[10], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[11], disInfoEntity$name[11], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[12], disInfoEntity$name[12], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[13], disInfoEntity$name[13], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[14], disInfoEntity$name[14], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[15], disInfoEntity$name[15], value="", width=NULL, placeholder=""),
                       textInput(disInfoEntity$vars[16], disInfoEntity$name[16], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[7],
                       box(title = "Transfer Options WFS", solidHeader = TRUE, collapsible = TRUE, 
                         textInput(paste0(trfOptEntity$vars[1], "WFS"), trfOptEntity$name[1], value="", width=NULL, placeholder=""),
                         textInput(paste0(trfOptEntity$vars[2], "WFS"), trfOptEntity$name[2], value="", width=NULL, placeholder=""),
                         textInput(paste0(trfOptEntity$vars[3], "WFS"), trfOptEntity$name[3], value="", width=NULL, placeholder=""),
                         textInput(paste0(trfOptEntity$vars[4], "WFS"), trfOptEntity$name[4], value="RAW", width=NULL, placeholder=""),
                         textInput(paste0(trfOptEntity$vars[5], "WFS"), trfOptEntity$name[5], value="", width=NULL, placeholder="")
                       ),
                       box(title = "Transfer Options WMS", solidHeader = TRUE, collapsible = TRUE, 
                           textInput(paste0(trfOptEntity$vars[1], "WMS"), trfOptEntity$name[1], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[2], "WMS"), trfOptEntity$name[2], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[3], "WMS"), trfOptEntity$name[3], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[4], "WMS"), trfOptEntity$name[4], value="ImageWMS", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[5], "WMS"), trfOptEntity$name[5], value="", width=NULL, placeholder="")
                       ),
                       box(title = "Transfer Options ZIP Shapefile", solidHeader = TRUE, collapsible = TRUE, 
                           textInput(paste0(trfOptEntity$vars[1], "ZIP"), trfOptEntity$name[1], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[2], "ZIP"), trfOptEntity$name[2], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[3], "ZIP"), trfOptEntity$name[3], value="", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[4], "ZIP"), trfOptEntity$name[4], value="ZIP Shapefile", width=NULL, placeholder=""),
                           textInput(paste0(trfOptEntity$vars[5], "ZIP"), trfOptEntity$name[5], value="", width=NULL, placeholder="")
                       ),
                       box(title = "Transfer Options ImageWFS", solidHeader = TRUE, collapsible = TRUE, 
                            textInput(paste0(trfOptEntity$vars[1], "ImageWFS"), trfOptEntity$name[1], value="", width=NULL, placeholder=""),
                            textInput(paste0(trfOptEntity$vars[2], "ImageWFS"), trfOptEntity$name[2], value="", width=NULL, placeholder=""),
                            textInput(paste0(trfOptEntity$vars[3], "ImageWFS"), trfOptEntity$name[3], value="", width=NULL, placeholder=""),
                            textInput(paste0(trfOptEntity$vars[4], "ImageWFS"), trfOptEntity$name[4], value="ImageWMS", width=NULL, placeholder=""),
                            textInput(paste0(trfOptEntity$vars[5], "ImageWFS"), trfOptEntity$name[5], value="", width=NULL, placeholder="")
                       )
              ),
              tabPanel(appsMenu$menuItem[8],
                       textInput(mdMtncEntity$vars[1], mdMtncEntity$name[1], value="", width=NULL, placeholder=""),
                       textInput(mdMtncEntity$vars[2], mdMtncEntity$name[2], value="", width=NULL, placeholder="")
              ),
              tabPanel(appsMenu$menuItem[9],
                       textInput(mdConstEntity$vars[1], mdConstEntity$name[1], value="", width=NULL, placeholder=""),
                       textInput(mdConstEntity$vars[2], mdConstEntity$name[2], value="", width=NULL, placeholder=""),
                       textInput(mdConstEntity$vars[3], mdConstEntity$name[3], value="", width=NULL, placeholder="")
              )
       ),
       actionButton("saveButton", "Save")
  ),
  tabPanel("About"
  )
)

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
  
  list_of_comp_data <- dbReadTable(DB, c("public", "list_of_comp_data"))
  
  output$comp_data <- DT::renderDataTable({
    DT::datatable(list_of_comp_data)
  })
  
  observe({
    inShp <- input$shpData
    
    if(is.null(inShp)){
      val = ""
    } else {
      val = str_remove(basename(inShp$name), ".shp")
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
  observe({
    act <- input$saveButton
    print(!is.null(act))
    
    if(!is.null(act)){
      fileName <- input$fileIdentifier
      
      mdEntity <- data.frame(
        name = c('File Identifier', 'Language', 'Character Set', 'Hierarchy Level', 'Metadata Standard Name', 'Metadata Standard Version', 'Date Stamp', 'Data Set URI'),
        vars = c(fileName, input$lang, input$charSet, input$hieLvl, input$mdStdName, input$mdStdVer, input$dateStamp, input$dataSetURI)
      )
      
      downloadHandler(
        filename = function() {
          paste(fileName, Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
          write.csv(mdEntity, file)
        }
      )
      
      # eval(parse(text=(paste("list_of_comp_data<-data.frame(DATA_NAME=tolower(fileName), row.names=NULL)", sep=""))))
      # dbWriteTable(DB, "list_of_comp_data", list_of_comp_data, append=TRUE, row.names=FALSE)
      # dbWriteTable(DB, "mdEntity", mdEntity, append=TRUE, row.names=FALSE)
      
      
      # csw <- newXMLNode("GetRecordByIdResponse",
      #                   namespace="csw",
      #                   attrs=c("xsi:schemaLocation"="http://www.opengis.net/cat/csw/2.0.2 http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd"),
      #                   namespaceDefinitions=c("csw"="http://www.opengis.net/cat/csw/2.0.2",
      #                                          "dc"="http://purl.org/dc/elements/1.1/",
      #                                          "dct"="http://purl.org/dc/terms/",
      #                                          "gco"="http://www.isotc211.org/2005/gco",
      #                                          "gmd"="http://www.isotc211.org/2005/gmd",
      #                                          "gml"="http://www.opengis.net/gml",
      #                                          "ows"="http://www.opengis.net/ows",
      #                                          "xs"="http://www.w3.org/2001/XMLSchema",
      #                                          "xsi"="http://www.w3.org/2001/XMLSchema-instance"
      #                   )
      # )
      # MD_Metadata <- newXMLNode("MD_Metadata",
      #                           namespace="gmd",
      #                           attrs=c("xsi:schemaLocation"="http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx http://www.isotc211.org/2005/gmx/gmx.xsd"),
      #                           parent=csw)
      # fileIdentifier <- newXMLNode("fileIdentifier", namespace="gmd", parent=MD_Metadata)
      #   CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=fileIdentifier)
      #     addChildren(CharacterString, fileName)
      # language <- newXMLNode("language", namespace="gmd", parent=MD_Metadata)
      #   languageCode <- newXMLNode(name="LanguageCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd", "codeSpace"="ISO 639-2"), parent=language)
      #     addChildren(languageCode, input$mdEntity$vars[1])
      # characterSet <- newXMLNode("characterSet", namespace="gmd", parent=MD_Metadata)
      #   MD_CharacterSetCode <- newXMLNode(name="MD_CharacterSetCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd", "codeSpace"="ISO 639-2"), parent=characterSet)
      #     addChildren(MD_CharacterSetCode, input$mdEntity$vars[1])
    }
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

