#app.R di line 220-234
##Pop Up Notification tapi untuk tombol masih belum sesuai dengan issue

#showModal(ui=modalDialog("Shapefile has been imported into database", footer = NULL), session=session)
shinyalert(title = "Warning",
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
           animation = TRUE)