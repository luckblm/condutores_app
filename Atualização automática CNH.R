Se você criar a coluna "status_cnh" no `server` do Shiny com base no ano atual, 
o cálculo será realizado sempre que o aplicativo for carregado ou recarregado. 
No entanto, o ano só será atualizado quando o aplicativo for reiniciado, pois o
valor do ano atual (`Sys.Date()`) é obtido no momento em que o servidor do Shiny é iniciado.

### Como funciona:
- **Ano atual:** `Sys.Date()` é avaliado uma vez, quando o `server` é iniciado. 
Se o aplicativo permanecer aberto e funcionando durante a virada do ano, ele continuará usando o ano que foi capturado inicialmente.
- **Recarregar o app:** Para que o ano seja recalculado e, portanto, a coluna 
"status_cnh" seja atualizada com o novo ano, o aplicativo precisaria ser recarregado após a mudança de ano.

### Soluções para garantir que o cálculo seja atualizado automaticamente:

1. **Reiniciar o App**: O método mais simples é reiniciar o Shiny app manualmente quando o ano mudar.

2. **Reatividade baseada em `Sys.Date()`**: Você pode criar uma reatividade em 
torno de `Sys.Date()` para que o ano seja recalculado a cada dia, garantindo que, 
na mudança de ano, a coluna "status_cnh" seja atualizada automaticamente.

```r
server <- function(input, output) {
  # Reatividade baseada no dia atual
  ano_atual <- reactive({
    as.numeric(format(Sys.Date(), "%Y"))
  })
  
  # Recarregar dados e recalcular coluna
  dados <- reactive({
    df <- read.csv("caminho/para/seus_dados.csv")
    df$status_cnh <- ifelse(df$ano_validade < ano_atual(), 
                            "Vencida", "Válida")
    return(df)
  })
  
  output$tabela <- renderTable({
    dados()
  })
}
```

Com essa configuração, o Shiny verificará o `Sys.Date()` a cada vez que o app é atualizado (por exemplo, a cada dia), e recalculará o ano atual e o status das CNHs automaticamente, sem a necessidade de recarregar o app manualmente.

Essa abordagem é mais eficiente se você precisar que o aplicativo esteja sempre atualizado, independentemente de quando foi iniciado.



ano_atual <- as.numeric(format(Sys.Date(), "%Y"))
base_dados$status_cnh <- ifelse(base_dados$validade_cnh < ano_atual,"Vencida", "Válida")
tabyl(base_dados,var1 = status_cnh)
