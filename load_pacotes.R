#Carregar pacotes
#Carregamento de pacotes
if (!require(pacman)) install.packages("pacman")

pacman::p_load(
  shiny, # Permite criar aplicativos web interativos com R
  shinydashboard, # Cria painéis interativos com o Shiny
  shinydashboardPlus, # Adiciona mais recursos e opções ao pacote shinydashboard
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
