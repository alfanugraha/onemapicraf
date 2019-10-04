library(shiny)
library(shinyalert)

ui <- fluidPage(
  useShinyalert()
)

server <- function(input, output) {
  shinyalert(
    title = "Warning",
    text = "Shapefile sudah terupload sebelumnya",
    closeOnEsc = TRUE,
    closeOnClickOutside = FALSE,
    html = FALSE,
    type = "warning",
    showConfirmButton = TRUE,
    showCancelButton = TRUE,
    confirmButtonText = "Reupload New File",
    confirmButtonCol = "#AEDEF4",
    cancelButtonText = "Keep Old File",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
}

shinyApp(ui, server)

