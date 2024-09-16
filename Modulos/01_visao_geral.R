# Funções de módulo Geral
# Função de UI.

visao_geral_ui <- function(id) {
  fluidPage(
   #Painel contendo filtros e Mapa tabela e Gráfico de linnha----
    panel(
      #Controles de filtro 
      fluidRow(
        column(1,
        #Select Ano
        selectInput(
          inputId = NS(id, "ano1"),
          label = "Ano",
          choices = sort(unique(data_01[["ano"]]),decreasing = T),
          width = "200px"
        )
      ),
      column(2,
        #Select Nivel     
        selectInput(
          inputId = NS(id, "nvl"),
          label = "Nivel",
          choices = unique(data_01[["nivel"]]),
          width = "200px"
        )
      ),
      column(6,
        #Select Localidade     
        selectInput(
          inputId = NS(id, "localidade"),
          label = "Localidade",
          choices = NULL,
          width = "200px"
        )
      )),
      #Infobox's----
      panel(
      fluidRow(
        bs4InfoBoxOutput(NS(id,"total_pa_ano"),width = 6),
        bs4InfoBoxOutput(NS(id,"total_pa"),width = 6),
      )),
      #Mapa e tabela----
      fluidRow(
      ##Mapa1----
      box(
        title = textOutput(NS(id,"titulo_map1")),
        status = "primary",
        collapsed = F,
        headerBorder = T,
        width = 6,
        withSpinner(
          leafletOutput(NS(id,"mapa1")),
          type = 8,
          color = "#3C8DBD",
          size = 0.5
        ),
        footer = list(tags$h6(
          tags$b("Fonte:", style = 'font-family: sans-serif;'), "Detran-PA"
        ),
        tags$h6(tags$b("Elaboração:"), "Detran-PA"))
      ),
      ##Mapa2----
      box(
        title = textOutput(NS(id,"titulo_map2")),
        status = "primary",
        collapsed = F,
        headerBorder = T,
        width = 6,
        withSpinner(
          leafletOutput(NS(id,"mapa2")),
          type = 8,
          color = "#3C8DBD",
          size = 0.5
        ),
        footer = list(tags$h6(
          tags$b("Fonte:", style = 'font-family: sans-serif;'), "Detran-PA"
        ),
        tags$h6(tags$b("Elaboração:"), "Detran-PA"))
      )
      
      ),
        #Tabela1----
      fluidRow(
        box(
          title = textOutput(NS(id,"titulo_tabela1")),
          status = "primary",
          collapsed = F,
          headerBorder = T,
          width = 6,
          withSpinner(
            reactableOutput(NS(id,"tabela1")),
            type = 8,
            color = "#3C8DBD",
            size = 0.5
          ),
          footer = list(tags$h6(
            tags$b("Fonte:", style = 'font-family: sans-serif;'), "Detran-PA"
          ),
          tags$h6(tags$b("Elaboração:"), "Detran-PA"))
        ),
        #Tabela 2
        box(
          title = textOutput(NS(id,"titulo_tabela2")),
          status = "primary",
          collapsed = F,
          headerBorder = T,
          width = 6,
          withSpinner(
            reactableOutput(NS(id,"tabela2")),
            type = 8,
            color = "#3C8DBD",
            size = 0.5
          ),
          footer = list(tags$h6(
            tags$b("Fonte:", style = 'font-family: sans-serif;'), "Detran-PA"
          ),
          tags$h6(tags$b("Elaboração:"), "Detran-PA"))
        )
      ),
      ##Gráfico de linha----
      box(
        title = textOutput(NS(id,"titulo_grafico1")),
        status = "primary",
        collapsed = F,
        headerBorder = T,
        width = 12,
        withSpinner(
          echarts4rOutput(NS(id,"grafico1")),
          type = 8,
          color = "#3C8DBD",
          size = 0.5
        ),
        footer = list(tags$h6(
          tags$b("Fonte:", style = 'font-family: sans-serif;'), "Detran-PA"
        ),
        tags$h6(tags$b("Elaboração:"), "Detran-PA"))
      )
      
    )
  )
}
# Função do modulo servidor
visao_geral_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
    #Caixas de Valor----
    ##Total Pará Habilitados no ano----
    output$total_pa_ano <- renderInfoBox({
      valor <- data_01 %>% filter(ri == "Pará", ano == input$ano1) %>%
        summarise(total = sum(valor, na.rm = TRUE))
      bs4InfoBox(
        title = tags$strong("Pará"),
        value = tags$h2(tags$strong(
          prettyNum(
            valor$total,
            big.mark = ".",
            decimal.mark = ",",
            scientific = FALSE
          )
        )),
        subtitle = paste0("Condutores habilitados em ",input$ano1),
        fill = TRUE,
        gradient = TRUE,
        iconElevation = 2,
        color = "purple",
        icon("users")
      )
    })
    ##Total Pará Habilitados----
    output$total_pa <- renderInfoBox({
      valor <- data_02 %>% filter(ri == "Pará", ano == input$ano1) %>%
        summarise(total = sum(valor, na.rm = TRUE))
      bs4InfoBox(
        title = tags$strong("Pará"),
        value = tags$h2(tags$strong(
          prettyNum(
            valor$total,
            big.mark = ".",
            decimal.mark = ",",
            scientific = FALSE
          )
        )),
        subtitle = paste0("Total de Condutores em ",input$ano1),
        color = "primary",
        fill = TRUE,
        gradient = TRUE,
        iconElevation = 2,
        icon = icon("map")
      )
    })

