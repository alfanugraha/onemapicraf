library(DBI)
library(RPostgreSQL)
library(rpostgis)
library(odbc)
library(shiny)

driver <- dbDriver("PostgreSQL")
DB <- dbConnect(
  driver, dbname="palapa", host="172.18.20.97", port="5432", user="palapa", password="palapa"
)

spatial_ref_sys<-dbReadTable(DB, c("public", "spatial_ref_sys"))
front_end<-dbReadTable(DB, c("public", "front_end"))
front_layers<-dbReadTable(DB, c("public", "front_layers"))
group_features<-dbReadTable(DB, c("public", "group_features"))
group_members<-dbReadTable(DB, c("public", "group_members"))
group_roles<-dbReadTable(DB, c("public", "group_roles"))
groups<-dbReadTable(DB, c("public", "groups"))
kode_epsg<-dbReadTable(DB, c("public", "kode_epsg"))
kode_simpul<-dbReadTable(DB, c("public", "kode_simpul"))
metakugi<-dbReadTable(DB, c("public", "metakugi"))
metakugi_dev<-dbReadTable(DB, c("public", "metakugi_dev"))
metakugi_prod<-dbReadTable(DB, c("public", "metakugi_prod"))
metalinks<-dbReadTable(DB, c("public", "metalinks"))
role_props<-dbReadTable(DB, c("public", "role_props"))
roles<-dbReadTable(DB, c("public", "roles"))
sistem<-dbReadTable(DB, c("public", "sistem"))
user_props<-dbReadTable(DB, c("public", "user_props"))
user_roles<-dbReadTable(DB, c("public", "user_roles"))
users<-dbReadTable(DB, c("public", "users"))



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