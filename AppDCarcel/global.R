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
#BD <- readRDS("www/BasesDeDatos.rds")
#archivos <- list.files(paste0(getwd(), "/www"))
#indice_multidimensional_est_mun <- read_csv("www/indice_multidimensional_est_mun.csv")

#Abrimos un shape sin islas
mapa <- sf::st_read("www/mapa.geojson",
                    quiet = TRUE) 
mapa <- mapa %>% mutate(CVE_ENT = as.numeric(rownames(mapa)))
# Pegamos BDS
mapa2 <- merge(mapa, BD[[6]], by="CVE_ENT")

######################
# Bases particulares #
#####################
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
dimensiones <- c("Corrupción"       = "corrupcion",         
                 "Inseguridad"      = "inseguridad",        
                 "Servicios"        = "servicios",          
                 "Violencia"        = "violencia",         
                 "Sobrepoblación"   = "sobrepoblacion_rel", 
                 "Derechos Humanos" = "ddhh",               
                 "Presupuesto"      = "presup_pi",          
                 "Interno"          = "interno_pt",         
                 "Índice Final"     = "indice")

# Generamos la base de datos geografica final
mapa_final <- merge(mapa, im_general, by = "ENTIDAD")
