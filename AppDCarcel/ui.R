
shinyUI({
  
  # Encabezado
  dbHeader <- dashboardHeader(title = "Datatón Carcelario", titleWidth = 260, 
                              tags$li(a(href = 'https://github.com/JuveCampos/DatatonCarcelario2019',
                                        img(src = 'https://image.flaticon.com/icons/svg/25/25231.svg',
                                            title = "CIDE", height = "30px"),
                                        style = "padding-top:10px; padding-bottom:10px;"),
                                      class = "dropdown"))
  
  # Barra Lateral
  sidebar <- dashboardSidebar(width = 260, 
    sidebarMenu(
      
      menuItem("Introducción", tabName = "Intro"), 
      
      menuItem("Índice multidimensional", 
               menuSubItem("Información Por Dimensiones", 'IMGen')
               ), 
      menuItem("Consulta de la Enpol", 
               menuSubItem("Concentrado", 'IEEnt')
      ),
      menuItem("Historias", tabName = "histo"), 
      menuItem("Otros Usos", tabName = "otro")
    )
)
  ##########
  # Cuerpo #
  #########
  body  <-  dashboardBody(
    
    shinyalert::useShinyalert(),
    # Archivo .css
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "estilos.css")
    ),

  tabItems(
    tabItem("Intro", 
      h1("Introducción"), 
      htmlOutput("pdfview")
            ), 

    #########################################################
    tabItem("histo", 
            h2("Historia de María"),
            htmlOutput("pdfview_1"),
            br(),
            h2("Historia de un Custodio"),
            htmlOutput("pdfview_2")
            ),
    
    tabItem("otro", 
            h2("Otro Usos para los datos"), 
            imageOutput('img4'), br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(), # NOTA! ESTO FUE UN PARCHE... VER COMO SOLUCIONARLO!
            h4('ranking_indhpol": Este ranking clasifica a los estados según el 
            desempeño que tuvieron sus centros penitenciarios a nivel general. 
            De forma clara se aprecia que el Estado de México y la Ciudad de México son los que tienen peor desempeño.'), 
            
            imageOutput('img2'),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h4('"componentes_indice": Esta gráfica nos permite hacer comparaciones de manera muy rápida entre 
              las distintas dimensiones del índice y entre estados. De forma horizontal, podemos analizar 
              cuáles son las dimensiones en la que un estados debe trabajar más para mejorar las condiciones 
              de sus prisiones. De forma vertical, vemos dentro de una dimensión cuáles son los estados que peor desempeño tienen.'),
            imageOutput('img1'), br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h4('"Componentes_entidades_Ags_BCS.png": Aquí podemos comparar de manera muy rápida dos estados en cada una de las 8 dimensiones del índice. En este caso comparamos Aguascalientes y Baja California, y vemos que Aguascalientes tiene un mejor desempeño relativo en casi todas las dimensiones.'),
            h4('"Componentes_entidades_Ags_BCS.png": Aquí podemos comparar de manera muy rapida 3 dimensiones del índice desagregadas por sexo. En este caso, para Yucatán, vemos que el desempeño en las cárceles varoniles es mejor que en las femeniles.'),
            
            imageOutput('img5'), br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h4('"relacion_condicionesdignas_corrupcion.png": Esta gráfica nos permite ver que a nivel estatal, encontramos una relación positiva entre corrupción y condiciones dignas.'),
            
            imageOutput('img6'), br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h4('"relacion_malostratos_corrupcion.png": Esta gráfica nos permite ver que a nivel estatal, encontramos una relación positiva entre corrupción y Malos tratos<.'), 
            
            imageOutput('img7'),  br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h4('"relacion_malostratos_personal.png": Esta gráfica nos permite ver que a nivel estatal, encontramos una relación negativa entre  Malos tratos y el personal que labora en el centro penitenciario.')
            ),
    
  #####
    tabItem("IEEnt",
            h1("Índice Enpol Entidades"),
            box(title = "Seleccione Información", width = 550, status = "success", solidHeader = TRUE,
                selectInput("selGEEnt", "Seleccione Pregunta General ENPOL", choices = selector_gral$Pgeneral)
                ,
                uiOutput('selPart1'),
            box(title = "Gráfico de la pregunta", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(plotlyOutput("grafica1", height = 800))
            ),
            box(title = "Índice ENPOL Entidades", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(DT::dataTableOutput('tablaEEnt'))
            )
            )
          ),

  tabItem("IMGen",
          h1("Índice Multidimensional General"),

          box(title = "Grafica de Dimensiones", width = 550, status = "warning", solidHeader = TRUE,
              selectInput("selectDim", "Seleccione la dimension a graficar", choices = dimensiones, selected = "indice")
               ,shinycssloaders::withSpinner(plotlyOutput("graficaDimension", height = 1000)),
               shinycssloaders::withSpinner(leafletOutput("mapa_final", height = 800))
          ),

          box(title = "Índice Multidimensional Entidades", width = 550, status = "warning", solidHeader = TRUE,
              shinycssloaders::withSpinner(DT::dataTableOutput('tablaMGen'))
          )

  )
  )  
 )
  # Ejecutable  
  dashboardPage(dbHeader, sidebar = sidebar, body, skin = "black")      
})
