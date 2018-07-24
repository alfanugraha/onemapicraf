library(DBI)
library(RPostgreSQL)
library(rpostgis)
library(odbc)
library(shiny)

driver <- dbDriver("PostgreSQL")
DB <- dbConnect(
  driver, dbname="palapa", host="172.18.20.97", port="5432", user="palapa", password="palapa"
)

rodbc <- dbConnect(odbc::odbc(), dsn = "PostgreSQL")


# another method
ui <- fluidPage(
  numericInput("nrows", "Enter the number of rows to display:", 5),
  tableOutput("tbl")
)

server <- function(input, output, session) {
  output$tbl <- renderTable({
    conn <- dbConnect(
      drv = RMySQL::MySQL(),
      dbname = "shinydemo",
      host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
      username = "guest",
      password = "guest")
    on.exit(dbDisconnect(conn), add = TRUE)
    dbGetQuery(conn, paste0(
      "SELECT * FROM City LIMIT ", input$nrows, ";"))
  })
}