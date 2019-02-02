
shinyUI({
  
  # Encabezado
  dbHeader <- dashboardHeader(title = "Datatón Carcelario", titleWidth = 260)
  
  # Barra Lateral
  sidebar <- dashboardSidebar(width = 260, 
    sidebarMenu(
      
      menuItem("Introducción", tabName = "Intro"), 
      
      menuItem("Índice multidimensional", 
               menuSubItem("Información Por Dimensiones", 'IMGen')
               #,
               #menuSubItem("Índice por Entidad", 'IMEnt'),
               #menuSubItem("Índice Federal", 'IMFed'),
               #menuSubItem("Índice Hombres", 'IMHom'), 
               #menuSubItem("Índice Mujeres", 'IMMuj')
               ), 
      menuItem("Consulta de la Enpol", 
               #menuSubItem("Índice general", 'IEGen'), 
               menuSubItem("Concentrado", 'IEEnt')
               #,
               #menuSubItem("Índice Federal", 'IEFed'),
               #menuSubItem("Índice Hombres", 'IEHom'), 
               #menuSubItem("Índice Mujeres", 'IEMuj')
      ),
      menuItem("Historias", tabName = "histo"), 
      menuItem("Otros Usos", tabName = "otro")
      # menuItem("Mapa", tabName = "MAPA"),
      # menuItem("Indice Servicios Básicos", tabName = "SERVBAS"),
      # menuItem("Indice Inseguridad", tabName = "INSEG"),
      # menuItem("Indice Corrupción", tabName = "CORRUP"),
      # menuItem("Índice ENPOL", tabName = "IENPOL")
      #,
      # menuItem("Sobrepoblación", tabName = "SOB"),
      # menuItem("Violencia", tabName = "VIO"),
      # menuItem("DDHH", tabName = "DDH"),
      # menuItem("CNGSPSP", tabName = "CNG"),
      # menuItem("Población", tabName = "pob"),
      # menuItem("Presupuesto", tabName = "pres"),
      # menuItem("Recursos Humanos", tabName = "rh"),
      # menuItem("Violencia", tabName = "VIO"),
      # menuItem("Indice Multidimensional", tabName = "IMULT")
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
      #, 
      # fluidPage(
      #     fluidRow(
      #         column(12,
      #                box(title = "Tabla 1 - Índice ENPOL de estados y municipios", width = 550, status = "warning", solidHeader = TRUE,
      #                    DT::dataTableOutput('tabla1'))
      #       )
      #     )
      #   ),
      #       #column(12,
      # box(title = "Tabla 2 - Índice ENPOL Federal", width = 550, status = "warning", solidHeader = TRUE,
      #           DT::dataTableOutput('tabla2')),
      #       #column(12,
      # box(title = "Tabla 3 - Índice ENPOL General", width = 550, status = "warning", solidHeader = TRUE,
      #           DT::dataTableOutput('tabla3')),
      #       # column(12,
      # box(title = "Tabla 4 - Índice ENPOL Hombres", width = 550, status = "warning", solidHeader = TRUE,
      #           DT::dataTableOutput('tabla4')),
      #       #column(12,
      # box(title = "Tabla 5 - Índice ENPOL Mujeres", width = 550, status = "warning", solidHeader = TRUE,
      #           DT::dataTableOutput('tabla5')),
      #       #column(12,
      # box(title = "Tabla 6 - Índice ENPOL Multidimensional", width = 550, status = "warning", solidHeader = TRUE,
      #           DT::dataTableOutput('tabla6'))
            ), 
    
    tabItem("IENPOL", 
            h1("Indice ENPOL")
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
            imageOutput('img4'), br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
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

    tabItem("IEFed", 
            h1("Índice Enpol Federal"), 
            box(title = "Índice ENPOL Entidades", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(DT::dataTableOutput('tablaEFed'))
            )
    ),
    
    tabItem("IEGen", 
            h1("Índice Enpol General"), 
            box(title = "Índice ENPOL Entidades", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(DT::dataTableOutput('tablaEGen'))
            )
    ),
    
    tabItem("IEHom", 
            h1("Índice Enpol Hombres"), 
            box(title = "Índice ENPOL Entidades", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(DT::dataTableOutput('tablaEHom'))
            )
    ),
    
    tabItem("IEMuj", 
            h1("Índice Enpol Mujeres"), 
            box(title = "Índice ENPOL Entidades", width = 550, status = "warning", solidHeader = TRUE,
                shinycssloaders::withSpinner(DT::dataTableOutput('tablaEMuj'))
            )
    ),
    
  
  #####  
  tabItem("IMEnt", 
          h1("Índice Multidimensional Entidades"), 
          box(title = "Índice Multidimensional Entidades", width = 550, status = "warning", solidHeader = TRUE,
              shinycssloaders::withSpinner(DT::dataTableOutput('tablaMEnt'))
          )
  ),
  
  tabItem("IMFed", 
          h1("Índice Multidimensional Federal"), 
          box(title = "Índice Multidimensional Entidades", width = 550, status = "warning", solidHeader = TRUE,
              shinycssloaders::withSpinner(DT::dataTableOutput('tablaMFed'))
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
          
  ),
  
  tabItem("IMHom", 
          h1("Índice Multidimensional Hombres"), 
          box(title = "Índice Multidimensional Entidades", width = 550, status = "warning", solidHeader = TRUE,
              shinycssloaders::withSpinner(DT::dataTableOutput('tablaMHom'))
          )
  ),
  
  tabItem("IMMuj", 
          h1("Índice Multidimensional Mujeres"), 
          box(title = "Índice Multidimensional Entidades", width = 550, status = "warning", solidHeader = TRUE,
              shinycssloaders::withSpinner(DT::dataTableOutput('tablaMMuj'))
          )
  ),
  
        tabItem("MAPA", 
            h1("Mapa de Resultados"), 
            box(title = "Mapa del índice ENPOL", width = 650, status = "warning", solidHeader = TRUE,
            leafletOutput('mapa', height = 600)
            )
    ), 
    
    tabItem("CORRUP", 
            h1('Indice de Corrupción'), 
            h2('Contenido del Cuestionario'), 
            HTML('<ul>
<li>8.2 Durante 2016, un servidor público, empleado del gobierno o custodio: <ul>
                 <li>8.2.1 ¿INTENTÓ apropiarse o le PIDIÓ de forma directa algún benefcio como dinero, bienes, regalos o favores?</li>
                 <li>8.2.2 ¿a través de un interno o abogado, le PIDIÓ dinero, bienes, regalos o favores?</li>
                 <li>8.2.3 ¿le INSINUÓ o GENERÓ las condiciones para que usted le proporcionara dinero, bienes, regalos o favores?</li>
                 </ul>
                 </li>
                 <li>8.3 Dígame por favor, durante 2016, ¿por cuáles servicios, bienes, benefcios o permisos, paga usted dentro del Centro penitenciario<ul>
                 <li>8.3.1 Usar baños, mingitorios y/o regaderas</li>
                 <li>8.3.2 Tener agua potable</li>
                 <li>8.3.3 Tener energía eléctrica en su celda</li>
                 <li>8.3.4 Tener una cama, colchoneta y/o cobijas</li>
                 <li>8.3.5 Recibir comida (rancho)</li>
                 <li>8.3.6 Salir a patio de visita</li>
                 <li>8.3.7 Ir a juzgados</li>
                 <li>8.3.8 Ir a locutorios</li>
                 <li>8.3.9 El pase de lista</li>
                 <li>8.3.10 Acceder a visita conyugal</li>
                 <li>8.3.11 Acceder a servicios médicos, psicológicos o escolares</li>
                 <li>8.3.12 Participar en algún taller</li>
                 <li>8.3.13 Tener aparatos eléctricos</li>
                 <li>8.3.14 Tener dispositivos electrónicos de comunicación</li>
                 <li>8.3.15 Cambiar de celda (evitar o cambiar de celda)</li>
                 <li>8.3.16 Tener acceso a un teléfono</li>
                 <li>8.3.17 Protección</li>
                 <li>8.3.18 Otro</li>
                 </ul>
                 </li>
                 <li>8.4 ¿A quién(es) ha tenido que pagar durante 2016 por lo que mencionó anteriormente?<ul>
                 <li>8.4.2 Custodios</li>
                 <li>8.4.3 Personal técnico penitenciario</li>
                 <li>8.4.4 Personal médico</li>
                 <li>8.4.5 Personal administrativo</li>
                 </ul>
                 </li>
                 <li>8.7 De los pagos antes mencionados, ¿usted denunció ante alguna autoridad?</li>
                 <li>8.9 Durante 2016, la(s) persona(s) que ha(n) venido a visitarlo, ¿ha(n) tenido que pagar por..<ul>
                 <li>8.9.1 pasar la comida?</li>
                 <li>8.9.2 pasar la ropa?</li>
                 <li>8.9.3 pasar otros objetos?</li>
                 <li>8.9.4 mandarlo a llamar?</li>
                 <li>8.9.5 entrar al centro?</li>
                 <li>8.9.6 tener visita conyugal?</li>
                 <li>8.9.7 Otro</li>
                 </ul>
                 </li>
                 <li>8.10 De lo mencionado anteriormente, ¿a quién(es) ha(n) tenido que pagar sus visitas?<ul>
                 <li>8.10.2 Custodios</li>
                 <li>8.10.3 Personal técnico penitenciario</li>
                 <li>8.10.4 Personal administrativo</li>
                 <li>8.10.5 Médicos</li>
                 </ul>
                 </li>
                 </ul>
                 ')
            
            ), 
    tabItem("INSEG", 
            h1('Indice de Inseguridad'), 
            h2('Contenido del Cuestionario'),
            HTML('<ul>
<li>7.47 Durante 2016, ¿a usted le ha sucedido el (CÓDIGO DE SITUACIÓN)?<ul>
                 <li>7.47.1 Le han robado objetos personales</li>
                 <li>7.47.2 Lo han amenazado o presionado para exigirle dinero o bienes (extorsión)</li>
                 <li>7.47.3 Lo han amenazado o presionado para que hiciera algo o dejara de hacerlo</li>
                 <li>7.47.4 Alguien, solo por actitud abusiva o por una discusión, lo golpeó generándole una lesión física (moretones, fracturas, cortadas, etcétera)</li>
                 <li>7.47.5 Lo han agredido mediante hostigamiento sexual, manoseo, exhibicionismo o intento de violación</li>
                 <li>7.47.6 Lo han obligado mediante violencia física o amenaza a tener una actividad sexual no deseada (violación sexual)</li>
                 </ul>
                 </li>
                 <li>7.49 ¿Quién(es) los han agredido de la forma que mencionó? <ul>
                 <li>7.49.1 Le han robado objetos personales<ul>
                 <li>7.49.1.2 Custodios</li>
                 <li>7.49.1.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.1.4 Personal médico</li>
                 </ul>
                 </li>
                 <li>7.49.2 Lo han amenazado o presionado para exigirle dinero o bienes (extorsión)<ul>
                 <li>7.49.2.2 Custodios</li>
                 <li>7.49.2.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.2.4 Personal médico</li>
                 </ul>
                 </li>
                 <li>7.49.3 Lo han amenazado o presionado para que hiciera algo o dejara de hacerlo<ul>
                 <li>7.49.3.2 Custodios</li>
                 <li>7.49.3.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.3.4 Personal médico</li>
                 </ul>
                 </li>
                 <li>7.49.4 Alguien, solo por actitud abusiva o por una discusión, lo golpeó generándole una lesión física (moretones, fracturas, cortadas, etcétera)<ul>
                 <li>7.49.4.2 Custodios</li>
                 <li>7.49.4.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.4.4 Personal médico</li>
                 </ul>
                 </li>
                 <li>7.49.5 Lo han agredido mediante hostigamiento sexual, manoseo, exhibicionismo o intento de violación<ul>
                 <li>7.49.5.2 Custodios</li>
                 <li>7.49.5.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.5.4 Personal médico</li>
                 </ul>
                 </li>
                 <li>7.49.6 Lo han obligado mediante violencia física o amenaza a tener una actividad sexual no deseada (violación sexual)<ul>
                 <li>7.49.6.2 Custodios</li>
                 <li>7.49.6.3 Personal técnico penitenciario (psicólogos, trabajadores sociales, criminólogos, secretarios)</li>
                 <li>7.49.6.4 Personal médico    </li>
                 </ul>
                 </li>
                 </ul>
                 </li>
                 </ul>
                 ')
            ),
    
    tabItem("SERVBAS", 
             h1("Indice de Servicios Básicos"), 
             h2(''),
             HTML('<ul>
                  <li>6.2 ¿Cuenta con cama propia?</li>
                  <li>6.3 Regularmente, ¿comparte su/alguna cama, camastro o colchoneta con otra persona?</li>
                  <li>6.4 Regularmente, ¿su celda está limpia?</li>
                  <li>6.5 Por favor, dígame si SU CELDA cuenta con:<ul>
                  <li>6.5.1 Agua potable</li>
                  <li>6.5.2 Drenaje</li>
                  <li>6.5.3 Luz eléctrica (Energía eléctrica)</li>
                  <li>6.5.4 Lugar para bañarse y hacer del baño</li>
                  </ul>
                  </li>
                  <li>6.6 ¿Hay un área común para bañarse y hacer del baño?</li>
                  <li>6.7 De acuerdo con su experiencia, ¿el agua potable en su celda...<ul>
                  <li>6.7.1 es pura y transparente?</li>
                  <li>6.7.2 es bebible sin temor a enfermarse?</li>
                  <li>6.7.3 tiene servicio constante?</li>
                  </ul>
                  </li>
                  <li>6.9 De acuerdo con su experiencia, ¿el drenaje en su celda..<ul>
                  <li>6.9.1 está conectado de tal forma que los desechos se descargan adecuadamente?</li>
                  <li>6.9.2 recibe mantenimiento frecuente que evita olores desagradables y plagas (cucarachas, ratas, etc.)?</li>
                  <li>6.9.3 presenta fugas de aguas negras por ruptura en el drenaje?</li>
                  </ul>
                  </li>
                  <li>6.11 De acuerdo con su experiencia, ¿el servicio de luz eléctrica (energía eléctrica) en su celda...<ul>
                  <li>6.11.1 ilumina adecuadamente?</li>
                  <li>6.11.2 genera la luz sufciente para que usted pueda leer o trabajar sin lastimarse la vista?</li>
                  <li>6.11.3 en caso de falla se da atención inmediata a la falta de energía eléctrica?</li>
                  </ul>
                  </li>
                  <li>6.13 De acuerdo con su experiencia, ¿el lugar para bañarse y hacer del baño...<ul>
                  <li>6.13.1 cuenta con regaderas para que usted pueda bañarse?</li>
                  <li>6.13.2 cuenta con un espacio para hacer del baño (sanitarios)?</li>
                  <li>6.13.3 cuenta con lavamanos?</li>
                  <li>6.13.4 está limpio?</li>
                  </ul>
                  </li>
                  <li>6.15 ¿El Centro le ha proporcionado (RENGLÓN)...<ul>
                  <li>6.15.1 servicios médicos?</li>
                  <li>6.15.2 medicamentos?</li>
                  <li>6.15.3 alimentos?</li>
                  </ul>
                  </li>
                  <li>6.17 ¿El Centro le ha proporcionado (RENGLÓN)...<ul>
                  <li>6.17.1 ropa (uniformes)?</li>
                  <li>6.17.2 calzado?</li>
                  <li>6.17.3 cobijas?</li>
                  <li>6.17.4 artículos de limpieza personal (jabón, papel higiénico, pasta de dientes, etcétera)?   </li>
                  </ul>
                  </li>
                  </ul>
                  ')
             
             )
  )  
)
  # Ejecutable  
  dashboardPage(dbHeader, sidebar = sidebar, body, skin = "black")      
})
