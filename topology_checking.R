library(rworldmap)
library(rgdal)
library(rpostgis)
library(cleangeo)
world<-getMap()
oki1<-readOGR(dsn = "D:/OMI/Sample_Data/kab_oki.shp", layer = "kab_oki")
Topology<-readOGR(dsn = "D:/OMI/Sample_Data/Topology.shp", layer = "Topology")
deiyai<-readOGR(dsn = "D:/OMI/Sample_Data/Deiyai.shp", layer = "Deiyai")
pgInsert(DB, 'oki', oki)


clgeo_IsValid(world)
h<-clgeo_Clean(world)
report.clean<-clgeo_CollectionReport(h)
clgeo_SummaryReport(report.clean)


clgeo_IsValid(Topology)
h<-clgeo_Clean(Topology)
report.clean<-clgeo_CollectionReport(h)
clgeo_SummaryReport(report.clean)


shp_file <- deiyai
print("Topology.. Checking")
if(clgeo_IsValid(shp_file)){
  print("Topology.. Ok")
  # input to postgres
  # write to xml
  # print report
} else {
  # collect invalid issue
  report_shp<-clgeo_CollectionReport(shp_file)
  
  # reset row numbers of original data
  shp_data <- shp_file@data
  row.names(shp_data) <- NULL
  
  # select FALSE validity
  print("Topology.. Invalid")
  shp_invalid <- report_shp[report_shp$valid==FALSE,]
  
  # merge shp_data with report_shp
  final_report_shp <- merge(shp_data, shp_invalid, by="row.names")
  
  # clean topology
  print("Topology.. Cleaning")
  shp_file_clean <- clgeo_Clean(shp_file)
}




# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO onemap;
# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO onemap;
# GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO onemap;




# coords
# x=long
# y=lat
bbox(oki)[1] # xmin
bbox(oki)[2] # ymin
bbox(oki)[3] # xmax
bbox(oki)[4] # ymax

# dimension
dim(oki)[1]

# crs
oki@proj4string@projargs

# reproject
wgs84_proj <- CRS("+proj=longlat +datum=WGS84")
paste0(degree_projection)==paste0(crs(oki_reproject))
oki_reproject <- spTransform(oki, degree_projection)
