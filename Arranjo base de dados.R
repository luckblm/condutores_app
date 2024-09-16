#Arranjo base de dados

#Dados Demográficos----

## 1 - Total condutores no ano corrente----
cpa <- dados %>% group_by(ano) %>% summarise(valor = n(), .groups = 'drop')
cpa <- full_join(anos_completos, cpa, by = "ano") %>%
  mutate(nivel = "Estadual",ri = "Pará", muni = "Pará") %>% select(nivel,ri, muni, ano, valor)

# Agrupar os dados por município
cm <- dados %>% group_by(muni, ano) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano)
combinar <- full_join(ri, combinar, by = "muni")
cm <- full_join(combinar,cm, by = c("muni","ano"))

#Total de condutores Região de Integração
cri <- cm %>%  group_by(ri, ano) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,valor)

cm <- cm %>% mutate(nivel = "Municipal") %>% select(nivel,ri,muni,ano,valor)
cri <- cri %>% mutate(nivel = "Região de Integração") %>% select(nivel,ri,muni,ano,valor)
data_01 <- rbind(cpa,cri,cm)
data_01 <- data_01 %>% mutate(valor = replace_na(valor, 0),ano = as.character(ano))
rm(cpa,cri,cm)

## 2 - Total condutores acumulado----
cpa <- dados %>% group_by(ano) %>% summarise(valor = n(), .groups = 'drop')
cpa <- full_join(anos_completos, cpa, by = "ano") %>%
  mutate(nivel = "Estadual",ri = "Pará", muni = "Pará") %>% select(nivel,ri, muni, ano, valor)
cpa[is.na(cpa)] <- 0
cpa <- cpa %>% mutate(valor = cumsum(valor))

# Agrupar os dados por município
cm <- dados %>% group_by(muni, ano) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano)
combinar <- full_join(ri, combinar, by = "muni")
cm <- full_join(combinar,cm, by = c("muni","ano"))
cm[is.na(cm)] <- 0
cm2 <- cm %>% group_by(muni) %>% mutate(valor = cumsum(valor))
cm2 <- cm2 %>% mutate(nivel = "Municipal") %>% select(nivel,ri,muni,ano,valor)
  
#Total de condutores Região de Integração
cri <- cm %>%  group_by(ri, ano) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,valor)
cri <- cri %>% mutate(nivel = "Região de Integração") %>% select(nivel,ri,muni,ano,valor)
cri[is.na(cri)] <- 0
cri <- cri %>% group_by(ri) %>% mutate(valor = cumsum(valor))

data_02 <- rbind(cpa,cri,cm2)
data_02 <- data_02 %>% mutate(valor = replace_na(valor, 0),ano = as.character(ano))
rm(cpa,cri,cm,cm2)




## 3 - Sexo----
#Contagem por total Estado por Sexo
spa <- dados %>% group_by(ano,sexo) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = sexos$sexo)
spa <- full_join(combinar, spa, by = c("ano", "categoria" = "sexo")) %>% mutate(ri = "Pará", muni = "Pará")
spa <- spa %>% select(ri, muni, ano, categoria, valor)
#Contagem por total Municipio por Sexo
sm <- dados %>% group_by(muni,ano,sexo) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano, categoria = sexos$sexo)
combinar <- full_join(ri, combinar, by = "muni")
sm <-  full_join(combinar, sm, by = c("muni","ano", "categoria" = "sexo"))
#Contagem por total Região de Integração por Sexo
sri <- sm %>%  group_by(ri, ano, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,categoria,valor)
data_03 <- rbind(spa,sri,sm)
rm(spa,sri,sm)

## 4 - Idade dos condutores ano da habilitação----
#Contagem por total Estado por Sexo
ipa <- dados %>% group_by(ano,intervalos_idade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = faixa$intervalos_idade)
ipa <- full_join(combinar, ipa, by = c("ano", "categoria" = "intervalos_idade")) %>% mutate(ri = "Pará", muni = "Pará")
ipa <- ipa %>% select(ri, muni, ano, categoria, valor)
#Contagem por total Municipio por Sexo
im <- dados %>% group_by(muni,ano,intervalos_idade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano, categoria = faixa$intervalos_idade)
combinar <- full_join(ri, combinar, by = "muni")
im <-  full_join(combinar, im, by = c("muni","ano", "categoria" = "intervalos_idade"))
#Contagem por total Região de Integração por Sexo
iri <- im %>%  group_by(ri, ano, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,categoria,valor)
data_04 <- rbind(ipa,iri,im)
rm(ipa,iri,im)


