# initiate library
library(shiny)
library(shinydashboard)

# initiate global variable
appsTitle <- 'One Map ICRAF'
appsMenu <- data.frame(
  menuItem = c('Metadata', 'Contact', 'Spatial Representation Info', 'Reference System Info', 'Identification Info',
               'Distribution Info', 'Transfer Options', 'Metadata Maintenace', 'Metadata Constrains'),
  tabName = c('metadata', 'contact', 'spatialRepresentationInfo', 'referenceSystemInfo', 'identificationInfo',
              'distributionInfo', 'transferOptions', 'metadataMaintenance', 'metadataConstraint')
)
# 1. metadata
mdEntity <- data.frame(
  vars = c('fileIdentifier', 'lang', 'charSet', 'hieLvl', 'mdStdName', 'mdStdVer', 'dateStamp', 'dataSetURI'),
  name = c('File Identifier', 'Language', 'Character Set', 'Hierarchy Level', 'Metadata Standard Name', 'Metadata Standard Version', 'Date Stamp', 'Data Set URI'),
  desc = c('', '', '', '', '', '', '', '')
)
# 2. contact
ctEntity <- data.frame(
  vars = c('indName', 'orgName', 'posName', 'phone', 'fax', 'delivPoint', 'city', 'postCode', 'country', 'emailAdd', 'linkage', 'protocol', 'function', 'hOfService', 'contIntructions', 'role'),
  name = c('Individual Name', 'Organisation Name', 'Position Name', 'Phone', 'Faximile', 'Delivery Point', 'City', 'Postal Code', 'Country', 'Email Address', 'Linkage', 'Protocol', 'Function', 'Hours Of Service', 'Contact Intructions', 'Role'),
  desc = c('', '', '', '', '', '', '', '')
)
# 3. spatial representation info
sriEntity <- data.frame(
  vars = c('topoLvl', 'geomObj', 'nOfDim', 'cornerPoints', 'pointInPxl', 'axixDimProp', 'dimName', 'dimSize', 'cellGeom', 'checkPointAvail', 'controlPointAvail', 'geoParam', 'objType'),
  name = c('Topology Level', 'Geometry Objects', 'Number Of Dimension', 'Corner Points', 'Point in Pixel', 'Axis Dimension Property', 'Dimension Name', 'Dimension Size', 'Cell Geometry', 'Check Point Availability', 'Control Point Availability', 'Georeference Parameters', 'Object Type'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '', '')
)
# 4. reference system info
refsysEntity <- data.frame(
  vars = c('title', 'date', 'dateType', 'orgName', 'linkage', 'role', 'code', 'version', 'Name', 'crs', 'semiMajorAxis', 'axisUnit'),
  name = c('Title', 'Date', 'Date Type', 'Organisation Name', 'Linkage', 'Role', 'Code', 'Version', 'Name', 'Coordinate Reference System', 'Semi Major Axis', 'Axis Unit'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '')
)
# 5. identification info
idInfEntity <- data.frame(
  vars = c('citation', 'title', 'date', 'dateType', 'abstract', 'resMaintenance', 'descKey', 'spatRes', 'resCons', 'spatRepType', 'langIdent', 'charSetCode', 'topicCat', 'westBoundLong', 'eastBoundLong', 'southBoundLat', 'northBoundLat'),
  name = c('Citation', 'Title', 'Date', 'Date Type', 'Abstract', 'Resource Maintenance', 'Descriptive Keywords', 'Spatial Resolution', 'Resource Constraints', 'Spatial Representation Type', 'Language Identification', 'Character Set Code', 'Topic Category', 'West Bound Longitude', 'East Bound Longitude', 'South Bound Latitude', 'North Bound Latitude'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
)
# 6. distribution info


# header
header <- dashboardHeader(title=appsTitle)

# sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(appsMenu$menuItem[1], tabName = appsMenu$tabName[1]),
    menuItem(appsMenu$menuItem[2], tabName = appsMenu$tabName[2]),
    menuItem(appsMenu$menuItem[3], tabName = appsMenu$tabName[3]),
    menuItem(appsMenu$menuItem[4], tabName = appsMenu$tabName[4]),
    menuItem(appsMenu$menuItem[5], tabName = appsMenu$tabName[5]),
    menuItem(appsMenu$menuItem[6], tabName = appsMenu$tabName[6]),
    menuItem(appsMenu$menuItem[7], tabName = appsMenu$tabName[7]),
    menuItem(appsMenu$menuItem[8], tabName = appsMenu$tabName[8]),
    menuItem(appsMenu$menuItem[9], tabName = appsMenu$tabName[9])
  )
)

# body
body <- dashboardBody(
  tabItems(
    tabItem(tabName = appsMenu$tabName[1],
            h2(appsMenu$menuItem[1])
            
    ),
    
    tabItem(tabName = appsMenu$tabName[2],
            h2(appsMenu$menuItem[2]),
            box(
              textInput("individualName", "Name", value="", width=NULL, placeholder="Fill the name")
            )
    
    ),
    
    tabItem(tabName = appsMenu$tabName[3]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[4]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[5]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[6]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[7]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[8]
            
    ),
    
    tabItem(tabName = appsMenu$tabName[9]
            
    )
  )
)



# Setup UI shiny
# Dashboard page
ui <- dashboardPage(
  skin = 'black', 
  header,
  sidebar,
  body
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
}

# Run the application 
shinyApp(ui = ui, server = server)

