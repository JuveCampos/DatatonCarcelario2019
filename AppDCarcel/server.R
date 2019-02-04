# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  shinyalert::shinyalert(
    title = "INDHPOL - ¡Bienvenido!",
    text = "Encuentra información estadística, análisis gráficos e informes de resultados del proyecto.",
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = FALSE,
    #type = "success", # Se silencio esta linea... lo que hace es mostrar una palomita en la parte superior de la ventana de bienvenida
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "Continuar",
    confirmButtonCol = "00ABC9",
    timer = 0,
    imageUrl = "inicio.png",
    imageWidth = 400,
    imageHeight = 200,
    animation = TRUE
  )
  
  # P D F 
  output$pdfview <- renderUI({
    tags$iframe(style="height:600px; width:100%", src="PresentacionDataton2.pdf")
  })
  
  output$pdfview_1 <- renderUI({
    tags$iframe(style="height:600px; width:100%", src="Datatón_ Historia de María.pdf")
  })
  
  output$pdfview_2 <- renderUI({
    tags$iframe(style="height:600px; width:100%", src="Datatón_ narrativa Custodio.pdf")
  })
  
  
  output$tablaEEnt <- DT::renderDataTable({
    DTtablas(ie_general[,c(93,3:92)], f_I = 1, f_D = 0) %>% DT::formatRound(columns = names(ie_ent[,c(3:92)]), digits = 3)
  })

###

  output$tablaMGen <- DT::renderDataTable({
    DTtablas(im_general[,c(11,3:10)], f_I = 1, f_D = 0) %>% DT::formatRound(columns = names(im_general[,c(3:10)]), digits = 3)
  })

  ########
  # IMGs #
  ########
  
  
