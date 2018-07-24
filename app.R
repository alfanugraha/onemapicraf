library(shiny)
library(shinydashboard)

appsTitle <- 'One Map ICRAF'
appsMenu <- data.frame(
  menuItem = c('Metadata', 'Contact', 'Spatial Representation Info', 'Reference System Info', 'Identification Info',
               'Distribution Info', 'Transfer Options', 'Metadata Maintenace', 'Metadata Constrains'),
  tabName = c('metadata', 'contact', 'spatialRepresentationInfo', 'referenceSystemInfo', 'identificationInfo',
              'distributionInfo', 'transferOptions', 'metadataMaintenanct', 'metadaConstrains')

)


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
            h2(appsMenu$menuItem[2])
    
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

