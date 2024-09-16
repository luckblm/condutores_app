#Caarregar base de dados----
base_dados <- read_csv("CONDUTOR_RENACH_SIDET.csv")
#Arrumando nome das variáveis----
base_dados <- base_dados %>% clean_names()

#Substituir Valores refentes a variável Sexo----
base_dados$sexo <- str_replace(base_dados$sexo, "F", "Feminino")
base_dados$sexo <- str_replace(base_dados$sexo, "M", "Masculino")
base_dados$sexo <- str_replace(base_dados$sexo, "O", "Outros")

#Substituir Valores refentes a Atividade Remunerada----
base_dados$atividade_remunerada <- str_replace(base_dados$atividade_remunerada, "N", "Não")
base_dados$atividade_remunerada <- str_replace(base_dados$atividade_remunerada, "S", "Sim")

#Excluir Calunas que não serão usadas
base_dados <- base_dados %>% select(-data_do_cadastro,-registro_nacional)

#Correção de datas
base_dados$data_de_nascimento <- str_replace(base_dados$data_de_nascimento, "04/01/1667", "04/01/1967")
base_dados$data_de_nascimento <- str_replace(base_dados$data_de_nascimento, "08/07/1878", "08/07/1978")

#Transformação de Variáveis tipo Data
base_dados <- base_dados %>% mutate(data_de_nascimento = dmy(base_dados$data_de_nascimento))

base_dados <- base_dados %>% mutate(data_primeira_habilitacao = dmy(base_dados$data_primeira_habilitacao))

base_dados <- base_dados %>% mutate(data_expedicao_da_cnh = dmy(base_dados$data_expedicao_da_cnh))

base_dados <- base_dados %>% mutate(data_validade_da_cnh = dmy(base_dados$data_validade_da_cnh))

#Calculando Idade
# 
# base_dados <- base_dados %>%  mutate(idade_condutores = floor(interval(data_de_nascimento, Sys.Date()) / years(1)))

