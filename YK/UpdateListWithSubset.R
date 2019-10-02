katalogdata<-data.frame(KUGI=c("EKOSISTEMTERUMBUKARANG_AR_5K (3D Multi Polygon)",
                               "SEMPADANPANTAI_LN_5K (Multi Line String)",
                               "MANGROVE_PT_5K (Point)",
                               "MANGROVE_AR_5K (Multi Polygon)",
                               "PADANGLAMUN_PT_5K (Point)",
                               "Test"))
saveRDS(katalogdata,"katalog.rds")

myDataList <- list(KUGI=c("EKOSISTEMTERUMBUKARANG_AR_5K (3D Multi Polygon)",
                          "SEMPADANPANTAI_LN_5K (Multi Line String)",
                          "MANGROVE_PT_5K (Point)",
                          "MANGROVE_AR_5K (Multi Polygon)",
                          "PADANGLAMUN_PT_5K (Point)"))

library(shiny)

ui <- shinyUI(
  fluidPage(
    fileInput("file1", "Choose file to upload", accept = ".rds"),
    selectInput("ListKugi","Kugi", ""),
    tableOutput("contents")
  )
)

server <- function(input, output, session) {
  
  myData <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) {
      d <- myDataList
    } else {
      d <- readRDS(inFile$datapath)
      #d <- subset(katalogdata, KUGI != input$ListKugi)
      d <- subset(katalogdata, KUGI != "MANGROVE_PT_5K (Point)") #input$ListKugi)
      saveRDS(d, "katalog.rds")
    }
    d
  })
  
  output$contents <- renderTable({
    myData()
  })
  
  observe({
    updateSelectInput(session, "ListKugi",
                      label = "ListKugi",
                      choices = myData()$KUGI) #,
    # selected = myData()$KUGI[1])
  })
  
}

shinyApp(ui, server)
