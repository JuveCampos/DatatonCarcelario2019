#####################
# L I B R E R I A S #
#####################
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
library(readr)

#############
# Funciones #
#############
specify_decimal <- function(x, k) trimws(format(round(x, k), nsmall=k))
DTtablas <- function(datos, datos_visibles = 15, f_I = 1, f_D = 3) {

  DT::datatable(datos, 
                extensions = 'FixedColumns',
                  rownames= FALSE,
                  options = list(
                  pageLength = datos_visibles,
                  language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
                  autoWidth = TRUE, 
                  scroller = TRUE,
                  fixedColumns = list(leftColumns = f_I, rightColumns = f_D),
                  scrollX = TRUE,
                  escape = T) 
  )
}

#############
# D A T O S #
#############

#abrimos base de datos
BD <- readRDS("www/BasesDeDatos.rds")
archivos <- list.files(paste0(getwd(), "/www"))

indice_multidimensional_est_mun <- read_csv("www/indice_multidimensional_est_mun.csv")


#Abrimos un shape sin islas
mapa <- sf::st_read("www/mapa.geojson",
                    quiet = TRUE) 
mapa <- mapa %>% mutate(CVE_ENT = as.numeric(rownames(mapa)))
# Pegamos BDS
# merge(BD[[6]], mapa, by="CVE_ENT")
mapa2 <- merge(mapa, BD[[6]], by="CVE_ENT")
class(mapa2)

# Estilo de la tabla
pal = colorNumeric('Reds', mapa2$indice)
labels <- paste0("<h3>", mapa2$ENTIDAD, ": </h3>", "<br>",
                 "<b>Índice ENPOL generado: </b>", specify_decimal(mapa2$indice, 3), "<br>",
                 "<b>Índice de Inseguridad: </b>", specify_decimal(mapa2$inseguridad, 3) , "<br>",
                 "<b>Índice de Servicios: </b>", specify_decimal(mapa2$servicios, 3) , "<br>",
                 "<b>Índice de Violencia: </b>", specify_decimal(mapa2$violencia, 3) , "<br>",
                 "<b>Índice de Sobrepoblación Relativa: </b>", specify_decimal(mapa2$sobrepoblacion_rel, 3) , "<br>",
                 "<b>Índice de Derechos Humanos: </b>", specify_decimal(mapa2$ddhh, 3) , "<br>",
                 "<b>Índice de Presupuesto: </b>", specify_decimal(mapa2$presup_pi, 3) , "<br>",
                 "<b>Índice de Interno: </b>", specify_decimal(mapa2$interno_pt, 3) , "<br>"
                 )
# Mapa
m <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(data = mapa2, fillColor = pal(mapa2$indice), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
  addLegend(title = "Indice ENPOL", position = 'bottomright', pal = pal, values = mapa2$indice)
# Bases particulares
# INDICE ENPOL
indice_federal <- c(7, 8, 10, 11, 14, 15, 17, 18, 20, 25, 26, 27, 30)
ie_ent     <- read_csv('www/indice_enpol_est_mun.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
ie_federal <- read_csv('www/indice_enpol_federal.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD[indice_federal])
ie_general <- read_csv('www/indice_enpol_general.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
ie_hombres <- read_csv('www/indice_enpol_hombres.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
ie_mujeres <- read_csv('www/indice_enpol_mujeres.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
# INDICE MULTIDIMENSIONAL
im_ent     <- read_csv('www/indice_multidimensional_est_mun.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
im_federal <- read_csv('www/indice_multidimensional_federal.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD[indice_federal])
im_general <- read_csv('www/indice_multidimensional_general.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
im_hombres <- read_csv('www/indice_multidimensional_hombres.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
im_mujeres <- read_csv('www/indice_multidimensional_mujeres.csv') %>% mutate(ENTIDAD = mapa$ENTIDAD)
# Selectores
selector_gral <- readxl::read_xlsx("www/SelectInputPlot.xlsx", sheet = 'General-gral')
selector_part <- readxl::read_xlsx("www/SelectInputPlot.xlsx", sheet = 'General-part')
# Dimensiones
dimensiones <- c("Corrupción" = "corrupcion",         
                 "Inseguridad"= "inseguridad",        
                 "Servicios" = "servicios",          
                 "Violencia" = "violencia",         
                 "Sobrepoblación" = "sobrepoblacion_rel", 
                 "Derechos Humanos" = "ddhh",               
                 "Presupuesto" = "presup_pi",          
                 "Interno" = "interno_pt",         
                 "Índice Final" = "indice")


mapa_final <- merge(mapa, im_general, by = "ENTIDAD")


var_interes <- "servicios"
pal_final <- colorNumeric('Reds', domain = im_general[,var_interes])

# leaflet() %>%
#   addPolygons(data = mapa_final, fillColor = pal_final(mapa_final$servicios)) 


# m <- leaflet() %>%
#   addProviderTiles("CartoDB.Positron") %>%
#   addPolygons(data = mapa_final, fillColor = pal(mapa2$indice), weight = 0.5, popup = labels, fillOpacity = 0.9) %>%
#   addLegend(title = "Indice ENPOL", position = 'bottomright', pal = pal, values = mapa2$indice)


# M A P A # 
        
        
        # 
# 
# 
# 
# ddd <- c()
# for (i in 1:6){
#   base <- files[[i]]
#   ddd <- append(ddd, names(base))
# }
# ddd <- unique(ddd)
# 
# library(rebus)
# library(dplyr)
# e <- ddd[stringr::str_detect(ddd, pattern = "P" %R% "6")] %>% as.data.frame()
# e
# 
# base[c("CVE_ENT",'P7_49_6_2')]