#Municípios
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ABAETETUBA","Abaetetuba")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ABEL FIGUEIREDO","Abel Figueiredo")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ACARA","Acará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "AFUA","Afuá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "AGUA AZUL DO NORTE","Água Azul do Norte")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ALENQUER","Alenquer")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ALMEIRIM","Almeirim")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ALTAMIRA","Altamira")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ANAJAS","Anajás")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ANANINDEUA","Ananindeua")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ANAPU","Anapu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "AUGUSTO CORREA","Augusto Corrêa")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "AURORA DO PARA","Aurora do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "AVEIRO","Aveiro")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BAGRE","Bagre")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BAIAO","Baião")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BANNACH","Bannach")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BARCARENA","Barcarena")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BELEM","Belém")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BELTERRA","Belterra")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BENEVIDES","Benevides")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BOM JESUS DO TOCANTINS","Bom Jesus do Tocantins")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BONITO","Bonito")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BRAGANCA","Bragança")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BRASIL NOVO","Brasil Novo")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BREJO GRANDE DO ARAGUAIA","Brejo Grande do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BREU BRANCO","Breu Branco")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BREVES","Breves")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "BUJARU","Bujaru")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CACHOEIRA DO ARARI","Cachoeira do Arari")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CACHOEIRA DO PIRIA","Cachoeira do Piriá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CAMETA","Cametá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CANAA DOS CARAJAS","Canaã dos Carajás")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CAPANEMA","Capanema")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CAPITAO POCO","Capitão Poço")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CASTANHAL","Castanhal")
# base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "","Chaves")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "COLARES","Colares")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CONCEICAO DO ARAGUAIA","Conceição do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CONCORDIA DO PARA","Concórdia do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CUMARU DO NORTE","Cumaru do Norte")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CURIONOPOLIS","Curionópolis")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CURRALINHO","Curralinho")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CURUA","Curuá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "CURUCA","Curuçá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "DOM ELISEU","Dom Eliseu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ELDORADO DOS CARAJAS","Eldorado dos Carajás")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "FARO","Faro")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "FLORESTA DO ARAGUAIA","Floresta do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "GARRAFAO DO NORTE","Garrafão do Norte")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "GOIANESIA DO PARA","Goianésia do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "GURUPA","Gurupá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "IGARAPE-ACU","Igarapé-Açu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "IGARAPE-MIRI","Igarapé-Miri")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "INHANGAPI","Inhangapi")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "IPIXUNA DO PARA","Ipixuna do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "IRITUIA","Irituia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ITAITUBA","Itaituba")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ITUPIRANGA","Itupiranga")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "JACAREACANGA","Jacareacanga")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "JACUNDA","Jacundá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "JURUTI","Juruti")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "LIMOEIRO DO AJURU","Limoeiro do Ajuru")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MAE DO RIO","Mãe do Rio")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MAGALHAES BARATA","Magalhães Barata")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MARABA","Marabá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MARACANA","Maracanã")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MARAPANIM","Marapanim")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MARITUBA","Marituba")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MEDICILANDIA","Medicilândia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MELGACO","Melgaço")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MOCAJUBA","Mocajuba")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MOJU","Moju")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MOJUI DOS CAMPOS","Mojuí dos campos")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MojuI DOS CAMPOS","Mojuí dos campos")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MONTE ALEGRE","Monte Alegre")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "MUANA","Muaná")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "NOVA ESPERANCA DO PIRIA","Nova Esperança do Piriá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "NOVA IPIXUNA","Nova Ipixuna")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "NOVA TIMBOTEUA","Nova Timboteua")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "NOVO PROGRESSO","Novo Progresso")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "NOVO REPARTIMENTO","Novo Repartimento")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "OBIDOS","Óbidos")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "OEIRAS DO PARA","Oeiras do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ORIXIMINA","Oriximiná")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "OUREM","Ourém")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "OURILANDIA DO NORTE","Ourilândia do Norte")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PACAJA","Pacajá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PALESTINA DO PARA","Palestina do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PARAGOMINAS","Paragominas")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PARAUAPEBAS","Parauapebas")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PAU D ARCO","Pau D'Arco")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PEIXE-BOI","Peixe-Boi")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PICARRA","Piçarra")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PLACAS","Placas")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PONTA DE PEDRAS","Ponta de Pedras")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PORTEL","Portel")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PORTO DE MOZ","Porto de Moz")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PRAINHA","Prainha")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "PRIMAVERA","Primavera")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "QUATIPURU","Quatipuru")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "REDENCAO","Redenção")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "RIO MARIA","Rio Maria")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "RONDON DO PARA","Rondon do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "RUROPOLIS","Rurópolis")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SALINOPOLIS","Salinópolis")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SALVATERRA","Salvaterra")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA BARBARA DO PARA","Santa Bárbara do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA CRUZ DO ARARI","Santa Cruz do Arari")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA ISABEL DO PARA","Santa Izabel do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA IZABEL DO PARA","Santa Izabel do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA LUZIA DO PARA","Santa Luzia do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA LUZIA DO PARUA","Santa Luzia do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA MARIA DAS BARREIRAS","Santa Maria das Barreiras")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTA MARIA DO PARA","Santa Maria do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTANA DO ARAGUAIA","Santana do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTAREM","Santarém")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTAREM NOVO","Santarém Novo")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "Santarém NOVO","Santarém Novo")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SANTO ANTONIO DO TAUA","Santo Antônio do Tauá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO CAETANO DE ODIVELAS","São Caetano de Odivelas")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO DOMINGOS DO ARAGUAIA","São Domingos do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO DOMINGOS DO CAPIM","São Domingos do Capim")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO FELIX DO XINGU","São Félix do Xingu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO FRANCISCO DO PARA","São Francisco do Pará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO GERALDO DO ARAGUAIA","São Geraldo do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO JOAO DA PONTA","São João da Ponta")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO JOAO DE PIRABAS","São João de Pirabas")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO JOAO DO ARAGUAIA","São João do Araguaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO MIGUEL DO GUAMA","São Miguel do Guamá")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAO SEBASTIAO DA BOA VISTA","São Sebastião da Boa Vista")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SAPUCAIA","Sapucaia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SENADOR JOSE PORFIRIO","Senador José Porfírio")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "SOURE","Soure")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TAILANDIA","Tailândia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TERRA ALTA","Terra Alta")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TERRA SANTA","Terra Santa")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TOME-ACU","Tomé-Açu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TRACUATEUA","Tracuateua")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TRAIRAO","Trairão")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TUCUMA","Tucumã")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "TUCURUI","Tucuruí")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "ULIANOPOLIS","Ulianópolis")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "URUARA","Uruará")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "VIGIA","Vigia")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "VISEU","Viseu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "VITORIA DO XINGU","Vitória do Xingu")
base_dados$municipio_do_condutor <-  str_replace(base_dados$municipio_do_condutor, "XINGUARA","Xinguara")


