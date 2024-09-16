#Caarregar base de dados----
base_dados <- read_csv("~/Dropbox/Detran Diego Frota Licenciada/condutores_app/CONDUTOR_RENACH_SIDET.csv")

#Nome da Base de dados----
base_dados %>% names()

#Tipos de Variáveis----
base_dados  %>% str()

#Arrumando nome das variáveis----
base_dados <- base_dados %>% clean_names()

#Correções----
correcoes <- c(
  "BELEM" = "Belém",
  "PARAUAPEBAS" = "Parauapebas",
  "MARABA" = "Marabá",
  "CANAA DOS CARAJAS" = "Canãa dos Carajás",
  "ANANINDEUA" = "Ananindeua",
  "CASTANHAL" = "Castanhal",
  "JACUNDA" = "Jacundá",
  "ORIXIMINA" = "Oriximiná",
  "VIGIA" = "Vigia",
  "BREU BRANCO" = "Breu Branco",
  "TUCURUI" = "Tucuruí",
  "TUCUMA" = "Tucumã",
  "PARAGOMINAS" = "Paragominas",
  "DOM ELISEU" = "Dom Eliseu",
  "SAO FELIX DO XINGU" = "São Félix do Xingu",
  "JACAREACANGA" = "Jacareacanga",
  "REDENCAO" = "Redenção",
  "SALINOPOLIS" = "Salinópolis",
  "RONDON DO PARA" = "Rondon do Pará",
  "ALTAMIRA" = "Altamira",
  "BARCARENA" = "Barcarena",
  "SOURE" = "Soure",
  "MARITUBA" = "Marituba",
  "CURIONOPOLIS" = "Curionópolis",
  "ANAPU" = "Anapu",
  "BENEVIDES" = "Benevides",
  "ITAITUBA" = "Itaituba",
  "CAPANEMA" = "Capanema",
  "CURUCA" = "Curuçá",
  "TAILANDIA" = "Tailandia",
  "IPIXUNA DO PARA" = "Ipixuna do Pará",
  "RIO MARIA" = "Rio Maria",
  "OURILANDIA DO NORTE" = "Ourilândia do Norte",
  "CAPITAO POCO" = "Capitão Poço",
  "XINGUARA" = "Xinguara",
  "PEIXE-BOI" = "Peixe-Boi",
  "SANTAREM" = "Santarém",
  "MAE DO RIO" = "Mãe do Rio",
  "ULIANOPOLIS" = "Ulianópolis",
  "GOIANESIA DO PARA" = "Goianésia do Pará",
  "ITUPIRANGA" = "Itupiranga",
  "SAO GERALDO DO ARAGUAIA" = "São Geraldo do Araguaia",
  "URUARA" = "Uruará",
  "NOVO REPARTIMENTO" = "Novo Repartimento",
  "ALMEIRIM" = "Almeirim",
  "ELDORADO DOS CARAJAS" = "Eldorado dos Carajás",
  "SAO MIGUEL DO GUAMA" = "São Miguel do Guamá",
  "MEDICILANDIA" = "Medicilândia",
  "ABAETETUBA" = "Abaetetuba",
  "BRAGANCA" = "Bragança",
  "PACAJA" = "Pacajá",
  "TOME-ACU" = "Tomé-Açu",
  "SANTANA DO ARAGUAIA" = "Santana do Araguaia",
  "CONCEICAO DO ARAGUAIA" = "Conceição do Araguaia",
  "BELTERRA" = "Belterra",
  "GARRAFAO DO NORTE" = "Garrafão do Norte",
  "SANTA BARBARA DO PARA" = "Santa Bárbara do Pará",
  "SENADOR JOSE PORFIRIO" = "Senador José Porfírio",
  "FLORESTA DO ARAGUAIA" = "Floresta do Araguaia",
  "TRAIRAO" = "Trairão",
  "NOVO PROGRESSO" = "Novo Progresso",
  "BREVES" = "Breves",
  "SANTA MARIA DO PARA" = "Santa Maria do Pará",
  "MARACANA" = "Maracanã",
  "SANTA ISABEL DO PARA" = "Santa Isabel do Pará",
  "VITORIA DO XINGU" = "Vitória do Xingu",
  "SAO DOMINGOS DO ARAGUAIA" = "São Domingos do Araguaia",
  "COLARES" = "Colares",
  "RUROPOLIS" = "Ruropolis",
  "NOVA ESPERANCA DO PIRIA" = "Nova Esperança do Piria",
  "SANTA MARIA DAS BARREIRAS" = "Santa Maria das Barreiras",
  "SANTO ANTONIO DO TAUA" = "Santo Antônio do Tauá",
  "NOVA TIMBOTEUA" = "Nova Timboteua",
  "JURUTI" = "Juruti",
  "SALVATERRA" = "Salvaterra",
  "PLACAS" = "Placas",
  "MOJU" = "Moju",
  "MOCAJUBA" = "Mocajuba",
  "ALENQUER" = "Alenquer",
  "SAO JOAO DE PIRABAS" = "São João de Pirabas",
  "AUGUSTO CORREA" = "Augusto Corrêa",
  "OBIDOS" = "Óbidos",
  "SAO FRANCISCO DO PARA" = "São Francisco do Pará",
  "MAGALHAES BARATA" = "Magalhães Barata",
  "IGARAPE-ACU" = "Igarapé-Açu",
  "OUREM" = "Ourém",
  "SANTA LUZIA DO PARA" = "Santa Luzia do Pará",
  "MONTE ALEGRE" = "Monte Alegre",
  "BAIAO" = "Baião",
  "QUATIPURU" = "Quatipuru",
  "IGARAPE-MIRI" = "Igarapé-Miri",
  "BRASIL NOVO" = "Brasil Novo",
  "CAMETA" = "Cametá",
  "TRACUATEUA" = "Tracuateua",
  "MARAPANIM" = "Marapanim",
  "AGUA AZUL DO NORTE" = "Água Azul do Norte",
  "ABEL FIGUEIREDO" = "Abel Figueiredo",
  "VISEU" = "Viseu",
  "TERRA ALTA" = "Terra Alta",
  "BONITO" = "Bonito",
  "JABOATAO DOS GUARARAPES" = "Jaboatão dos Guararapes",
  "PALESTINA DO PARA" = "Palestina do Pará",
  "AURORA DO PARA" = "Aurora do Pará",
  "PATOS" = "Patos",
  "PORTEL" = "Portel",
  "PRIMAVERA" = "Primavera",
  "CURRALINHO" = "Curralinho",
  "ACARA" = "Acará",
  "SAO JOAO DO ARAGUAIA" = "São João do Araguaia",
  "BANNACH" = "Bannach",
  "PAU D ARCO" = "Pau d'Arco",
  "BUJARU" = "Bujaru",
  "IRITUIA" = "Irituia",
  "INHANGAPI" = "Inhangapi",
  "SAPUCAIA" = "Sapucaia",
  "SAO CAETANO DE ODIVELAS" = "São Caetano de Odivelas",
  "PORTO DE MOZ" = "Porto de Moz",
  "CACHOEIRA DO PIRIA" = "Cachoeira do Piriá",
  "BOM JESUS DO TOCANTINS" = "Bom Jesus do Tocantins",
  "PRAINHA" = "Prainha",
  "ITAPEMIRIM" = "Itapemirim",
  "SAO DOMINGOS DO CAPIM" = "São Domingos do Capim",
  "MACAPA" = "Macapá",
  "OEIRAS DO PARA" = "Oeiras do Pará",
  "CONCORDIA DO PARA" = "Concórdia do Pará",
  "PONTA DE PEDRAS" = "Ponta de Pedras",
  "TERRA NOVA" = "Terra Nova",
  "SANTAREM NOVO" = "Santarém Novo",
  "MUANA" = "Muana",
  "ACAILANDIA" = "Açailândia",
  "NOVA IPIXUNA" = "Nova Ipixuna",
  "AMAPA" = "Amapá",
  "SAO JOAO DA PONTA" = "São João da Ponta",
  "MELGACO" = "Melgaço",
  "LARANJAL DO JARI" = "Laranjal do Jari",
  "CACHOEIRA DO ARARI" = "Cachoeira do Arari",
  "TERRA SANTA" = "Terra Santa",
  "MOJUI DOS CAMPOS" = "Mojui dos Campos",
  "SANTA CRUZ DO ARARI" = "Santa Cruz do Arari",
  "CURUA" = "Curuá",
  "IMPERATRIZ" = "Imperatriz",
  "VILA NOVA DO MAMORE" = "Vila Nova do Mamoré",
  "SAO LUIS" = "São Luís",
  "RIO DE JANEIRO" = "Rio de Janeiro",
  "BAGRE" = "Bagre",
  "ARAGUAINA" = "Araguaína",
  "SAO BERNARDO DO CAMPO" = "São Bernardo do Campo",
  "SANTANA" = "Santana",
  "FLORIANOPOLIS" = "Florianópolis",
  "CUMARU DO NORTE" = "Cumaru do Norte",
  "JURUA" = "Juruá",
  "TABULEIRO DO NORTE" = "Tabuleiro do Norte",
  "DAVID CANABARRO" = "David Canabarro",
  "CAMPO FLORIDO" = "Campo Florido",
  "NOVA IGUACU" = "Nova Iguaçu",
  "MURIAE" = "Muriaé",
  "CAMPINAS" = "Campinas",
  "MANAUS" = "Manaus",
  "FARO" = "Faro",
  "BRASILIA" = "Brasília",
  "ANAJAS" = "Anajás",
  "UBERLANDIA" = "Uberlândia",
  "BELO HORIZONTE" = "Belo Horizonte",
  "GOIANIA" = "Goiânia",
  "LIMOEIRO DO AJURU" = "Limoeiro do Ajuru",
  "SAO PAULO" = "São Paulo",
  "CAMPO MAIOR" = "Campo Maior",
  "BOCA DO ACRE" = "Boca do Acre",
  "SANTA LUZIA DO PARUA" = "Santa Luzia do Paruá",
  "PORANGATU" = "Porangatu",
  "CALDAS NOVAS" = "Caldas Novas",
  "CABO FRIO" = "Cabo Frio",
  "TOCANTINOPOLIS" = "Tocantinópolis",
  "GOIAS" = "Goiás",
  "COROATA" = "Coroatá",
  "TEFE" = "Tefé",
  "BREJO GRANDE DO ARAGUAIA" = "Brejo Grande do Araguaia",
  "PROMISSAO" = "Promissão",
  "AVEIRO" = "Aveiro",
  "MINACU" = "Minacu",
  "LAGOA DO OURO" = "Lagoa do Ouro",
  "FORTALEZA" = "Fortaleza",
  "GURUPA" = "Gurupá",
  "MANACAPURU" = "Manacapuru",
  "COLMEIA" = "Colmeia",
  "OLINDA" = "Olinda",
  "SAO BERNARDO" = "São Bernardo",
  "SANTA INES" = "Santa Inês",
  "PICOS" = "Picos",
  "PICARRA" = "Picarra",
  "SANTA MARIA" = "Santa Maria",
  "ALCANTIL" = "Alcantil",
  "COARI" = "Coari",
  "SANTA RITA" = "Santa Rita",
  "PLANALTO DA SERRA" = "Planalto da Serra",
  "ITINGA DO MARANHAO" = "Itinga do Maranhão",
  "TENORIO" = "Tenório",
  "TERESINA" = "Teresina",
  "GUARANTA DO NORTE" = "Guarantã do Norte",
  "SAO SEBASTIAO DA BOA VISTA" = "São Sebastião da Boa Vista",
  "AFUA" = "Afuá",
  "SANTA IZABEL DO PARA" = "Santa Izabel do Pará"
)


# Função para substituir os valores na coluna
corrigir_municipios <- function(dados, correcoes) {
  for (original in names(correcoes)) {
    corrigido <- correcoes[original]
    dados$municipio_do_condutor <- str_replace(dados$municipio_do_condutor, fixed(original), corrigido)
  }
  return(dados)
}

# Aplicar a função aos seus dados
base_dados <- corrigir_municipios(base_dados, correcoes)

#Limpando
rm(correcoes,corrigir_municipios)

#Substituir Valores refentes a variável Sexo----
base_dados$sexo <- str_replace(base_dados$sexo, "F", "Feminino")
base_dados$sexo <- str_replace(base_dados$sexo, "M", "Masculino")
base_dados$sexo <- str_replace(base_dados$sexo, "O", "Outros")

#Substituir Valores refentes a Atividade Remunerada----
base_dados$atividade_remunerada <- str_replace(base_dados$atividade_remunerada, "N", "Não")
base_dados$atividade_remunerada <- str_replace(base_dados$atividade_remunerada, "S", "Sim")

#Excluir Calunas que não serão usadas
base_dados <- base_dados %>% select(-categoria_moto)







