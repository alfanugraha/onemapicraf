# initiate library
library(shiny)
library(shinydashboard)

source('variables.R')

# header
header <- dashboardHeader(title=appsTitle, titleWidth=280)

# sidebar
sidebar <- dashboardSidebar(
  width=280,
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
            h2(appsMenu$menuItem[1]),
            fileInput(mdEntity$vars[1], mdEntity$name[1], buttonLabel="Browse...", placeholder="No file selected"),
            textInput(mdEntity$vars[2], mdEntity$name[2], value="", width=NULL, placeholder=""),
            textInput(mdEntity$vars[3], mdEntity$name[3], value="", width=NULL, placeholder=""),
            textInput(mdEntity$vars[4], mdEntity$name[4], value="", width=NULL, placeholder=""),
            textInput(mdEntity$vars[5], mdEntity$name[5], value="", width=NULL, placeholder=""),
            textInput(mdEntity$vars[6], mdEntity$name[6], value="", width=NULL, placeholder=""),
            dateInput(mdEntity$vars[7], mdEntity$name[7]),
            textInput(mdEntity$vars[8], mdEntity$name[8], value="", width=NULL, placeholder="")
    ),
    
    tabItem(tabName = appsMenu$tabName[2],
            h2(appsMenu$menuItem[2]),
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
    
    tabItem(tabName = appsMenu$tabName[3],
            h2(appsMenu$menuItem[3]),
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
    
    tabItem(tabName = appsMenu$tabName[4],
            h2(appsMenu$menuItem[4]),
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
    
    tabItem(tabName = appsMenu$tabName[5],
            h2(appsMenu$menuItem[5]),
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
    
    tabItem(tabName = appsMenu$tabName[6],
            h2(appsMenu$menuItem[6]),
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
    
    tabItem(tabName = appsMenu$tabName[7],
            h2(appsMenu$menuItem[7]),
            textInput(trfOptEntity$vars[1], trfOptEntity$name[1], value="", width=NULL, placeholder=""),
            textInput(trfOptEntity$vars[2], trfOptEntity$name[2], value="", width=NULL, placeholder=""),
            textInput(trfOptEntity$vars[3], trfOptEntity$name[3], value="", width=NULL, placeholder=""),
            textInput(trfOptEntity$vars[4], trfOptEntity$name[4], value="", width=NULL, placeholder=""),
            textInput(trfOptEntity$vars[5], trfOptEntity$name[5], value="", width=NULL, placeholder="")
    ),
    
    tabItem(tabName = appsMenu$tabName[8],
            h2(appsMenu$menuItem[8]),
            textInput(mdMtncEntity$vars[1], mdMtncEntity$name[1], value="", width=NULL, placeholder=""),
            textInput(mdMtncEntity$vars[2], mdMtncEntity$name[2], value="", width=NULL, placeholder="")
    ),
    
    tabItem(tabName = appsMenu$tabName[9],
            h2(appsMenu$menuItem[9]),
            textInput(mdConstEntity$vars[1], mdConstEntity$name[1], value="", width=NULL, placeholder=""),
            textInput(mdConstEntity$vars[2], mdConstEntity$name[2], value="", width=NULL, placeholder=""),
            textInput(mdConstEntity$vars[3], mdConstEntity$name[3], value="", width=NULL, placeholder="")
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

# Define server 
server <- function(input, output) {
   
}

# Run the application 
shinyApp(ui = ui, server = server)