#Vertor criado para filtrar apenas os municípios do Estado do Pará
locais <- c(
 "Abaetetuba",
 "Abel Figueiredo",
 "Acará",
 "Afuá",
 "Água Azul do Norte",
 "Alenquer",
 "Almeirim",
 "Altamira",
 "Anajás",
 "Ananindeua",
 "Anapu",
 "Augusto Corrêa",
 "Aurora do Pará",
 "Aveiro",
 "Bagre",
 "Baião",
 "Bannach",
 "Barcarena",
 "Belém",
 "Belterra",
 "Benevides",
 "Bom Jesus do Tocantins",
 "Bonito",
 "Bragança",
 "Brasil Novo",
 "Brejo Grande do Araguaia",
 "Breu Branco",
 "Breves",
 "Bujaru",
 "Cachoeira do Arari",
 "Cachoeira do Piriá",
 "Cametá",
 "Canaã dos Carajás",
 "Capanema",
 "Capitão Poço",
 "Castanhal",
 "Colares",
 "Conceição do Araguaia",
 "Concórdia do Pará",
 "Cumaru do Norte",
 "Curionópolis",
 "Curralinho",
 "Curuá",
 "Curuçá",
 "Dom Eliseu",
 "Eldorado dos Carajás",
 "Faro",
 "Floresta do Araguaia",
 "Garrafão do Norte",
 "Goianésia do Pará",
 "Gurupá",
 "Igarapé-Açu",
 "Igarapé-Miri",
 "Inhangapi",
 "Ipixuna do Pará",
 "Irituia",
 "Itaituba",
 "Itupiranga",
 "Jacareacanga",
 "Jacundá",
 "Juruti",
 "Limoeiro do Ajuru",
 "Mãe do Rio",
 "Magalhães Barata",
 "Marabá",
 "Maracanã",
 "Marapanim",
 "Marituba",
 "Medicilândia",
 "Melgaço",
 "Mocajuba",
 "Moju",
 "Mojuí dos campos",
 "Monte Alegre",
 "Muaná",
 "Nova Esperança do Piriá",
 "Nova Ipixuna",
 "Nova Timboteua",
 "Novo Progresso",
 "Novo Repartimento",
 "Óbidos",
 "Oeiras do Pará",
 "Oriximiná",
 "Ourém",
 "Ourilândia do Norte",
 "Pacajá",
 "Palestina do Pará",
 "Paragominas",
 "Parauapebas",
 "Pau D'Arco",
 "Peixe-Boi",
 "Piçarra",
 "Placas",
 "Ponta de Pedras",
 "Portel",
 "Porto de Moz",
 "Prainha",
 "Primavera",
 "Quatipuru",
 "Redenção",
 "Rio Maria",
 "Rondon do Pará",
 "Rurópolis",
 "Salinópolis",
 "Salvaterra",
 "Santa Bárbara do Pará",
 "Santa Cruz do Arari",
 "Santa Izabel do Pará",
 "Santa Luzia do Pará",
 "Santa Maria das Barreiras",
 "Santa Maria do Pará",
 "Santana do Araguaia",
 "Santarém",
 "Santarém Novo",
 "Santo Antônio do Tauá",
 "São Caetano de Odivelas",
 "São Domingos do Araguaia",
 "São Domingos do Capim",
 "São Félix do Xingu",
 "São Francisco do Pará",
 "São Geraldo do Araguaia",
 "São João da Ponta",
 "São João de Pirabas",
 "São João do Araguaia",
 "São Miguel do Guamá",
 "São Sebastião da Boa Vista",
 "Sapucaia",
 "Senador José Porfírio",
 "Soure",
 "Tailândia",
 "Terra Alta",
 "Terra Santa",
 "Tomé-Açu",
 "Tracuateua",
 "Trairão",
 "Tucumã",
 "Tucuruí",
 "Ulianópolis",
 "Uruará",
 "Vigia",
 "Viseu",
 "Vitória do Xingu",
 "Xinguara")

#Filtrando a Base apenas com os municípios do Estado do Pará
base_dados <- base_dados %>% filter((municipio_do_condutor %in% locais))

#Limpando o vetor
rm(locais)

#Renomeando Calunas
base_dados <- base_dados %>%
        rename(
                muni = municipio_do_condutor,
                veiculo = categoria_veiculo,
                moto = categoria_moto,
                atividade = atividade_remunerada
        )

