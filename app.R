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

###*Define Variables####
source('variables.R')
source('kugi4.R')

###*Setting Up Interface####
ui <- source('interface.R')

###*Preparing Server#### 
server <- function(input, output, session) {
  ###*Connect to PostgreSQL Database####
  # driver <- PostgreSQL(max.con = 100)
  driver <- dbDriver("PostgreSQL")
  
  pg_user<-"postgres"
  pg_host<-"localhost"
  pg_port<-"5432"
  pg_pwd<-"root"
  
  pg_raw_db<-"rawdata"
  pg_md_db<-"metadata"
  pg_kugi_db<-"kugi"
  pg_comp_db<-"compilation"
  pg_igd_db<-"IGD"
  pg_int_db<-"integration"
  pg_sync_db<-"sync"
  pg_onemap_db<-"onemap"
  
  connectDB <- function(pg_db){
    tryCatch({
      dbConnect(driver, dbname=pg_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd )
    }, error=function(e){
      print("Database connection failed")
      return(FALSE)
    })
  }
  
  disconnectDB <- function(pg_db){
    dbDisconnect(pg_db)
  }
  
  countMetadataTbl <- function(){
    metadata<-connectDB(pg_md_db)
    return(dbGetQuery(metadata, "select count(id_metadata) from metadata;"))
    disconnectDB(metadata)
  }
  
  getMetadataTbl <- function(){
    # return(dbReadTable(DB, c("public", "metadata")))
    metadata<-connectDB(pg_md_db)
    return(dbGetQuery(metadata, "select file_identifier, individual_name, organisation_name from metadata;"))
    disconnectDB(metadata)
  }
  
  listOfTbl <- reactiveValues(metadata=getMetadataTbl(),
                              numOfMetadata=countMetadataTbl(),
                              recentMetadata=data.frame(),
                              recentValidityData=data.frame(),
                              tableKugi="",
                              recentTableWithKugi=data.frame(),
                              recentAttributeTable=NULL,
                              recentAttributeKugi=NULL,
                              listMatch=data.frame())
  
  output$slideshow <- renderSlickR({
    images <- list.files("www/slideshow/", pattern="j[0-9]", full.names=TRUE)
    slickR(images)
  })
  
  output$countData <- renderUI({
    tags$ul(class="list-group",
      tags$li(class="list-group-item", span(class="badge", listOfTbl$numOfMetadata$count), "Data Input"),
      tags$li(class="list-group-item", span(class="badge", 0), "Compilated Data")
    )
  })
  
  output$listOfKugi <- renderUI({
    selectInput("kugiName", "Katalog Unsur Geografi Indonesia", choices=sort(as.character(katalogdata[grep(input$shapeGeom, katalogdata$KUGI),])), selectize=FALSE)
  })
  
  output$listOfTopicCategory <- renderUI({
    selectInput(inputId=as.character(idInfoEntity$vars[13]), label=as.character(idInfoEntity$name[13]), choices=topiccategory$category, selectize=FALSE)
  })
  
  ###*Observe Shapefile Input####
  observe({
    inShp <- input$shpData
    inShpType <- inShp$type
    inShpPath <- inShp$datapath
    
    print(paste0("Shapefile location: ", inShpPath))
    
    if(is.null(inShp)){
      print("Shapefile.. NULL")
      val <- x_min <- x_max <- y_min <- y_max <- shp_dim <- shp_title <- ""
    } else {
      temp_dir <- dirname(inShpPath)
      unzip(inShpPath, exdir = temp_dir)
      file_shp <- dir(temp_dir, pattern="*.shp$")
      val <- str_remove(basename(file_shp), ".shp")
      shp_title <- val
      
      full_file_shp <- paste0(temp_dir, "/", val, ".shp")
      if(file.exists(full_file_shp)){
        shp_file <- readOGR(dsn = full_file_shp, layer = val)
        
        print("Topology.. Checking")
        if(clgeo_IsValid(shp_file)){
          print("Topology.. OK")
          # input to postgres
          # write to xml
          # print report
        } else {
          # collect invalid issue
          report_shp<-clgeo_CollectionReport(shp_file)
          
          # reset row numbers of original data
          shp_data <- shp_file@data
          row.names(shp_data) <- NULL
          
          # select FALSE validity
          print("Topology.. INVALID")
          shp_invalid <- report_shp[report_shp$valid==FALSE,]
          
          # merge shp_data with report_shp
          final_report_shp <- merge(shp_data, shp_invalid, by="row.names")
          listOfTbl$recentValidityData <- final_report_shp
          
          # clean topology
          print("Topology.. CLEANING")
          showModal(ui=modalDialog("Cleaning topology process. Please wait..", footer = NULL), session=session)
          running_time <- system.time({
            shp_file_clean <- clgeo_Clean(shp_file)
          })
          removeModal(session)
          print(running_time)
          
          # check projection
          print("Projection.. Checking")
          wgs84_proj <- CRS("+proj=longlat +datum=WGS84")
          shp_proj <- crs(shp_file_clean) 
          if(paste0(shp_proj) != paste0(wgs84_proj)){
            print("Projection.. TRANSFORM")
            shp_file <- spTransform(shp_file_clean, wgs84_proj)
          } else {
            print("Projection.. MATCH!")
            shp_file <- shp_file_clean
          }
          
        }        
        
        # get boundary box and dimension
        x_min <- bbox(shp_file)[1]
        y_min <- bbox(shp_file)[2]
        x_max <- bbox(shp_file)[3]
        y_max <- bbox(shp_file)[4]
        shp_dim <- dim(shp_file)[1]
        
        # insert shp to postgresql
        rawdata<-connectDB(pg_raw_db)
        kugi<-connectDB(pg_kugi_db)
        
        tableKugi <- tolower(unlist(strsplit(input$kugiName, " "))[1])
        insertShp <- tryCatch({ pgInsert(rawdata, tableKugi, shp_file) }, error=function(e){ return(FALSE) })
        if(insertShp){
          print("Shapefile has been imported into database")
          
          # mix and match data with kugi
          alterTableSQL <- paste0("ALTER TABLE ", tableKugi, " ")

          tableKugiInfo <- dbTableInfo(kugi, tableKugi)
          tblkugilen <- nrow(tableKugiInfo)-1
          
          for(i in 2:tblkugilen){
            nullable <- ""
            if(tableKugiInfo$is_nullable[i] == "NO") nullable <- " NOT NULL DEFAULT '0'" 
            
            datatype_length <- ""
            if(!is.na(tableKugiInfo$character_maximum_length[i])) datatype_length <- paste0("(", tableKugiInfo$character_maximum_length[i], ")")
            
            alterTableSQL <- paste0(alterTableSQL,
                                    "ADD COLUMN ",
                                    tableKugiInfo$column_name[i], " ",
                                    tableKugiInfo$data_type[i],
                                    datatype_length, 
                                    nullable
                                  )
            
            alterTableSQL <- ifelse(i != tblkugilen, paste0(alterTableSQL, ", "), paste0(alterTableSQL, ";"))
          }
          dbSendQuery(rawdata, alterTableSQL)
          val <- tableKugi
          
          disconnectDB(rawdata)
          disconnectDB(kugi)
        } else {
          print("Shapefile.. FAILED TO IMPORT")
          showModal(ui=modalDialog("Failed to upload. Please try again..", footer = NULL), session=session)
          removeModal(session)
          return()
        }
      } else {
        print("Shapefile doesn't exist")
        showModal(ui=modalDialog("Shapefile doesn't exist. Please try again..", footer = NULL), session=session)
        removeModal(session)        
        return()
      }
      
      val <- paste0(val, "_", format(Sys.time(), "%Y%m%d%H%M%S"))
    }

    updateTextInput(session, inputId=mdEntity$vars[1], value=val)
    updateTextInput(session, inputId=idInfoEntity$vars[14], value=x_min)
    updateTextInput(session, inputId=idInfoEntity$vars[15], value=x_max)
    updateTextInput(session, inputId=idInfoEntity$vars[16], value=y_min)
    updateTextInput(session, inputId=idInfoEntity$vars[17], value=y_max)
    updateTextInput(session, inputId=sriEntity$vars[3], value=shp_dim)
    updateTextInput(session, inputId=sriEntity$vars[4], value=paste0(x_min, ", ", y_max))
    updateTextInput(session, inputId=idInfoEntity$vars[2], value=shp_title)
    
  })
  
  ###*Observe Save Button Action####
  observeEvent(input$saveButton, {
    ###*Create New XML####
    csw <- newXMLNode("GetRecordByIdResponse",
      namespace="csw",
      attrs=c("xsi:schemaLocation"="http://www.opengis.net/cat/csw/2.0.2 http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd"),
      namespaceDefinitions=c(
        "csw"="http://www.opengis.net/cat/csw/2.0.2",
        "dc"="http://purl.org/dc/elements/1.1/",
        "dct"="http://purl.org/dc/terms/",
        "gco"="http://www.isotc211.org/2005/gco",
        "gmd"="http://www.isotc211.org/2005/gmd",
        "gml"="http://www.opengis.net/gml",
        "ows"="http://www.opengis.net/ows",
        "xs"="http://www.w3.org/2001/XMLSchema",
        "xsi"="http://www.w3.org/2001/XMLSchema-instance"
        )
      )

    ###MD_Metadata node####
    MD_Metadata <- newXMLNode("MD_Metadata",
      namespace="gmd",
      attrs=c("xsi:schemaLocation"="http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx http://www.isotc211.org/2005/gmx/gmx.xsd"),
      parent=csw)

      fileIdentifier <- newXMLNode("fileIdentifier", namespace="gmd", parent=MD_Metadata)
        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=fileIdentifier)
          addChildren(CharacterString, input$fileIdentifier)
          
      language <- newXMLNode("language", namespace="gmd", parent=MD_Metadata)
        languageCode <- newXMLNode(name="LanguageCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd", "codeSpace"="ISO 639-2"), parent=language)
          addChildren(languageCode, input$lang)
      
      characterSet <- newXMLNode("characterSet", namespace="gmd", parent=MD_Metadata)
        MD_CharacterSetCode <- newXMLNode(name="MD_CharacterSetCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode", "codeListValue"="utf8", "codeSpace"="ISOTC211/19115"), parent=characterSet)
          addChildren(MD_CharacterSetCode, input$charSet)
          
      hierarchyLvl <- newXMLNode("hierarchyLevel", namespace="gmd", parent=MD_Metadata)
        MD_ScopeCode <- newXMLNode(name="MD_ScopeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode", "codeListValue"="dataset", "codeSpace"="ISOTC211/19115"), parent=hierarchyLvl)
          addChildren(MD_ScopeCode, input$hieLvl)
      
      ###Contact Node####        
      contact <- newXMLNode("contact", namespace="gmd", parent=MD_Metadata)
        CI_ResponsibleParty <- newXMLNode(name="CI_ResponsibleParty", namespace="gmd", parent=contact)
          individualName <- newXMLNode(name="individualName", namespace="gmd", parent=contact)
            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=individualName)
              addChildren(CharacterString, input$indName)
          organisationName <- newXMLNode(name="organisationName", namespace="gmd", parent=contact)
            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=organisationName)
              addChildren(CharacterString, input$orgName)
          positionName <- newXMLNode(name="positionName", namespace="gmd", parent=contact)
            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=positionName)
              addChildren(CharacterString, input$posName)      
          contactInfo <- newXMLNode(name="contactInfo", namespace="gmd", parent=contact)
            CI_Contact <- newXMLNode(name="CI_Contact", namespace="gmd", parent=contactInfo)
              phoneContactInfo <- newXMLNode(name="phone", namespace="gmd", parent=CI_Contact)
                CI_Telephone <- newXMLNode(name="CI_Telephone", namespace="gmd", parent=phoneContactInfo)
                  voice <- newXMLNode(name="voice", namespace="gmd", parent=CI_Telephone)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=voice)
                      addChildren(CharacterString, input$phone) 
                  facsimile <- newXMLNode(name="facsimile", namespace="gmd", parent=CI_Telephone)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=facsimile)
                      addChildren(CharacterString, input$fax)
              addressContactInfo <- newXMLNode(name="address", namespace="gmd", parent=CI_Contact)
                CI_Address <- newXMLNode(name="CI_Address", namespace="gmd", parent=addressContactInfo)
                  deliveryPoint <- newXMLNode(name="deliveryPoint", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=deliveryPoint)
                      addChildren(CharacterString, input$delivPoint) 
                  cityAddress <- newXMLNode(name="city", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=cityAddress)
                      addChildren(CharacterString, input$city) 
                  administrativeArea <- newXMLNode(name="administrativeArea", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=administrativeArea)
                      addChildren(CharacterString, input$adminArea) 
                  postalCode <- newXMLNode(name="postalCode", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=postalCode)
                      addChildren(CharacterString, input$postCode) 
                  countryAddress <- newXMLNode(name="country", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=countryAddress)
                      addChildren(CharacterString, input$country) 
                  electronicMailAddress <- newXMLNode("electronicMailAddress", namespace="gmd", parent=CI_Address)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=electronicMailAddress)
                      addChildren(CharacterString, input$emailAdd) 
              onlineResource <- newXMLNode(name="onlineResource", namespace="gmd", parent=CI_Contact)
                CI_OnlineResource <- newXMLNode(name="CI_OnlineResource", namespace="gmd", parent=onlineResource)
                  linkageOnlineResource <- newXMLNode(name="linkage", namespace="gmd", parent=CI_OnlineResource)
                    linkageURL <- newXMLNode(name="URL", namespace="gmd", parent=linkageOnlineResource)
                      addChildren(linkageURL, input$linkage) 
                  protocolOnlineResource <- newXMLNode(name="protocol", namespace="gmd", parent=CI_OnlineResource)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolOnlineResource)
                      addChildren(CharacterString, input$protocol) 
                  functionOnlineResource <- newXMLNode(name="function", namespace="gmd", parent=CI_OnlineResource)
                    CI_OnLineFunctionCode <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="information", "codeSpace"="ISOTC211/19115"), parent=functionOnlineResource)
                      addChildren(CI_OnLineFunctionCode, input$contFunction) 
              hoursOfService <- newXMLNode(name="hoursOfService", namespace="gmd", parent=CI_Contact)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=hoursOfService)
                  addChildren(CharacterString, input$hOfService) 
              contactInstructions <- newXMLNode(name="contactInstructions", namespace="gmd", parent=CI_Contact)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=contactInstructions)
                  addChildren(CharacterString, input$contInstructions)         
          roleContact <- newXMLNode(name="role", namespace="gmd", parent=contact)
            CI_RoleCode <- newXMLNode(name="CI_RoleCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode", "codeListValue"="pointOfContact", "codeSpace"="ISOTC211/19115"), parent=roleContact)
              addChildren(CI_RoleCode, input$contRole)          

              
      dataStp <- newXMLNode("dateStamp", namespace="gmd", parent=MD_Metadata)
        DateTime <- newXMLNode(name="DateTime", namespace="gco", parent=dataStp)
          addChildren(DateTime, input$dateStamp)  
      
      metadataStandardName  <- newXMLNode("metadataStandardName", namespace="gmd", parent=MD_Metadata)
        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=metadataStandardName)
          addChildren(CharacterString, input$mdStdName)
        
      metadataStandardVersion  <- newXMLNode("metadataStandardVersion", namespace="gmd", parent=MD_Metadata)
        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=metadataStandardVersion)
          addChildren(CharacterString, input$mdStdVer)
            
      dataSetURI <- newXMLNode("dataSetURI", namespace="gmd", parent=MD_Metadata)
        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=dataSetURI)
          addChildren(CharacterString, input$mdDataSetURI)
      
      ###SpatialRepresentationInfo Node####        
      spatialRepresentationInfo  <- newXMLNode("spatialRepresentationInfo", namespace="gmd", parent=MD_Metadata) 
        MD_VectorSpatialRepresentation <- newXMLNode(name="MD_VectorSpatialRepresentation", namespace="gmd", parent=spatialRepresentationInfo)
          topologyLevel <- newXMLNode("topologyLevel", namespace="gmd", parent=MD_VectorSpatialRepresentation)
            MD_TopologyLevelCode <- newXMLNode(name="MD_TopologyLevelCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_TopologyLevelCode", "codeListValue"="geometryOnly", "codeSpace"="ISOTC211/19115"), parent=topologyLevel)
              addChildren(MD_TopologyLevelCode, input$topoLvl)
          geometricObjects <- newXMLNode("geometricObjects", namespace="gmd", parent=MD_VectorSpatialRepresentation)
            MD_GeometricObjects <- newXMLNode(name="MD_GeometricObjects", namespace="gmd", parent=geometricObjects)
              geometricObjectType <- newXMLNode(name="geometricObjectType", namespace="gmd", parent=MD_GeometricObjects)
                MD_GeometricObjectTypeCode <- newXMLNode(name="MD_GeometricObjectTypeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_GeometricObjectTypeCode", "codeListValue"="complex", "codeSpace"="ISOTC211/19115"), parent=geometricObjectType)
                  addChildren(MD_GeometricObjectTypeCode, input$geomObj)
      
      ###ReferenceSystemInfo Node####                
      referenceSystemInfo <- newXMLNode("referenceSystemInfo", namespace="gmd", parent=MD_Metadata)
        MD_ReferenceSystem <- newXMLNode(name="MD_ReferenceSystem", namespace="gmd", parent=referenceSystemInfo)
          referenceSystemIdentifier <- newXMLNode(name="referenceSystemIdentifier", namespace="gmd", parent=MD_ReferenceSystem)
            RS_Identifier <- newXMLNode(name="RS_Identifier", namespace="gmd", parent=referenceSystemIdentifier)
              authorityRSI <- newXMLNode(name="authority", namespace="gmd", parent=RS_Identifier)
                CI_Citation <- newXMLNode(name="CI_Citation", namespace="gmd", parent=authorityRSI)
                  titleAut <- newXMLNode(name="title", namespace="gmd", parent=CI_Citation)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=titleAut)
                      addChildren(CharacterString, input$rsTitle)        
                  dateAut <- newXMLNode(name="date", namespace="gmd", parent=CI_Citation)
                    CI_Date <- newXMLNode(name="CI_Date", namespace="gmd", parent=dateAut)
                      dateDateAut <- newXMLNode(name="date", namespace="gmd", parent=CI_Date)
                        dateCS <- newXMLNode(name="Date", namespace="gco", parent=dateDateAut)
                          addChildren(dateCS, input$rsDate)
                      dateTypeDateAut <- newXMLNode(name="dateType", namespace="gmd", parent=CI_Date)
                        CI_DateTypeCode <- newXMLNode(name="CI_DateTypeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode", "codeListValue"="publication", "codeSpace"="ISOTC211/19115"), parent=dateTypeDateAut)
                          addChildren(CI_DateTypeCode, input$rsDateType)
                  citedResponsibleParty <- newXMLNode(name="citedResponsibleParty", namespace="gmd", parent=CI_Citation)
                    CI_ResponsiblePartyRSI<- newXMLNode(name="CI_ResponsibleParty", namespace="gmd", parent=citedResponsibleParty)
                      organisationNameRSI <- newXMLNode(name="organisationName", namespace="gmd", parent=CI_ResponsiblePartyRSI)
                        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=organisationNameRSI)
                          addChildren(CharacterString, input$rsOrgName)                       
                      contactInfoRSI <- newXMLNode(name="contactInfo", namespace="gmd", parent=CI_ResponsiblePartyRSI)
                        CI_ContactRSI <- newXMLNode(name="CI_Contact", namespace="gmd", parent=contactInfoRSI)
                          onlineResourceRSI <- newXMLNode(name="onlineResource", namespace="gmd", parent=CI_ContactRSI)
                            CI_OnlineResourceRSI <- newXMLNode(name="CI_OnlineResource", namespace="gmd", parent=onlineResourceRSI)
                              linkageRSI <- newXMLNode(name="linkage", namespace="gmd", parent=CI_OnlineResourceRSI)
                                URLRSI <- newXMLNode(name="URL", namespace="gmd", parent=linkageRSI)
                                  addChildren(URLRSI, input$rsLinkage) 
                      roleRSI <- newXMLNode(name="role", namespace="gmd", parent=CI_ResponsiblePartyRSI)
                        CI_RoleCode <- newXMLNode(name="CI_RoleCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode", "codeListValue"="originator", "codeSpace"="ISOTC211/19115"), parent=roleRSI)
                          addChildren(CI_RoleCode, input$rsRole) 
              codeRSI <- newXMLNode(name="code", namespace="gmd", parent=RS_Identifier)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=codeRSI)
                  addChildren(CharacterString, input$rsCode)
              versionRSI <- newXMLNode(name="version", namespace="gmd", parent=RS_Identifier)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=versionRSI)
                  addChildren(CharacterString, input$rsVersion)              

      ###IdentificationInfo Node####            
      identificationInfo <- newXMLNode("identificationInfo", namespace="gmd", parent=MD_Metadata)
        MD_DataIdentification <- newXMLNode(name="MD_DataIdentification", namespace="gmd", parent=identificationInfo)
          citationII <- newXMLNode(name="citation", namespace="gmd", parent=MD_DataIdentification)
            CI_CitationII <- newXMLNode(name="CI_Citation", namespace="gmd", parent=citationII)
              titleII <- newXMLNode(name="title", namespace="gmd", parent=CI_CitationII)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=titleII)
                  addChildren(CharacterString, input$iiTitle)
              dateII <- newXMLNode(name="date", namespace="gmd", parent=CI_CitationII)
                CI_DateII <- newXMLNode(name="CI_Date", namespace="gmd", parent=dateII)
                  dateCI_DateII <- newXMLNode(name="date", namespace="gmd", parent=CI_DateII)
                    DateTimeDate <- newXMLNode(name="DateTime", namespace="gco", parent=dateCI_DateII)
                      addChildren(DateTimeDate, input$iiDate)              
                  dateTypeCI_DateII <- newXMLNode(name="dateType", namespace="gmd", parent=CI_DateII)
                    CI_DateTypeCodeII <- newXMLNode(name="CI_DateTypeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode", "codeListValue"="publication", "codeSpace"="ISOTC211/19115"), parent=dateTypeCI_DateII)
                      addChildren(CI_DateTypeCodeII, input$iiDateType)
          abstractII <- newXMLNode(name="abstract", namespace="gmd", parent=MD_DataIdentification)
            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=abstractII)
              addChildren(CharacterString, input$iiAbstract)
          statusII <- newXMLNode(name="status", namespace="gmd", parent=MD_DataIdentification)
            MD_ProgressCode <- newXMLNode(name="MD_ProgressCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ProgressCode", "codeListValue"="", "codeSpace"="ISOTC211/19115"), parent=statusII)
          resourceMaintenanceII <- newXMLNode(name="resourceMaintenance", namespace="gmd", parent=MD_DataIdentification)
            MD_MaintenanceInformation <- newXMLNode(name="MD_MaintenanceInformation", namespace="gmd", parent=resourceMaintenanceII)
              maintenanceAndUpdateFrequency <- newXMLNode(name="maintenanceAndUpdateFrequency", namespace="gmd", parent=MD_MaintenanceInformation)
                MD_MaintenanceFrequencyCode <- newXMLNode(name="MD_MaintenanceFrequencyCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode", "codeListValue"="asNeeded", "codeSpace"="ISOTC211/19115"), parent=maintenanceAndUpdateFrequency)
                  addChildren(MD_MaintenanceFrequencyCode, input$iiResMaintenance)
          descriptiveKeywordsII <- newXMLNode(name="descriptiveKeywords", namespace="gmd", parent=MD_DataIdentification)
            MD_Keywords <- newXMLNode(name="MD_Keywords", namespace="gmd", parent=descriptiveKeywordsII)
              keywordDK <- newXMLNode(name="keyword", namespace="gmd", attrs=c("xsi:type"="gmd:PT_FreeText_PropertyType"), parent=MD_Keywords)
                CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=keywordDK)
                  addChildren(CharacterString, input$iiDescKey)
                PT_FreeText <- newXMLNode(name="PT_FreeText", namespace="gmd", parent=keywordDK)
                  textGroup <- newXMLNode(name="textGroup", namespace="gmd", parent=PT_FreeText)
                    LocalisedCharacterString <- newXMLNode(name="LocalisedCharacterString", namespace="gmd", attrs=c("locale"="#locale-"), parent=PT_FreeText)
              typeDK <- newXMLNode(name="type", namespace="gmd", parent=MD_Keywords)
                MD_KeywordTypeCode <- newXMLNode(name="MD_KeywordTypeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode", "codeListValue"="", "codeSpace"="ISOTC211/19115"), parent=typeDK)
          resourceConstraintsII <- newXMLNode(name="resourceConstraints", namespace="gmd", parent=MD_DataIdentification)
            MD_LegalConstraints <- newXMLNode(name="MD_LegalConstraints", namespace="gmd", parent=resourceConstraintsII)
              accessConstraints <- newXMLNode(name="accessConstraints", namespace="gmd", parent=MD_LegalConstraints)
                MD_RestrictionCode <- newXMLNode(name="MD_RestrictionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode", "codeListValue"="otherRestrictions", "codeSpace"="ISOTC211/19115"), parent=accessConstraints)
                  addChildren(MD_RestrictionCode, input$iiResCons)    
          spatialRepresentationTypeII <- newXMLNode(name="spatialRepresentationType", namespace="gmd", parent=MD_DataIdentification)
            MD_SpatialRepresentationTypeCode <- newXMLNode(name="MD_SpatialRepresentationTypeCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_SpatialRepresentationTypeCode", "codeListValue"="vector", "codeSpace"="ISOTC211/19115"), parent=spatialRepresentationTypeII)
              addChildren(MD_SpatialRepresentationTypeCode, input$iiSpatRepType)         
          languageII <- newXMLNode(name="language", namespace="gmd", parent=MD_DataIdentification)
            LanguageCodeII <- newXMLNode(name="LanguageCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="ind", "codeSpace"="ISO 639-2"), parent=languageII)
              addChildren(LanguageCodeII, input$iiLangIdent)        
          characterSetII <- newXMLNode(name="characterSet", namespace="gmd", parent=MD_DataIdentification)
            MD_CharacterSetCode <- newXMLNode(name="MD_CharacterSetCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode", "codeListValue"="utf8", "codeSpace"="ISOTC211/19115"), parent=characterSetII)
              addChildren(MD_CharacterSetCode, input$iiCharSetCode)
          topicCategoryII <- newXMLNode(name="topicCategory", namespace="gmd", parent=MD_DataIdentification)
            MD_TopicCategoryCode <- newXMLNode(name="MD_TopicCategoryCode", namespace="gmd", parent=topicCategoryII)
              addChildren(MD_TopicCategoryCode, input$iiTopicCat)
          extentII <- newXMLNode(name="extent", namespace="gmd", parent=MD_DataIdentification)
            EX_Extent <- newXMLNode(name="EX_Extent", namespace="gmd", parent=extentII)
              geographicElement <- newXMLNode(name="geographicElement", namespace="gmd", parent=EX_Extent)
                EX_GeographicBoundingBox <- newXMLNode(name="EX_GeographicBoundingBox", namespace="gmd", parent=geographicElement)
                  extentTypeCode <- newXMLNode(name="extentTypeCode", namespace="gmd", parent=EX_GeographicBoundingBox)
                    extentTypeCodeBoolean <- newXMLNode(name="Boolean", namespace="gco", parent=extentTypeCode)
                      addChildren(extentTypeCodeBoolean, "1")                
                  westBoundLongitude <- newXMLNode(name="westBoundLongitude", namespace="gmd", parent=EX_GeographicBoundingBox)
                    westBoundLongitudeDecimal <- newXMLNode(name="Decimal", namespace="gco", parent=westBoundLongitude)
                      addChildren(westBoundLongitudeDecimal, input$westBoundLong)         
                  eastBoundLongitude <- newXMLNode(name="eastBoundLongitude", namespace="gmd", parent=EX_GeographicBoundingBox)
                    eastBoundLongitudeDecimal <- newXMLNode(name="Decimal", namespace="gco", parent=eastBoundLongitude)
                      addChildren(eastBoundLongitudeDecimal, input$eastBoundLong)
                  southBoundLatitude <- newXMLNode(name="southBoundLatitude", namespace="gmd", parent=EX_GeographicBoundingBox)
                    southBoundLatitudeDecimal <- newXMLNode(name="Decimal", namespace="gco", parent=southBoundLatitude)
                      addChildren(southBoundLatitudeDecimal, input$southBoundLat)
                  northBoundLatitude <- newXMLNode(name="northBoundLatitude", namespace="gmd", parent=EX_GeographicBoundingBox)
                    northBoundLatitudeDecimal <- newXMLNode(name="Decimal", namespace="gco", parent=northBoundLatitude)
                      addChildren(northBoundLatitudeDecimal, input$northBoundLat)
              temporalElement <- newXMLNode(name="temporalElement", namespace="gmd", parent=EX_Extent)
                EX_TemporalExtent <- newXMLNode(name="EX_TemporalExtent", namespace="gmd", parent=temporalElement)
                  extentTemporalElement <- newXMLNode(name="extent", namespace="gmd", parent=EX_TemporalExtent)
                    timePeriodTemporalElement <- newXMLNode(name="TimePeriod", namespace="gml", attrs=c("gml:id"="T001"), parent=extentTemporalElement)
                      beginPositionTemporalElement <- newXMLNode(name="beginPosition", namespace="gml", parent=timePeriodTemporalElement)
                      endPositionTemporalElement <- newXMLNode(name="endPosition", namespace="gml", parent=timePeriodTemporalElement)
      
      ###DistributionInfo Node####                                  
      distributionInfo <- newXMLNode("distributionInfo", namespace="gmd", parent=MD_Metadata)
        MD_Distribution <- newXMLNode("MD_Distribution", namespace="gmd", parent=distributionInfo)
          distributorDI <- newXMLNode("distributor", namespace="gmd", parent=MD_Distribution)
            MD_Distributor <- newXMLNode("MD_Distributor", namespace="gmd", parent=distributorDI)
              distributorContact <- newXMLNode("distributorContact", namespace="gmd", parent=MD_Distributor)
                CI_ResponsiblePartyDI <- newXMLNode("CI_ResponsibleParty", namespace="gmd", attrs=c("id"="contact-distributor"), parent=distributorContact)
                  individualNameDI <- newXMLNode(name="individualName", namespace="gmd", parent=CI_ResponsiblePartyDI)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=individualNameDI)
                      addChildren(CharacterString, input$dIndName)
                  organisationNameDI <- newXMLNode(name="organisationName", namespace="gmd", parent=CI_ResponsiblePartyDI)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=organisationNameDI)
                      addChildren(CharacterString, input$dOrgName)
                  positionNameDI <- newXMLNode(name="positionName", namespace="gmd", parent=CI_ResponsiblePartyDI)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=positionNameDI)
                      addChildren(CharacterString, input$dPosName)      
                  contactInfoDI <- newXMLNode(name="contactInfo", namespace="gmd", parent=CI_ResponsiblePartyDI)
                    CI_ContactDI <- newXMLNode(name="CI_Contact", namespace="gmd", parent=contactInfoDI)
                      phoneContactInfoDI <- newXMLNode(name="phone", namespace="gmd", parent=CI_ContactDI)
                        CI_TelephoneDI <- newXMLNode(name="CI_Telephone", namespace="gmd", parent=phoneContactInfoDI)
                          voiceDI <- newXMLNode(name="voice", namespace="gmd", parent=CI_TelephoneDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=voiceDI)
                              addChildren(CharacterString, input$dPhone) 
                          facsimileDI <- newXMLNode(name="facsimile", namespace="gmd", parent=CI_TelephoneDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=facsimileDI)
                              addChildren(CharacterString, input$dFax) 
                      addressContactInfoDI <- newXMLNode(name="address", namespace="gmd", parent=CI_ContactDI)
                        CI_AddressDI <- newXMLNode(name="CI_Address", namespace="gmd", parent=addressContactInfoDI)
                          deliveryPointDI <- newXMLNode(name="deliveryPoint", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=deliveryPointDI)
                              addChildren(CharacterString, input$dDelivPoint) 
                          cityAddressDI <- newXMLNode(name="city", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=cityAddressDI)
                              addChildren(CharacterString, input$dCity) 
                          administrativeAreaDI <- newXMLNode(name="administrativeArea", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=administrativeAreaDI)
                              addChildren(CharacterString, input$dAdminArea) 
                          postalCodeDI <- newXMLNode(name="postalCode", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=postalCodeDI)
                              addChildren(CharacterString, input$dPostCode) 
                          countryAddressDI <- newXMLNode(name="country", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=countryAddressDI)
                              addChildren(CharacterString, input$dCountry) 
                          electronicMailAddressDI <- newXMLNode(name="electronicMailAddress", namespace="gmd", parent=CI_AddressDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=electronicMailAddressDI)
                              addChildren(CharacterString, input$dEmailAdd) 
                      onlineResourceDI <- newXMLNode(name="onlineResource", namespace="gmd", parent=CI_ContactDI)
                        CI_OnlineResourceDI <- newXMLNode(name="CI_OnlineResource", namespace="gmd", parent=onlineResourceDI)
                          linkageOnlineResourceDI <- newXMLNode(name="linkage", namespace="gmd", parent=CI_OnlineResourceDI)
                            linkageURLDI <- newXMLNode(name="URL", namespace="gmd", parent=linkageOnlineResourceDI)
                              addChildren(linkageURLDI, input$dLinkage) 
                          protocolOnlineResourceDI <- newXMLNode(name="protocol", namespace="gmd", parent=CI_OnlineResourceDI)
                            CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolOnlineResourceDI)
                              addChildren(CharacterString, input$dProtocol) 
                          functionOnlineResourceDI <- newXMLNode(name="function", namespace="gmd", parent=CI_OnlineResourceDI)
                            CI_OnLineFunctionCodeDI <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="information", "codeSpace"="ISOTC211/19115"), parent=functionOnlineResourceDI)
                              addChildren(CI_OnLineFunctionCodeDI, input$dFunction) 
                      hoursOfServiceDI <- newXMLNode(name="hoursOfService", namespace="gmd", parent=CI_ContactDI)
                        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=hoursOfServiceDI)
                          addChildren(CharacterString, input$dHOfService) 
                      contactInstructionsDI <- newXMLNode(name="contactInstructions", namespace="gmd", parent=CI_ContactDI)
                        CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=contactInstructionsDI)
                          addChildren(CharacterString, input$dContInstructions)         
                  roleContactDI <- newXMLNode(name="role", namespace="gmd", parent=CI_ResponsiblePartyDI)
                    CI_RoleCodeDI <- newXMLNode(name="CI_RoleCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode", "codeListValue"="pointOfContact", "codeSpace"="ISOTC211/19115"), parent=roleContactDI)
                      addChildren(CI_RoleCodeDI, input$dRole)
          ###TransferOptions Node####
          transferOptionsDI <- newXMLNode("transferOptions", namespace="gmd", parent=MD_Distribution)
            MD_DigitalTransferOptions <- newXMLNode("MD_DigitalTransferOptions", namespace="gmd", parent=transferOptionsDI)
              onlineWFS <- newXMLNode("MD_DigitalTransferOptions", namespace="gmd", parent=MD_DigitalTransferOptions)
                CI_OnlineResourceWFS <- newXMLNode("CI_OnlineResource", namespace="gmd", parent=onlineWFS)
                  linkageWFS <- newXMLNode("linkage", namespace="gmd", parent=CI_OnlineResourceWFS)
                    URLWFS <- newXMLNode(name="URL", namespace="gmd", parent=linkageWFS)
                      addChildren(URLWFS, input$WFSLinkage)
                  protocolWFS <- newXMLNode("protocol", namespace="gmd", parent=CI_OnlineResourceWFS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolWFS)
                      addChildren(CharacterString, input$WFSProtocol)
                  nameWFS <- newXMLNode("name", namespace="gmd", parent=CI_OnlineResourceWFS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=nameWFS)
                      addChildren(CharacterString, input$WFSName)
                  descriptionWFS <- newXMLNode("description", namespace="gmd", parent=CI_OnlineResourceWFS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=descriptionWFS)
                      addChildren(CharacterString, input$WFSDesc)
                  functionWFS <- newXMLNode("function", namespace="gmd", parent=CI_OnlineResourceWFS)
                    CI_OnLineFunctionCodeWFS <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="download", "codeSpace"="ISOTC211/19115"), parent=functionWFS)
                      addChildren(CI_OnLineFunctionCodeWFS, input$WFSFunc)
              onlineWMS <- newXMLNode("MD_DigitalTransferOptions", namespace="gmd", parent=MD_DigitalTransferOptions)
                CI_OnlineResourceWMS <- newXMLNode("CI_OnlineResource", namespace="gmd", parent=onlineWMS)
                  linkageWMS <- newXMLNode("linkage", namespace="gmd", parent=CI_OnlineResourceWMS)
                    URLWMS <- newXMLNode(name="URL", namespace="gmd", parent=linkageWMS)
                      addChildren(URLWMS, input$WMSLinkage)
                  protocolWMS <- newXMLNode("protocol", namespace="gmd", parent=CI_OnlineResourceWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolWMS)
                      addChildren(CharacterString, input$WMSProtocol)
                  nameWMS <- newXMLNode("name", namespace="gmd", parent=CI_OnlineResourceWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=nameWMS)
                      addChildren(CharacterString, input$WMSName)
                  descriptionWMS <- newXMLNode("description", namespace="gmd", parent=CI_OnlineResourceWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=descriptionWMS)
                      addChildren(CharacterString, input$WMSDesc)
                  functionWMS <- newXMLNode("function", namespace="gmd", parent=CI_OnlineResourceWMS)
                    CI_OnLineFunctionCodeWMS <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="download", "codeSpace"="ISOTC211/19115"), parent=functionWMS)
                      addChildren(CI_OnLineFunctionCodeWMS, input$WMSFunc)
              onlineZIP <- newXMLNode("MD_DigitalTransferOptions", namespace="gmd", parent=MD_DigitalTransferOptions)
                CI_OnlineResourceZIP <- newXMLNode("CI_OnlineResource", namespace="gmd", parent=onlineZIP)
                  linkageZIP <- newXMLNode("linkage", namespace="gmd", parent=CI_OnlineResourceZIP)
                    URLZIP <- newXMLNode(name="URL", namespace="gmd", parent=linkageZIP)
                      addChildren(URLZIP, input$ZIPLinkage)
                  protocolZIP <- newXMLNode("protocol", namespace="gmd", parent=CI_OnlineResourceZIP)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolZIP)
                      addChildren(CharacterString, input$ZIPProtocol)
                  nameZIP <- newXMLNode("name", namespace="gmd", parent=CI_OnlineResourceZIP)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=nameZIP)
                      addChildren(CharacterString, input$ZIPName)
                  descriptionZIP <- newXMLNode("description", namespace="gmd", parent=CI_OnlineResourceZIP)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=descriptionZIP)
                      addChildren(CharacterString, input$ZIPDesc)
                  functionZIP <- newXMLNode("function", namespace="gmd", parent=CI_OnlineResourceZIP)
                    CI_OnLineFunctionCodeZIP <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="download", "codeSpace"="ISOTC211/19115"), parent=functionZIP)
                      addChildren(CI_OnLineFunctionCodeZIP, input$ZIPFunc)
              onlineImgWMS <- newXMLNode("MD_DigitalTransferOptions", namespace="gmd", parent=MD_DigitalTransferOptions)
                CI_OnlineResourceImgWMS <- newXMLNode("CI_OnlineResource", namespace="gmd", parent=onlineImgWMS)
                  linkageImgWMS <- newXMLNode("linkage", namespace="gmd", parent=CI_OnlineResourceImgWMS)
                    URLImgWMS <- newXMLNode(name="URL", namespace="gmd", parent=linkageImgWMS)
                      addChildren(URLImgWMS, input$IWMSLinkage)
                  protocolImgWMS <- newXMLNode("protocol", namespace="gmd", parent=CI_OnlineResourceImgWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=protocolImgWMS)
                      addChildren(CharacterString, input$IWMSProtocol)
                  nameImgWMS <- newXMLNode("name", namespace="gmd", parent=CI_OnlineResourceImgWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=nameImgWMS)
                      addChildren(CharacterString, input$IWMSName)
                  descriptionImgWMS <- newXMLNode("description", namespace="gmd", parent=CI_OnlineResourceImgWMS)
                    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=descriptionImgWMS)
                      addChildren(CharacterString, input$IWMSDesc)
                  functionImgWMS <- newXMLNode("function", namespace="gmd", parent=CI_OnlineResourceImgWMS)
                    CI_OnLineFunctionCodeImgWMS <- newXMLNode(name="CI_OnLineFunctionCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode", "codeListValue"="download", "codeSpace"="ISOTC211/19115"), parent=functionImgWMS)
                      addChildren(CI_OnLineFunctionCodeImgWMS, input$IWMSFunc)
      
      ###MetadataMaintenance Node####
      metadataMaintenance <- newXMLNode("metadataMaintenance", namespace="gmd", parent=MD_Metadata)    
        MD_MaintenanceInformation <- newXMLNode(name="MD_MaintenanceInformation", namespace="gmd", parent=metadataMaintenance)
        maintenanceAndUpdateFrequency <- newXMLNode(name="maintenanceAndUpdateFrequency", namespace="gmd", parent=MD_MaintenanceInformation)
          MD_MaintenanceFrequencyCode <- newXMLNode(name="MD_MaintenanceFrequencyCode", namespace="gmd", attrs=c("codeList"="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode", "codeListValue"="asNeeded", "codeSpace"="ISOTC211/19115"), parent=maintenanceAndUpdateFrequency)
            addChildren(MD_MaintenanceFrequencyCode, input$updFreq)
        maintenanceNote <- newXMLNode(name="maintenanceNote", namespace="gmd", parent=MD_MaintenanceInformation)
          CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=maintenanceNote)
            addChildren(CharacterString, input$note)
      
      ###MetadataConstraints Node####
      metadataConstraints <- newXMLNode("metadataConstraints", namespace="gmd", parent=MD_Metadata)
        MD_SecurityConstraints <- newXMLNode(name="MD_SecurityConstraints", namespace="gmd", parent=metadataConstraints)
        classification <- newXMLNode(name="classification", namespace="gmd", parent=MD_SecurityConstraints)
          MD_ClassClassificationCode <- newXMLNode(name="MD_ClassClassificationCode", namespace="gmd", attrs=c("codeList"="http://idec.icc.cat/schema/Codelist/ML_gmxCodelists.xml", "codeListValue"="restricted"), parent=classification)
        userNt <- newXMLNode(name="userNote", namespace="gmd", parent=MD_SecurityConstraints)
          CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=userNt)
            addChildren(CharacterString, input$userNote)                          
                                            
    ###*Write Input Into XMLs####          
    saveXML(csw, file="metadata.xml", encoding="UTF-8", indent=T)

    ###*Insert Table Metadata####
    tblMetadata <- data.frame(
      id_metadata=listOfTbl$numOfMetadata$count+1,
      file_identifier=input$fileIdentifier,
      lang=input$lang,
      character_set=input$charSet,
      hierarchy_level=input$hieLvl,
      md_std_name=input$mdStdName,
      md_std_ver=input$mdStdVer,
      date_stamp=input$dateStamp,
      data_set_uri=input$mdDataSetURI,
      individual_name=input$indName,
      organisation_name=input$orgName,
      position_name=input$posName,
      phone=input$phone,
      faximile=input$fax,
      delivery_point=input$delivPoint,
      city=input$city,
      admin_area=input$adminArea,
      postal_code=input$postCode,
      country=input$country,
      email_address=input$emailAdd,
      linkage=input$linkage,
      protocol=input$protocol,
      contact_function=input$contFunction,
      hours_of_service=input$hOfService,
      contact_instructions=input$contInstructions,
      contact_role=input$contRole,
      topology_level=input$topoLvl,
      geometry_objects=input$geomObj,
      num_of_dim='',
      corner_points='',
      point_in_pixel='',
      axis_dim_prop='',
      dim_name='',
      dim_size='',
      cell_geometry='',
      check_point_avail='',
      control_point_avail='',
      georef_parameters='',
      object_type='',
      rs_title=input$rsTitle,
      rs_date=input$rsDate,
      rs_date_type=input$rsDateType,
      rs_org_name=input$rsOrgName,
      rs_linkage=input$rsLinkage,
      rs_role=input$rsRole,
      rs_code=input$rsCode,
      rs_version=input$rsVersion,
      rs_name='',
      rs_crs='',
      rs_semi_major_axis='',
      rs_axis_unit='',
      ii_citation='',
      ii_title=input$iiTitle,
      ii_date=input$iiDate,
      ii_date_type=input$iiDateType,
      ii_abstract=input$iiAbstract,
      ii_res_maintenance=input$iiResMaintenance,
      ii_desc_keywords=input$iiDescKey,
      ii_spat_resolution='',
      ii_res_const=input$iiResCons,
      ii_spat_rep_type=input$iiSpatRepType,
      ii_lang_id=input$iiLangIdent,
      ii_char_set_code=input$iiCharSetCode,
      ii_topic_category=input$iiTopicCat,
      ii_west_bound_long=input$westBoundLong,
      ii_east_bound_long=input$eastBoundLong,
      ii_south_bound_lat=input$southBoundLat,
      ii_north_bound_lat=input$northBoundLat,
      d_individual_name=input$dIndName,
      d_organisation_name=input$dOrgName,
      d_position_name=input$dPosName,
      d_phone=input$dPhone,
      d_faximile=input$dFax,
      d_delivery_point=input$dDelivPoint,
      d_city=input$dCity,
      d_admin_area=input$dAdminArea,
      d_postal_code=input$dPostCode,
      d_country=input$dCountry,
      d_email_address=input$dEmailAdd,
      d_linkage=input$dLinkage,
      d_protocol=input$dProtocol,
      d_contact_function=input$dFunction,
      d_hours_of_service=input$dHOfService,
      d_contact_instructions=input$dContInstructions,
      d_contact_role=input$dRole,
      to_wfs_linkage=input$WFSLinkage,
      to_wfs_protocol=input$WFSProtocol,
      to_wfs_name=input$WFSName,
      to_wfs_desc=input$WFSDesc,
      to_wfs_function=input$WFSFunc,
      to_wms_linkage=input$WMSLinkage,
      to_wms_protocol=input$WMSProtocol,
      to_wms_name=input$WMSName,
      to_wms_desc=input$WMSDesc,
      to_wms_function=input$WMSFunc,
      to_zip_linkage=input$ZIPLinkage,
      to_zip_protocol=input$ZIPProtocol,
      to_zip_name=input$ZIPName,
      to_zip_desc=input$ZIPDesc,
      to_zip_function=input$ZIPFunc,
      to_iwms_linkage=input$IWMSLinkage,
      to_iwms_protocol=input$IWMSProtocol,
      to_iwms_name=input$IWMSName,
      to_iwms_desc=input$IWMSDesc,
      to_iwms_function=input$IWMSFunc,
      maintenance_updatefreq='',
      maintenance_note='',
      user_note=input$userNote,
      row.names=NULL
    )
           
    md<-connectDB(pg_md_db)             
    dbWriteTable(md, "metadata", tblMetadata, append=TRUE, row.names=FALSE)
    listOfTbl$recentMetadata <- tblMetadata
    listOfTbl$metadata <- getMetadataTbl()
    listOfTbl$numOfMetadata <- countMetadataTbl()
    disconnectDB(md)
    updateTabsetPanel(session, "compilationApps", selected="tabData")
  })
  
  output$reportMetadata <- downloadHandler(
    filename = "metadata.csv",
    content = function(file) {
      write.table(t(listOfTbl$recentMetadata), file, quote=FALSE, sep=",")
    }
  )
  
  output$reportTopology <- downloadHandler(
    filename = "topology.csv",
    content = function(file) {
      write.table(listOfTbl$recentValidityData, file, quote=FALSE, sep=",")
    }
  )
  
  ###*DATA Page####
  output$comp_data <- renderDataTable({
    metadata <- listOfTbl$metadata
    # metadata$URL <- paste0('<u>Edit Attribute Data</u>')
    datatable(metadata, selection="none", class = 'cell-border strip hover', escape=F) %>% formatStyle(1, cursor = 'pointer')
  })

  observeEvent(input$comp_data_cell_clicked, {
    info <- input$comp_data_cell_clicked
    # print(info)
    # do nothing if not clicked yet, or the clicked cell is not in the 1st column
    # $`row`
    # $col
    # $value
    if (is.null(info$value) || info$col != 1) return()
    updateTabsetPanel(session, "compilationApps", selected="tabEditKugi")
    listOfTbl$tableKugi <-  paste0(tolower(unlist(strsplit(info$value, "k_"))[1]), "k")
    
    kugiName <- listOfTbl$tableKugi
    if(kugiName == "") return()
    
    # else 
    rawdata<-connectDB(pg_raw_db)
    kugi<-connectDB(pg_kugi_db)
    
    spatialKugi <- pgGetGeom(rawdata, c("public", kugiName))
    listOfTbl$recentTableWithKugi <- spatialKugi@data
    
    spatialKugiInfo <- dbTableInfo(rawdata, c("public", kugiName))
    listOfTbl$recentAttributeTable <- spatialKugiInfo$column_name
    
    kugiInfo <- dbTableInfo(kugi, c("public", kugiName))
    listOfTbl$recentAttributeKugi <- kugiInfo$column_name
    
    disconnectDB(rawdata)
    disconnectDB(kugi)
  })
  
  ###*KUGI Page####
  output$rawTitle <- renderText({
    paste0("Selected data: ", listOfTbl$tableKugi)
  })
  
  output$editAttribute <- renderDataTable({
    # recentTableWithKugi <- listOfTbl$recentTableWithKugi
    datatable(listOfTbl$recentTableWithKugi, editable=TRUE, options=list(scrollX = TRUE))
  })
  
  output$listOfShpColumn <- renderUI({
    # recentAttributeTable <- listOfTbl$recentAttributeTable 
    selectInput("shpAttrib", "Kolom atribut data original", choices=listOfTbl$recentAttributeTable, selectize=FALSE)
  })
  
  output$listOfKugiAttrib <- renderUI({
    # recentAttributeKugi <- listOfTbl$recentAttributeKugi 
    selectInput("kugiAttrib", "Kolom atribut KUGI", choices=listOfTbl$recentAttributeKugi, selectize=FALSE)
  })
  
  observeEvent(input$matchButton, {
    kugiAttrib <- input$kugiAttrib
    shpAttrib <- input$shpAttrib
    
    # move value to kugi field from old field
    eval(parse(text=paste0("listOfTbl$recentTableWithKugi$", kugiAttrib, " <- listOfTbl$recentTableWithKugi$", shpAttrib)))

    # remove old field
    eval(parse(text=paste0("listOfTbl$recentTableWithKugi$", shpAttrib, " <- NULL")))
    
    # remove value from list of char
    listOfTbl$recentAttributeTable <- listOfTbl$recentAttributeTable[listOfTbl$recentAttributeTable != shpAttrib]
    
    # list all of updated match and removed match 
    listMatch <- data.frame(kugi=kugiAttrib, shp=shpAttrib)
    listOfTbl$listMatch <- rbind(listOfTbl$listMatch, listMatch)
  })
  
  observeEvent(input$finishMatchButton, {
    # update & alter table
    # - update attr
    #   send query: update toponimi_pt_50k set alias = "TOPONIMI"; 
    # - kumpulin list yg di remove
    #   send query: alter table toponimi_pt_50k drop column "TOPONIMI"
    # - insert data to compilated data
    # - drop data from rawdata
    
    tableName <- listOfTbl$tableKugi
    listMatch <- listOfTbl$listMatch
    print(listMatch)
    
    data_len <- nrow(listMatch)
  
    raw <- connectDB(pg_raw_db)
    for(i in 1:data_len){
      
      # updateTableQuery <- paste0("UPDATE ", tableName, " SET ", listMatch$kugi[i], " = \"", listMatch$shp[i], "\"")
      # print(updateTableQuery)
      # dbSendQuery(raw, updateTableQuery)
      # 
      # alterTableQuery <- paste0("ALTER TABLE ", tableName, " DROP COLUMN ", listMatch$shp[i])
      # print(alterTableQuery)
      # dbSendQuery(raw, alterTableQuery)
      
      # update column
      updateTableQuery <- paste0("UPDATE ", tableName, " SET ", listMatch$kugi[i], " = \"", listMatch$shp[i], "\";")
      tryUpdate <- tryCatch({
        dbSendQuery(raw, updateTableQuery)
      }, error=function(e){
        message(e)
        return(FALSE)
      })
      if(is.logical(tryUpdate)){
        updateTableQuery <- paste0("UPDATE ", tableName, " SET ", listMatch$kugi[i], " = ", listMatch$shp[i], ";")
        dbSendQuery(raw, updateTableQuery)
        print("Update with command 2..")
      } else {
        print("Update successful..")
      }
      print(updateTableQuery)
      
      # alter table drop column
      alterTableQuery <- paste0("ALTER TABLE ", tableName, " DROP COLUMN \"", listMatch$shp[i], "\";")
      tryAlter <- tryCatch({
        dbSendQuery(raw, alterTableQuery)
      }, error=function(e){
        message(e)
        return(FALSE)
      })
      if(is.logical(tryAlter)){
        alterTableQuery <- paste0("ALTER TABLE ", tableName, " DROP COLUMN ", listMatch$shp[i], ";")
        dbSendQuery(raw, alterTableQuery)
        print("Alter with command 2..")
      } else {
        print("Alter successful..")
      }
      print(alterTableQuery)
    }  
    
    compilatedData <- pgGetGeom(raw, c("public", tableName))
    disconnectDB(raw)
    
    compdb <- connectDB(pg_comp_db)
    importToComp <- tryCatch({ pgInsert(compdb, tableName, compilatedData) }, error=function(e){ return(FALSE) })
    if(importToComp){
      print("Shapefile has been imported successfully")
      showModal(ui=modalDialog("Data has been compilated", footer = NULL), session=session)
      removeModal(session)
    } else {
      print("Shapefile.. FAILED TO IMPORT")
      showModal(ui=modalDialog("Failed to upload. Please try again..", footer = NULL), session=session)
      removeModal(session)
    }
    disconnectDB(compdb)
    
    listOfTbl$listMatch <- data.frame()
    listOfTbl$recentAttributeTable <- NULL
    listOfTbl$recentAttributeKugi <- NULL
    
    removeUI( selector = "div:has(> #rawTitle)" )
    removeUI( selector = "div:has(> #editAttribute)" )
  })
  
  ###*SELECT DATA Page####
  output$listOfCompData <- renderUI({
    compdb <- connectDB(pg_comp_db)
    allListComp <- dbListTables(compdb)
    disconnectDB(compdb)
    allListComp <- allListComp[!allListComp %in% c("layer", "topology", "spatial_ref_sys")]
    selectInput("selectedCompData", "Pilih Kompilasi Data", choices=allListComp, selectize=FALSE)
  })
  
  output$listOfIgdData <- renderUI({
    igddb <- connectDB(pg_igd_db)
    allListIgd <- dbListTables(igddb)
    disconnectDB(igddb)
    allListIgd <- allListIgd[!allListIgd %in% c("layer", "topology", "spatial_ref_sys")]
    selectInput("selectedIgdData", "Pilih IGD Data", choices=allListIgd, selectize=FALSE)
  })
  
  observeEvent(input$unionButton, {
    print(input$selectedCompData)
    print(input$selectedIgdData)
  })
  
}

###*Run the application#### 
shinyApp(ui = ui, server = server)

