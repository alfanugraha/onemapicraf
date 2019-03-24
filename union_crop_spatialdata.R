#Library activation
library(rgdal)
library(rgeos)
library(raster)


#read shapefile to R
igd <- readOGR(dsn = "D:/Project/OMI/2_Software/2_Development/data_tes", layer = "IGD_OganKomeringIlir")
igt <- readOGR(dsn = "D:/Project/OMI/2_Software/2_Development/data_tes", layer = "admin_OKI") 
  
#union testing
uni <- union(igd, igt)

#crop testing
crop1 <- crop(igd, igt)


#write shapefile from R
writeOGR(obj = uni, dsn = "D:/Project/OMI/2_Software/2_Development/data_tes", layer = "union", driver = "ESRI Shapefile", morphToESRI = TRUE )