#Convertendo datas em anos
# Converter as colunas de data para o ano correspondente
# Primeiro, convertemos a data para o formato Date com as.Date, e em seguida, extraímos o ano com format.

# Extrai o ano de nascimento a partir da coluna 'data_de_nascimento' no formato "dd-mm-YYYY"
base_dados$ano_nasc <- format(as.Date(base_dados$data_de_nascimento, format = "%d-%m-%Y"), "%Y")

# Extrai o ano de expedição da CNH a partir da coluna 'data_expedicao_da_cnh' no formato "dd-mm-YYYY"
base_dados$ano_exp_cnh <- format(as.Date(base_dados$data_expedicao_da_cnh, format = "%d-%m-%Y"), "%Y")

# Extrai o ano da primeira habilitação a partir da coluna 'data_primeira_habilitacao' no formato "dd-mm-YYYY"
base_dados$ano_habilitacao <- format(as.Date(base_dados$data_primeira_habilitacao, format = "%d-%m-%Y"), "%Y")

# Extrai o ano de validade da CNH a partir da coluna 'data_validade_da_cnh' no formato "dd-mm-YYYY"
base_dados$validade_cnh <- format(as.Date(base_dados$data_validade_da_cnh, format = "%d-%m-%Y"), "%Y")

# Converter as colunas de ano para o formato numérico
# Isso facilita operações matemáticas, como subtração, no futuro.

# Converte o ano de nascimento para numérico
base_dados$ano_nasc <- as.numeric(base_dados$ano_nasc)

# Converte o ano de expedição da CNH para numérico
base_dados$ano_exp_cnh <- as.numeric(base_dados$ano_exp_cnh)

# Converte o ano da primeira habilitação para numérico
base_dados$ano_habilitacao <- as.numeric(base_dados$ano_habilitacao)

# Converte o ano de validade da CNH para numérico
base_dados$validade_cnh <- as.numeric(base_dados$validade_cnh)

# Criar uma nova coluna 'idade_periodo' que calcula a idade da pessoa no ano da primeira habilitação
# A idade é calculada subtraindo o ano de nascimento do ano da primeira habilitação.
base_dados <- base_dados %>%  mutate(idade_periodo = ano_habilitacao - ano_nasc)
#Filtra idades maiores que 17
base_dados <- base_dados %>% filter(idade_periodo > 17)

# O resultado é uma coluna adicional que indica a idade em que cada pessoa obteve sua primeira habilitação.

# Criando intervalos de classe personalizados para a idade
# Categorizar as idades em intervalos usando a função cut
base_dados$intervalos_idade <- cut(
        # Aqui você deve fornecer uma coluna que contém as idades numéricas, não "intervalos_idade"
        base_dados$idade_periodo,  
        # Define os limites dos intervalos de idade
        breaks = c(18, 24, 34, 44, 54, 64, 74, Inf),  
        # Define as etiquetas para cada intervalo
        labels = c("18-24 anos", "25-34 anos", "35-44 anos", "45-54 anos", "55-64 anos", "65-74 anos", "75 anos mais"),
        # Especifica que o intervalo é fechado à esquerda (inclui o limite inferior, mas não o superior)
        right = FALSE  
)

#Cria coluna para indentificar quais condutores tem uma das categorias ou ambas Veículo ou moto
base_dados$categoria_mista <- ifelse(
        is.na(base_dados$veiculo) & !is.na(base_dados$moto), "Apenas Moto",
        ifelse(
                !is.na(base_dados$veiculo) & is.na(base_dados$moto), "Apenas Veículo",
                ifelse(
                        !is.na(base_dados$veiculo) & !is.na(base_dados$moto), "Ambos",
                        NA  # Caso deseje lidar com outras situações, como ambas as colunas vazias
                )
        )
)
#Ano atual
ano_atual <- as.numeric(format(Sys.Date(), "%Y"))

# # Remover linhas que contêm qualquer NA na categoria_mista
base_dados <- base_dados %>% filter(!is.na(categoria_mista))
base_dados <- base_dados %>% filter(sexo != "Outros")
base_dados$status_cnh <- ifelse(base_dados$validade_cnh < ano_atual,"Vencida", "Válida")
dados <- base_dados %>% select(ano_habilitacao,muni,sexo,veiculo,moto,categoria_mista,atividade,idade_periodo,intervalos_idade,status_cnh) %>% 
        rename(ano = ano_habilitacao)


write_rds(base_dados,"base_dados.RDS")


