#app.R in line 1088-1102
##Menambahkan Legend pada leaflet

print("render map")
# igdData %>% leaflet() %>% addTiles() %>% addPolygons()
leaflet() %>% addTiles() %>%
  addPolygons(data=igdData, weight=3, color = 'red') %>% 
  addPolygons(data=compData, weight=3, color = 'blue') %>% 
  addProviderTiles("Esri.OceanBasemap", group = "Esri.OceanBasemap") %>%
  addProviderTiles("CartoDB.DarkMatter", group = "DarkMatter (CartoDB)") %>%
  addProviderTiles("OpenStreetMap.Mapnik", group = "OpenStreetmap") %>%
  addProviderTiles("Esri.WorldImagery", group = "Esri.WorldImagery") %>%
  addLayersControl(baseGroups = c("OpenStreetmap","Esri.OceanBasemap",'DarkMatter (CartoDB)', 'Esri.WorldImagery'),
                   options = layersControlOptions(collapsed = TRUE, autoZIndex = F))%>%
  addLegend(values = 1, group = "IGD", position = "bottomleft", labels = "IGD", colors= "red") %>%
  addLegend(values = 2, group = "Kompilasi", position = "bottomleft", labels = "Kompilasi" ,colors= "blue") #%>%  
# addLayersControl(overlayGroups = c("IGD", "Kompilasi"),
#                  options = layersControlOptions(collapsed = FALSE))