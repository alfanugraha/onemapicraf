library(shiny)
library(ggplot2)
library(DT)
library(DBI)
library(shinyjs)
library(shinydashboard)
library(data.table)

ui <- fluidPage(
  title = "Examples of DataTables",
  useShinyjs(),
  DT::dataTableOutput("tab1"), 
  verbatimTextOutput('printMsg')
)

server <- function(input, output, session) {
  
  printText <- reactiveValues(brands = '')
  
  buttonInput <- function(FUN, len, id, ...) {
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, i), ...))
    }
    inputs
  }
  
  Data <- data.table(
    User = c("kisi001","kisi002","kisi003"),
    Nama = c("nama user01", "nama user02", "nama user03"),
    Organisasi = c("ICRAF","GIZ", "CIFOR"),
    Provinsi = c("Jawa Barat", "DKI Jakarta", "Jawa Barat"),
    File =  c("das_bogor_10k","das_jakarta_100k", "das_bogor_100k"),
    Status = c("Draft","Draft","Draft"),
    
    Approve = buttonInput(
      FUN = actionButton,
      len = 3,
      id = 'approve_',
      label = "Approve",
      onclick = 'Shiny.onInputChange(\"lastClick\",  this.id)'), 
    Reject = buttonInput(
      FUN = actionButton,
      len = 3,
      id = 'reject_',
      label = "Reject",
      onclick = 'Shiny.onInputChange(\"select_button\",  this.id)'
    )
  )
  
  # output$tab1 <- DT::renderDataTable({
  #   DT = vals$Data
  #   datatable(DT, escape =   F)
  # })
  
  output$tab1 <- DT::renderDataTable(
    Data, server = FALSE, escape = FALSE, selection = 'none'
  )
  
  observeEvent(input$lastClick, {
    selectedRow <- as.numeric(strsplit(input$lastClick, "_")[[1]][2])
    disable(paste0("reject_", selectedRow))
    printText$brands <<- paste('Status',Data[selectedRow,5], 'adalah Approved')
    #updateTextInput(session, vals$Data$Status, value = "Approved")
    print(Data$Status[selectedRow])
    Data$Status[selectedRow] <- "Approved"
  })
  
  observeEvent(input$select_button, {
    selectedRow <- as.numeric(strsplit(input$select_button, "_")[[1]][2])
    printText$brands <<- paste('Status',Data[selectedRow,5], 'adalah Rejected')
    #updateTextInput(session, vals$Data$Status, value = "Rejected")
    Data$Status[selectedRow] <- "Rejected"
    disable(paste0("approve_", selectedRow))
  })
  
  output$printMsg <- renderText({
    printText$brands
  })
}

shinyApp(ui, server)


