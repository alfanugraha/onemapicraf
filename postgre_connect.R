# database processing
shp_path<-"D:/OMI/simtaru/BACKUP/datagis/Rencana_Pola_Ruang_Keerom.shp"
oki_path<-"D:/OMI/OKI/kab_oki.shp"
postgre_path<-"C:\\Program Files (x86)\\PostgreSQL\\9.6"
pg_user<-"postgres"
pg_db<-"postgres"
pg_host<-"localhost"
pg_port<-"5432"
pg_password<-"root"

shp_name<-str_remove(basename(oki_path), ".shp")
oki<-readOGR(oki_path, shp_name)
shp_srid<-tryCatch({pgSRID(DB, crs(oki), create.srid = TRUE)}, error=function(e){ })

driver <- dbDriver("PostgreSQL")
DB <- dbConnect(
  driver, dbname="postgres", host="localhost", port="5432", user="postgres", password="root"
)

pgEnvBatch <- paste("pg_env.bat", sep="")
pathEnv = ""
pathEnv[1] = paste0("@SET PATH=", postgre_path, "\\bin;%PATH%")
pathEnv[2] = paste0("@SET PGDATA=", postgre_path, "\\data")
pathEnv[3] = paste0("@SET PGUSER=", pg_user)
pathEnv[4] = paste0("@SET PGPORT=", pg_port)
pathEnv[5] = paste0("@SET PGLOCALEDIR=", postgre_path, "\\share\\locale\n")

createNewPGTbl = pathEnv
createNewPGTbl[6] = paste('shp2pgsql -I -s ', shp_srid , str_replace_all(string=shp_path, pattern="/", repl='\\\\'), ' Rencana_Pola_Ruang_Keerom | psql -d ', pg_db, sep="")

newBatchFile <- file(pgEnvBatch)
writeLines(createNewPGTbl, newBatchFile)
close(newBatchFile)
# execute batch file
pgEnvBatchFile<-str_replace_all(string=pgEnvBatch, pattern="/", repl='\\\\')
system(pgEnvBatchFile)

# write the properties of reference data to PostgreSQL
eval(parse(text=(paste("list_of_comp_data<-data.frame(RST_NAME=tolower(shp_name), row.names=NULL)", sep=""))))
dbWriteTable(DB, "list_of_comp_data", list_of_comp_data, append=TRUE, row.names=FALSE)

# dbDisconnect(DB)









# specifies the details of the table
# sql_command <- "CREATE TABLE cartable
# (
#   carname character varying NOT NULL,
#   mpg numeric(3,1),
#   cyl numeric(1,0),
#   disp numeric(4,1),  
#   hp numeric(3,0),
#   drat numeric(3,2),
#   wt numeric(4,3),
#   qsec numeric(4,2),
#   vs numeric(1,0),
#   am numeric(1,0),
#   gear numeric(1,0),
#   carb numeric(1,0),
#   CONSTRAINT cartable_pkey PRIMARY KEY (carname)
# )
# WITH (
# OIDS=FALSE
# );
# ALTER TABLE cartable
# OWNER TO openpg;
# COMMENT ON COLUMN cartable.disp IS '
# ';"
# # sends the command and creates the table
# dbGetQuery(con, sql_command)

# palapa's table
# spatial_ref_sys<-dbReadTable(DB, c("public", "spatial_ref_sys"))
# front_end<-dbReadTable(DB, c("public", "front_end"))
# front_layers<-dbReadTable(DB, c("public", "front_layers"))
# group_features<-dbReadTable(DB, c("public", "group_features"))
# group_members<-dbReadTable(DB, c("public", "group_members"))
# group_roles<-dbReadTable(DB, c("public", "group_roles"))
# groups<-dbReadTable(DB, c("public", "groups"))
# kode_epsg<-dbReadTable(DB, c("public", "kode_epsg"))
# kode_simpul<-dbReadTable(DB, c("public", "kode_simpul"))
# metakugi<-dbReadTable(DB, c("public", "metakugi"))
# metakugi_dev<-dbReadTable(DB, c("public", "metakugi_dev"))
# metakugi_prod<-dbReadTable(DB, c("public", "metakugi_prod"))
# metalinks<-dbReadTable(DB, c("public", "metalinks"))
# role_props<-dbReadTable(DB, c("public", "role_props"))
# roles<-dbReadTable(DB, c("public", "roles"))
# sistem<-dbReadTable(DB, c("public", "sistem"))
# user_props<-dbReadTable(DB, c("public", "user_props"))
# user_roles<-dbReadTable(DB, c("public", "user_roles"))
# users<-dbReadTable(DB, c("public", "users"))