## 5 - Dados de Categoria Habilitação----
#Base para agrupar tipo de categoria da carteira
hv <- dados %>% select(- moto) %>% rename(categoria = veiculo)
hm <- dados %>% select(- veiculo) %>% rename(categoria = moto)
hvm <- rbind(hv,hm)
hvm <- hvm %>% filter(!is.na(categoria))

#Contagem Total Estado Categoria Habilitação
hpa <- hvm %>% group_by(ano,categoria) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = habi$categoria)
hpa <- full_join(combinar, hpa, by = c("ano", "categoria")) %>% mutate(ri = "Pará", muni = "Pará")
hpa <- hpa %>% select(ri, muni, ano, categoria, valor)

#Contagem por Municipio Categoria Habilitação

hm <- hvm %>% group_by(muni,ano,categoria) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano, categoria = habi$categoria)
combinar <- full_join(ri, combinar, by = "muni")
hm <-  full_join(combinar, hm, by = c("muni","ano", "categoria"))

#Contagem por total Região de Integração por Sexo

hri <- hm %>%  group_by(ri, ano, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,categoria,valor)
data_05 <- rbind(hpa,hri,hm)
rm(hpa,hri,hm,hvm,hv)

## 6 - Condutores Com Ambas categorias ou uma delas----

#Contagem por total Estado por Sexo
cpa <- dados %>% group_by(ano,categoria_mista) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = mista$categoria_mista)
cpa <- full_join(combinar, cpa, by = c("ano", "categoria" = "categoria_mista")) %>% mutate(ri = "Pará", muni = "Pará")
cpa <- cpa %>% select(ri, muni, ano, categoria, valor)

#Contagem por total Municipio por Sexo

cm <- dados %>% group_by(muni,ano,categoria_mista) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano, categoria = mista$categoria_mista)
combinar <- full_join(ri, combinar, by = "muni")
cm <-  full_join(combinar, cm, by = c("muni","ano", "categoria" = "categoria_mista"))

#Contagem por total Região de Integração por Sexo

cri <- cm %>%  group_by(ri, ano, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,categoria,valor)
data_06 <- rbind(cpa,cri,cm)
rm(cpa,cri,cm)

###6_1-Validade CNH----
validade <- tibble(validade = unique(dados$status_cnh))
vpa <- dados %>% group_by(ano,status_cnh) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = validade$validade)
vpa <- full_join(combinar, vpa, by = c("ano", "categoria" = "status_cnh")) %>% mutate(ri = "Pará", muni = "Pará")
vpa <- vpa %>% select(ri, muni, ano, categoria, valor)



## 7 - Atividade remunerada----

#Contagem por total Estado Atividade remunerada
apa <- dados %>% group_by(ano,atividade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, categoria = atividade$categoria)
apa <- full_join(combinar, apa, by = c("ano", "categoria" = "atividade")) %>% 
  mutate(ri = "Pará", muni = "Pará")
apa <- apa %>% select(ri, muni, ano, categoria, valor)

#Contagem por total Municipio Atividade remunerada

am <- dados %>% group_by(muni,ano,atividade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano, categoria = atividade$categoria)
combinar <- full_join(ri, combinar, by = "muni")
am <-  full_join(combinar, am, by = c("muni","ano", "categoria" = "atividade"))

#Contagem por total Região de Integração Atividade remunerada
ari <- am %>%  group_by(ri, ano, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,categoria,valor)
data_07 <- rbind(apa,ari,am)
rm(apa,ari,am)



#Cruzamento de Variáveis----
#Dataframe necessárias
## 8 - Sexo e faixa etária----
#Distribuição por sexo e faixa etária total Estado

