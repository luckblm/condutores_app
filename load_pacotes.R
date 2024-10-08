#Carregar pacotes
#Carregamento de pacotes
if (!require(pacman)) install.packages("pacman")

pacman::p_load(
  shiny, # Permite criar aplicativos web interativos com R
  bs4Dash, # Fornece um conjunto de ferramentas e temas Bootstrap 4 para criar dashboards interativos com Shiny
  shinyWidgets, # Adiciona mais widgets e opções ao Shiny
  shinycssloaders, # Adiciona animações de carregamento a saídas Shiny
  shinyjs, # Permite usar JavaScript em aplicativos Shiny
  waiter, # Adiciona telas de carregamento a aplicativos Shiny
  rintrojs,
  # Manipulação e visualização de dados
  tidyverse, # Uma coleção de pacotes R para manipulação e visualização de dados
  DT, # Fornece uma interface R para a biblioteca JavaScript DataTables, permitindo criar tabelas interativas
  janitor, # Fornece funções para limpeza de dados
  reactablefmtr, # Fornece funções de formatação para o pacote reactable
  reactable, # Cria tabelas interativas com R
  viridis, # Fornece paletas de cores para visualizações de dados
  
  # Interação com HTML e JavaScript
  htmlwidgets, # Permite criar widgets HTML para uso em documentos R Markdown e aplicativos Shiny
  htmltools, # Fornece ferramentas para trabalhar com HTML em R
  #crosstalk, # Permite que widgets HTML criados com diferentes pacotes se comuniquem entre si em documentos R Markdown e aplicativos Shiny sem a necessidade de um servidor Shiny
  
  # Leitura e escrita de arquivos
  openxlsx, # Lê e escreve arquivos do Microsoft Excel
  readxl, # Lê arquivos do Excel em R
  
  # Gráficos interativos
  echarts4r, # Cria gráficos interativos com a biblioteca JavaScript Echarts
  billboarder, # Cria gráficos interativos com a biblioteca JavaScript billboard.js
  
  # Dados geoespaciais
  #geobr, # Lê dados geoespaciais do Brasil em diferentes níveis administrativos
  leaflet, # Cria mapas interativos com R
  sf, # Fornece classes e funções para trabalhar com dados geoespaciais em R
  sp, # Fornece classes e métodos para análise de dados espaciais em R
  #rgdal, # Fornece vinculações para as bibliotecas GDAL (Geospatial Data Abstraction Library, e PROJ.4 para leitura, escrita e projeção de dados geoespaciais em R
  
  # Outros
  #prompter, # Permite adicionar prompts de comando em aplicativos Shiny
  fontawesome, # Fornece acesso aos ícones do Font Awesome em documentos R Markdown e aplicativos Shiny
  BAMMtools, # Fornece ferramentas para análise filogenética de taxas de diversificação usando o método BAMM (Bayesian Analysis of Macroevolutionary Mixtures,
  classInt) # Seleciona intervalos de classe para dados numéricos

#Função de formatação mapa
labelFormat_decimal <- function (prefix = "", suffix = "", between = " &ndash; ", digits = 3,
                                 big.mark = ",", transform = identity, decimal.mark = "."){
  formatNum <- function(x) {
    format(round(transform(x), digits), trim = TRUE, scientific = FALSE,
           big.mark = big.mark, decimal.mark = decimal.mark)
  }
  function(type, ...) {
    switch(type, numeric = (function(cuts) {
      paste0(prefix, formatNum(cuts), suffix)
    })(...), bin = (function(cuts) {
      n <- length(cuts)
      paste0(prefix, formatNum(cuts[-n]), between, formatNum(cuts[-1]),
             suffix)
    })(...), quantile = (function(cuts, p) {
      n <- length(cuts)
      p <- paste0(round(p * 100), "%")
      cuts <- paste0(formatNum(cuts[-n]), between, formatNum(cuts[-1]))
      paste0("<span title=\"", cuts, "\">", prefix, p[-n],
             between, p[-1], suffix, "</span>")
    })(...), factor = (function(cuts) {
      paste0(prefix, as.character(transform(cuts)), suffix)
    })(...))
  }
}

write_rds(base_dados,"base_dados.RDS")
read_rds("base_dados.RDS")

geopa <- st_transform(geopa, crs = 4326)


ri <- readRDS("ri.rds")
#Excluindo Pará da base ri
ri <- ri %>% filter(`Região de Integração` != "Pará")
#Renomear colunas
ri <- ri %>% rename(ri = `Região de Integração`, muni = Estado_Município)
#Base para completar Anos
anos_completos <- tibble(ano = seq(1934, 2023))

sexos <- tibble(sexo = c("Masculino","Feminino"))
faixa <- tibble(intervalos_idade = c("18-24 anos","25-34 anos","35-44 anos",
                                     "45-54 anos","55-64 anos","65-74 anos","75 anos mais"))
habi <- tibble(categoria = c("A","B","C","D","E"))
mista <- tibble(categoria_mista = c("Apenas Moto","Apenas Veículo","Ambos"))
atividade <- tibble(categoria = c("Sim","Não"))