#Filtro Dinâmico----
    nivel <- reactive({
      data_01 %>% filter(nivel == input$nvl)
    })
    #Atualiz o filtro localidade
    observeEvent(nivel(), {
      choices <- unique(nivel()[["muni"]])
      updateSelectInput(inputId = "localidade", choices = choices, session)
    })
    
    ##Mapa1----
    t_01 <- reactive({
      if (input$nvl == "Estadual") {
        paste0("Mapa - Condutores Habilitados - Pará - em ",input$ano1)
      } else if (input$nvl == "Região de Integração") {
        paste0("Mapa - Condutores Habilitados - Região de integração ",input$localidade," - em ",input$ano1)
      } else if (input$nvl == "Municipal") {
        paste0("Mapa - Condutores Habilitados - Municípipio de ",input$localidade," - em ",input$ano1)}
    })
    output$titulo_map1 <- renderText({
      t_01()
    })
    dados_mapa1 <- reactive({
      if (input$nvl == "Estadual") {
        x <- data_01 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano == input$ano1)
        x <- cbind(geopa,x)
      } else if (input$nvl == "Região de Integração") {
        x <- data_01 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano ==input$ano1)
        x <- cbind(geopa,x)
        x <- x %>% filter(ri == input$localidade, ano == input$ano1)
      } else if(input$nvl == "Municipal"){
        x <- data_01 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano == input$ano1)
        x <- cbind(geopa,x)
        x <- x %>% filter(muni == input$localidade, ano == input$ano1)
      }
    })
    output$mapa1 <- renderLeaflet({
      req(dados_mapa1())
      z <- dados_mapa1()$valor
      bk <- unique(getJenksBreaks(z, 6, subset = NULL))
      bins <- c(bk)
      if (length(bins) < 2 || length(bins) < 5) {
        bins <- 5
      }
      pal <-
        colorBin(
          palette = "PuRd",
          domain = dados_mapa1()$valor,
          bins = bins
        )
      conteudo <-
        sprintf(
          "<strong>%s</strong><br/> <b>Condutores:</b> %s",
          dados_mapa1()$muni,
          ifelse(
            is.na(dados_mapa1()$valor),
            "Não disponível",
            format(dados_mapa1()$valor, big.mark = ".", decimal.mark = ",")
          )
        ) %>% lapply(htmltools::HTML)
      ##Mapas com leafleft
      leaflet(dados_mapa1(), options = leafletOptions(minZoom = 0, maxZoom = 15)) %>%
        addTiles() %>% 
        addPolygons(
          weight = 2,
          opacity = 1,
          color = "black",
          fillOpacity = 1,
          fillColor = ~ pal(valor),
          dashArray = 1,
          smoothFactor = 1.5,
          highlightOptions =
            highlightOptions(
              weight = 3,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.5,
              bringToFront = TRUE
            ),
          label = conteudo,
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "15px",
            direction = "auto"
          )
        ) %>% addLegend(
          pal = pal,
          values = ~ valor,
          opacity = 0.7,
          title = "Condutores",
          position = "bottomright",
          na.label = "Não disponível",
          labFormat = labelFormat_decimal(
            big.mark = ".",
            decimal.mark = ","
          )
        ) %>% addMiniMap()
    })
    ##Mapa2----
    t_02 <- reactive({
      if (input$nvl == "Estadual") {
        paste0("Mapa - Total de Condutores Habilitados - Pará - ",input$ano1)
      } else if (input$nvl == "Região de Integração") {
        paste0("Mapa - Total de Condutores Habilitados - Região de integração ",input$localidade," - ",input$ano1)
      } else if (input$nvl == "Municipal") {
        paste0("Mapa - Total de Condutores Habilitados - Municípipio de ",input$localidade," - ",input$ano1)}
    })
    output$titulo_map2 <- renderText({
      t_02()
    })
    dados_mapa2 <- reactive({
      if (input$nvl == "Estadual") {
        x <- data_02 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano == input$ano1)
        x <- cbind(geopa,x)
      } else if (input$nvl == "Região de Integração") {
        x <- data_02 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano ==input$ano1)
        x <- cbind(geopa,x)
        x <- x %>% filter(ri == input$localidade, ano == input$ano1)
      } else if(input$nvl == "Municipal"){
        x <- data_02 %>% filter(nivel != "Estadual" & nivel != "Região de Integração",ano == input$ano1)
        x <- cbind(geopa,x)
        x <- x %>% filter(muni == input$localidade, ano == input$ano1)
      }
    })
    output$mapa2 <- renderLeaflet({
      req(dados_mapa2())
      z <- dados_mapa2()$valor
      bk <- unique(getJenksBreaks(z, 6, subset = NULL))
      bins <- c(bk)
      if (length(bins) < 2 || length(bins) < 5) {
        bins <- 5
      }
      pal <-
        colorBin(
          palette = "PuBu", 
          domain = dados_mapa2()$valor,
          bins = bins
        )
      conteudo <-
        sprintf(
          "<strong>%s</strong><br/> <b>Condutores:</b> %s",
          dados_mapa2()$muni,
          ifelse(
            is.na(dados_mapa2()$valor),
            "Não disponível",
            format(dados_mapa2()$valor, big.mark = ".", decimal.mark = ",")
          )
        ) %>% lapply(htmltools::HTML)
      ##Mapas com leafleft
      leaflet(dados_mapa2(), options = leafletOptions(minZoom = 0, maxZoom = 15)) %>%
        addTiles() %>%
        addPolygons(
          weight = 2,
          opacity = 1,
          color = "black",
          fillOpacity = 1,
          fillColor = ~ pal(valor),
          dashArray = 1,
          smoothFactor = 1.5,
          highlightOptions =
            highlightOptions(
              weight = 3,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.5,
              bringToFront = TRUE
            ),
          label = conteudo,
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "15px",
            direction = "auto"
          )
        ) %>% addLegend(
          pal = pal,
          values = ~ valor,
          opacity = 0.7,
          title = "Condutores",
          position = "bottomright",
          na.label = "Não disponível",
          labFormat = labelFormat_decimal(
            big.mark = ".",
            decimal.mark = ","
          )
        ) %>% addMiniMap()
    })

    ##Tabela 1----
    tb_01 <- reactive({
      if (input$nvl == "Estadual") {
        paste0("Quantidade de Condutores Habilitados por ano - Pará")
      } else if (input$nvl == "Região de Integração") {
        paste0("Quantidade de Condutores Habilitados por ano - Região de integração ",input$localidade)
      } else if (input$nvl == "Municipal") {
        paste0("Quantidade de Condutores Habilitados por ano - Municípipio de ",input$localidade)}
    })
    output$titulo_tabela1 <- renderText({
      tb_01()
    })
    output$tabela1 <- renderReactable({
      x <- if (input$nvl == "Estadual") {
      data_01 %>% filter(nivel == "Estadual") %>% 
          select(ano,valor)
      } else if (input$nvl == "Região de Integração") {
        data_01 %>% filter(nivel == "Região de Integração") %>% 
          filter(ri == input$localidade) %>% 
          select(ano,valor)
      } else if(input$nvl == "Municipal"){
        data_01 %>% filter(nivel == "Municipal") %>% 
          filter(muni == input$localidade) %>%  
          select(ano,valor)
      }
      x %>%
        reactable(
        defaultPageSize = 10,
        striped = FALSE,
        highlight = TRUE,
        bordered = TRUE,
        outlined = TRUE,
        resizable = TRUE,
        showSortable = TRUE,
        pagination = T,
        list(
          ano = colDef(name = "Ano da Habilitação"),
          muni = colDef(name = "Municípios"),
          valor = colDef(name = "Nº de Habilitados",format = colFormat(separators = T, locales = "pt-BR"))
        ),
        defaultColDef = colDef(
          footerStyle = list(fontWeight = "bold"),
          headerStyle = list(background = "#f7f7f8")
        ),
        language = reactableLang(
          noData = "Sem informação",
          pageInfo = "{rowStart} a {rowEnd} de {rows} linhas",
          pagePrevious = "Anterior",
          pageNext = "Próximo",
          pagePreviousLabel = "Anterior",
          pageNextLabel = "Proximo"
        )
      )
    })
    ##Tabela 2----
    tb_02 <- reactive({
      if (input$nvl == "Estadual") {
        paste0("Total Condutores Habilitados - Pará")
      } else if (input$nvl == "Região de Integração") {
        paste0("Total Condutores Habilitados por ano - Região de integração ",input$localidade)
      } else if (input$nvl == "Municipal") {
        paste0("Total Condutores Habilitados por ano - Municípipio de ",input$localidade)}
    })
    output$titulo_tabela2 <- renderText({
      tb_02()
    })
    output$tabela2 <- renderReactable({
      x <- if (input$nvl == "Estadual") {
        data_02 %>% filter(nivel == "Estadual") %>% 
          select(ano,valor)
      } else if (input$nvl == "Região de Integração") {
        data_02 %>% filter(nivel == "Região de Integração") %>% 
          filter(ri == input$localidade) %>% 
          select(ano,valor)
      } else if(input$nvl == "Municipal"){
        data_02 %>% filter(nivel == "Municipal") %>% 
          filter(muni == input$localidade) %>%  
          select(ano,valor)
      }
      x %>%
        reactable(
          defaultPageSize = 10,
          striped = FALSE,
          highlight = TRUE,
          bordered = TRUE,
          outlined = TRUE,
          resizable = TRUE,
          showSortable = TRUE,
          pagination = T,
          list(
            ano = colDef(name = "Ano da Habilitação"),
            muni = colDef(name = "Municípios"),
            valor = colDef(name = "Total acumulado de Habilitados",format = colFormat(separators = T, locales = "pt-BR"))
          ),
          defaultColDef = colDef(
            footerStyle = list(fontWeight = "bold"),
            headerStyle = list(background = "#f7f7f8")
          ),
          language = reactableLang(
            noData = "Sem informação",
            pageInfo = "{rowStart} a {rowEnd} de {rows} linhas",
            pagePrevious = "Anterior",
            pageNext = "Próximo",
            pagePreviousLabel = "Anterior",
            pageNextLabel = "Proximo"
          )
        )
    })
    #Gráfico de linha----
    tb_03 <- reactive({
      if (input$nvl == "Estadual") {
        paste0("Total acumulado de Condutores Habilitados - Pará")
      } else if (input$nvl == "Região de Integração") {
        paste0("Total acumulado de Condutores Habilitados por ano - Região de integração ",input$localidade)
      } else if (input$nvl == "Municipal") {
        paste0("Total acumulado de Condutores Habilitados por ano - Municípipio de ",input$localidade)}
    })
    output$titulo_grafico1 <- renderText({
      tb_03()
    })
    output$grafico1 <- renderEcharts4r({
      #Base de dados
      #Base de data_01
      a <- if (input$nvl == "Estadual") {
        data_01 %>% filter(nivel == "Estadual") %>%
          select(ano,valor)
      } else if (input$nvl == "Região de Integração") {
        data_01 %>% filter(nivel == "Região de Integração") %>%
          filter(ri == input$localidade) %>%
          select(ano,valor)
      } else if(input$nvl == "Municipal"){
        data_01 %>% filter(nivel == "Municipal") %>%
          filter(muni == input$localidade) %>%
          select(ano,valor)
      }
      #Base de data_02
      b <- if (input$nvl == "Estadual") {
        data_02 %>% filter(nivel == "Estadual") %>%
          select(ano,valor)
      } else if (input$nvl == "Região de Integração") {
        data_02 %>% filter(nivel == "Região de Integração") %>%
          filter(ri == input$localidade) %>%
          select(ano,valor)
      } else if(input$nvl == "Municipal"){
        data_02 %>% filter(nivel == "Municipal") %>%
          filter(muni == input$localidade) %>%
          select(ano,valor)
      }
a <- a %>% rename(valor1 = valor)  
b <- b %>% rename(valor2 = valor)
ab <- full_join(a,b,by = "ano")
ab %>% e_chart(x = ano) %>%
 e_line(
          serie = valor1,
          name = "Habilitados ao Ano",
          legend = T,
          symbol = "roundRect",
          symbolSize = 6,
          legendHoverLink = T,
        ) %>%
      e_line(
          y_index = 1,
          serie = valor2,
          name = "Total de Condutores",
          legend = T,
          symbol = "roundRect",
          symbolSize = 6,
          legendHoverLink = T,
        ) %>%
        e_tooltip(
          trigger = "axis",
          formatter = e_tooltip_pointer_formatter("decimal", digits = 0, locale = "pt-BR"),
          axisPointer = list(type = "shadow")
        ) %>%
        e_x_axis(
          axisLabel = list(show = T, fontSize = 11),
          name = "Ano",
          splitLine = list(show = T),
          nameTextStyle = list(
            fontWeight = "bold",
            fontSize = 14,
            padding = c(0, 0, 0, 20),
            verticalAlign = "top",
            lineHeight = 70
          )
        ) %>%
        e_y_axis(
          name = "Habilitados ano Ano",
          nameTextStyle = list(fontWeight = "bold", fontSize = 14),
          scale = T,
          axisLabel = list(
            formatter = htmlwidgets::JS(
              "
              function (value, index) {
              return value.toLocaleString('pt-BR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
              }
            "
            )
          )
        ) %>%
        e_y_axis(
          index = 1,
          name = "Total de Condutores",
          nameTextStyle = list(fontWeight = "bold", fontSize = 14),
          scale = T,
          axisLabel = list(
            formatter = htmlwidgets::JS(
              "
              function (value, index) {
              return value.toLocaleString('pt-BR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
              }
            "
            )
          )
        ) %>%
        e_locale("pt-Br") %>%
        e_datazoom(toolbox = F, fillerColor = "#E5F5F9") %>%
        e_grid(show = T)
    })
  })
}
# Play do Módulo
ui = dashboardPage(
  header = dashboardHeader(),
           sidebar = dashboardSidebar(),
           body = dashboardBody(fluidPage(visao_geral_ui("total"))))

server <- function(input, output) {
  visao_geral_Server("total")
}

shinyApp(ui, server)