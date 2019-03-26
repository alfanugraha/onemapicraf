pg_user<-"postgres"
pg_db<-"postgres"
pg_kugi_db<-"kugi4"
pg_igd_db<-"IGD"
pg_host<-"localhost"
pg_port<-"5432"
pg_pwd<-"root"

# driver <- PostgreSQL(max.con = 100)
driver <- dbDriver("PostgreSQL")
DB <- tryCatch({ 
  dbConnect(driver, dbname=pg_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd ) 
}, error=function(e){
  print("Database connection failed")
  return(FALSE)
})

Kugi <- tryCatch({
  dbConnect(driver, dbname=pg_kugi_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd )
}, error=function(e){
  print("Database connection failed")
  return(FALSE)
})

Igd <- tryCatch({
  dbConnect(driver, dbname=pg_igd_db, host=pg_host, port=pg_port, user=pg_user, password=pg_pwd )
}, error=function(e){
  print("Database connection failed")
  return(FALSE)
})

# get shapefile
toponimi_pt_50k <- pgGetGeom(DB, c("public", "toponimi_pt_50k"))

# get attribute data from kugi
kugiTable <- "toponimi_pt_50k"
alterTableSQL <- paste0("ALTER TABLE ", kugiTable, " ")

tableKugi <- tolower(unlist(strsplit(input$shapeGeom, " "))[1])
tableKugiInfo <- dbTableInfo(Kugi, "toponimi_pt_50k")
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
dbSendQuery(DB, alterTableSQL)

writeOGR(kab_oke, ".", "kab_oke", driver="ESRI Shapefile")
pgInsert(DB, c("public", "kab_oke"), oki)

# BUTTON MATCH
# manipulate table
shpAttrib <- "TOPONIMI"
kugiAttrib <- "alias"

recentTableWithKugi
recentAttributeTable
recentAttributeKugi

# move value to kugi field from old field 
eval(parse(text=paste0("recentTableWithKugi$", kugiAttrib, " <- recentTableWithKugi$", shpAttrib)))

# remove old field
eval(parse(text=paste0("recentTableWithKugi$", shpAttrib, " <- NULL")))

# remove value from list of char
recentAttributeTable<-recentAttributeTable[recentAttributeTable!=shpAttrib]


# BUTTON FINISH