s_f_pa <- dados %>% group_by(ano,sexo,intervalos_idade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, sexo = sexos$sexo, categoria = faixa$intervalos_idade)
s_f_pa <- full_join(combinar, s_f_pa, by = c("ano","sexo", "categoria" = "intervalos_idade")) %>% 
  mutate(ri = "Pará", muni = "Pará")
s_f_pa <- s_f_pa %>% select(ri, muni, ano,sexo,categoria, valor)
#Município, Sexo e Faixa Etária
s_f_m <- dados %>% group_by(,muni,ano,sexo,intervalos_idade) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano,sexo = sexos$sexo, categoria = faixa$intervalos_idade)
combinar <- full_join(ri, combinar, by = "muni")
s_f_m <-  full_join(combinar, s_f_m, by = c("muni","ano", "sexo", "categoria" = "intervalos_idade"))
#Contagem por total Região de Integração 
s_f_ri <- s_f_m %>%  group_by(ri, ano, sexo, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,sexo,categoria,valor)
data_08 <- rbind(s_f_pa,s_f_ri,s_f_m)
rm(s_f_pa,s_f_ri,s_f_m)

## 9 - Sexo e Categoria Habilitação----
#Distribuição por sexo e Categoria Habilitação total Estado

hv <- dados %>% select(- moto) %>% rename(categoria = veiculo)
hm <- dados %>% select(- veiculo) %>% rename(categoria = moto)
hvm <- rbind(hv,hm)
hvm <- hvm %>% filter(!is.na(categoria))
s_h_pa <- hvm %>% group_by(ano,sexo,categoria) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, sexo = sexos$sexo, categoria = habi$categoria)
s_h_pa <- full_join(combinar, s_h_pa, by = c("ano","sexo","categoria")) %>% 
  mutate(ri = "Pará", muni = "Pará")
s_h_pa <- s_h_pa %>% select(ri, muni, ano,sexo,categoria, valor)
#Município, Sexo e Faixa Etária
s_h_m <- hvm %>% group_by(muni,ano,sexo,categoria) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano,sexo = sexos$sexo, categoria = habi$categoria)
combinar <- full_join(ri, combinar, by = "muni")
s_h_m <-  full_join(combinar, s_h_m, by = c("muni","ano", "sexo", "categoria"))

#Contagem por total Região de Integração 
s_h_ri <- s_h_m %>%  group_by(ri, ano, sexo, categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,sexo,categoria,valor)
data_09 <- rbind(s_h_pa,s_h_ri,s_h_m)
rm(s_h_pa,s_h_ri,s_h_m,hm,hv,hvm)

## 10 - Sexo e Veiculo e/ou Moto----
s_t_pa <- dados %>% group_by(ano,sexo,categoria_mista) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(ano = anos_completos$ano, sexo = sexos$sexo, categoria = mista$categoria_mista)
s_t_pa <- full_join(combinar, s_t_pa, by = c("ano","sexo","categoria" = "categoria_mista")) %>% 
  mutate(ri = "Pará", muni = "Pará")
s_t_pa <- s_t_pa %>% select(ri, muni, ano,sexo,categoria,valor)
#Município, Sexo e Faixa Etária
s_t_m <- dados %>% group_by(muni,ano,sexo,categoria_mista) %>% summarise(valor = n(), .groups = 'drop')
combinar <- expand.grid(muni = ri$muni, ano = anos_completos$ano,sexo = sexos$sexo, categoria = mista$categoria_mista)
combinar <- full_join(ri, combinar, by = "muni")
s_t_m <-  full_join(combinar, s_t_m, by = c("muni","ano", "sexo","categoria" = "categoria_mista"))
#Contagem por total Região de Integração 
s_t_ri <- s_t_m %>%  group_by(ri,ano,sexo,categoria) %>% 
  summarise(valor = sum(valor,na.rm = T), .groups = 'drop') %>% mutate(muni = ri) %>% 
  select(ri,muni,ano,sexo,categoria,valor)
data_10 <- rbind(s_t_pa,s_t_ri,s_t_m)
rm(s_t_pa,s_t_ri,s_t_m)

#Limpar
rm(combinar,dados,faixa,habi,mista,ri,sexos,atividade,anos_completos,base_dados)