output$img1 <- renderImage({
    if (session$clientData$output_img1_width < 800) {
      width <- session$clientData$output_img1_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/componentes_entidades_Ags_BCS.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)
  
  output$img2 <- renderImage({
    if (session$clientData$output_img2_width < 800) {
      width <- session$clientData$output_img2_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/componentes_indice.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)
  
  output$img3 <- renderImage({
    if (session$clientData$output_img3_width < 800) {
      width <- session$clientData$output_img3_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/componentes_sexo_yucatan.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)

  output$img4 <- renderImage({
    if (session$clientData$output_img4_width < 800) {
      width <- session$clientData$output_img4_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/ranking_indhphol.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)
  
  output$img5 <- renderImage({
    if (session$clientData$output_img5_width < 800) {
      width <- session$clientData$output_img5_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/relacion_condicionesdignas_corrupcion.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)

  output$img6 <- renderImage({
    if (session$clientData$output_img6_width < 800) {
      width <- session$clientData$output_img6_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/relacion_malostratos_corrupcion.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)
  
  output$img7 <- renderImage({
    if (session$clientData$output_img7_width < 800) {
      width <- session$clientData$output_img7_width
    } else {
      width <- 800
    }
    list(src = paste0("www/Img/relacion_malostratos_personal.png"),
         contentType = 'image/png', 
         width = width
    )}, deleteFile = FALSE)
  
  #######
  # U I #
  ######

output$selPart1 <- renderUI({
      # importanteeee!!!      
      selectInput("selPEEnt", "Seleccione Pregunta Particular ENPOL", choices =
                  selector_part$Pparticular[selector_part$grupo == selector_gral$Grupo[which(selector_gral$Pgeneral == input$selGEEnt)]] )
  })
  
  output$grafica1 <- renderPlotly({
    
    # Filtro 
    base <- ie_ent[c('ENTIDAD', selector_part$indice[which(selector_part$Pparticular == input$selPEEnt)])] %>%
      mutate(ENTIDAD = as.character(ENTIDAD))
    names(base) <- c("ENTIDAD", "VAR") 
    
    popup <- paste0("<b>Entidad Federativa: </b>", base$ENTIDAD, "<br>", 
                    "<b>Variable: </b>", input$selPEEnt, "<br>", 
                    "<b>Valor: </b>", specify_decimal(base$VAR, 3))
    
    m <- ggplot(data = base, aes(x = reorder(ENTIDAD, -VAR), y = VAR, text = popup)) + 
      geom_bar(stat="identity", fill = "#b62f3e") + 
      coord_flip() +  ggtitle("Proporción de la Población Carcelaria <br>que respondió afirmativamente a la pregunta<br>") + 
      ggthemes::theme_fivethirtyeight()
  
    ggplotly(m, tooltip = 'text') %>%
      layout(showlegend = FALSE) %>%
      config(displayModeBar = F)  
    
  })

output$graficaDimension <- renderPlotly({
    
  print(input$selectDim)
  base <- im_general[,c('ENTIDAD', input$selectDim)] %>%
    mutate(ENTIDAD = as.character(ENTIDAD))
  names(base) <- c("ENTIDAD", "DIM")

  popup <- paste0("<b>Entidad Federativa: </b>", base$ENTIDAD, "<br>", 
                    "<b>Valor: </b>", specify_decimal(base$DIM, 3))
    
  m <- ggplot(data = base, aes(x = reorder(ENTIDAD, -DIM), y = DIM, text = popup)) + 
      geom_bar(stat="identity", fill = "#b62f3e") + 
      coord_flip() +  
      ggtitle(paste0("Calificación de las Entidades en la dimensión seleccionada<br>", input$selectDim)) + 
      ggthemes::theme_fivethirtyeight()
    
    ggplotly(m, tooltip = 'text') %>%
      layout(showlegend = FALSE) %>%
      config(displayModeBar = F)  
  })
  
# Este es el codigo del Mapa... seguramente hay formas mas sencillas de hacerlo pero por las prisas
  # no me di el tiempo de simplificarlo... trata de abarcar todos los casos posibles ante las dimensiones
  # que pueden evaluarse en nuestro indice sintético.
output$mapa_final <- renderLeaflet({
    
    var_interes <- input$selectDim
    
    if (var_interes == "corrupcion"){
      # Estilo de la tabla
      pal = colorNumeric('Reds', mapa_final$corrupcion)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de Corrupción generado: </b>", specify_decimal(mapa_final$corrupcion, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$corrupcion), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice Corrupción", position = 'bottomright', pal = pal, values = mapa_final$corrupcion)
      
    } else if (var_interes == "inseguridad") {
      # Estilo de la tabla
      pal = colorNumeric('Greens', mapa_final$inseguridad)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de inseguridad generado: </b>", specify_decimal(mapa_final$inseguridad, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$inseguridad), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice inseguridad", position = 'bottomright', pal = pal, values = mapa_final$inseguridad)
      
    } else if (var_interes == "servicios") {
      # Estilo de la tabla
      pal = colorNumeric('Blues', mapa_final$servicios)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de servicios generado: </b>", specify_decimal(mapa_final$servicios, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$servicios), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice servicios", position = 'bottomright', pal = pal, values = mapa_final$servicios)
      
      
    }  else if (var_interes == "violencia") {
      # Estilo de la tabla
      pal = colorNumeric('Oranges', mapa_final$violencia)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de violencia generado: </b>", specify_decimal(mapa_final$violencia, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$violencia), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice violencia", position = 'bottomright', pal = pal, values = mapa_final$violencia)
      
    }  else if (var_interes == "sobrepoblacion_rel") {
      
      # Estilo de la tabla
      pal = colorNumeric('YlOrRd', mapa_final$sobrepoblacion_rel)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de Sobrepoblacion generado: </b>", specify_decimal(mapa_final$sobrepoblacion_rel, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$sobrepoblacion_rel), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice Sobrepoblación", position = 'bottomright', pal = pal, values = mapa_final$sobrepoblacion_rel)
      
    }  else if (var_interes ==  "ddhh") {
      
      # Estilo de la tabla
      pal = colorNumeric('OrRd', mapa_final$ddhh)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de ddhh generado: </b>", specify_decimal(mapa_final$ddhh, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$ddhh), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice ddhh", position = 'bottomright', pal = pal, values = mapa_final$ddhh)
      
    }  else if (var_interes ==  "presup_pi") {
      
      # Estilo de la tabla
      pal = colorNumeric('OrRd', mapa_final$presup_pi)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de presupuesto generado: </b>", specify_decimal(mapa_final$presup_pi, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$presup_pi), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice presupuesto", position = 'bottomright', pal = pal, values = mapa_final$presup_pi)
      
    }  else if (var_interes ==   "interno_pt" ) {
      
      # Estilo de la tabla
      pal = colorNumeric('RdPu', mapa_final$interno_pt)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice de Internos por Trabajador generado: </b>", specify_decimal(mapa_final$interno_pt, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$interno_pt), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice Interno por Trabajador", position = 'bottomright', pal = pal, values = mapa_final$violencia)
      
    }  else {
      # Estilo de la tabla
      
      pal = colorNumeric('RdPu', mapa_final$indice , reverse = TRUE)
      labels <- paste0("<b>", mapa_final$ENTIDAD, ": </b>", "<br>",
                       "<b>Índice generado: </b>", specify_decimal(mapa_final$indice, 3))
      # Mapa  
      leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(data = mapa_final, color = 'black', fillColor = pal(mapa_final$indice), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
        addLegend(title = "Indice INDHPOL", position = 'bottomright', pal = pal, values = mapa_final$violencia)
    }        
    
  })
  
})