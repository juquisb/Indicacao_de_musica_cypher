
---

## ⚙️ Tecnologias Utilizadas

- Neo4j Desktop / Aura
- Cypher
- Git
- GitHub
- Git Bash

---

## 📊 Exemplos de Análises

### 🔥 Top Gêneros
Identifica os gêneros mais presentes na base.

MATCH (g:Genre)<-[:HAS_GENRE]-(t:Track)
RETURN
g.name AS Genero,
COUNT(t) AS QtdeMusicas
ORDER BY QtdeMusicas DESC
LIMIT 20;


### 🎧 Playlist Mais Diversa
Calcula quais playlists possuem maior variedade de gêneros.

MATCH (g:Genre)<-[:HAS_GENRE]-(t:Track)
RETURN
p.id AS Playlist,
COUNT(DISTINCT g) AS GenerosDistintos
ORDER BY GenerosDistintos DESC
LIMIT 20;

### Recomendação por Generos em Comum
MATCH (t:Track {id: "0vSWgAlfpye0WCGeNmuNhy"})
MATCH (t)-[:HAS_GENRE]->(g:Genre)
MATCH (rec:Track)-[:HAS_GENRE]->(g)
WHERE rec <> t
RETURN
t.name AS MusicaBase,
g.name AS Genero,
rec.name AS Recomendado
LIMIT 20;
Recomendação por Generos em Comum
MATCH (t:Track {id: "0vSWgAlfpye0WCGeNmuNhy"})-[:HAS_GENRE]->(g:Genre)
MATCH (rec:Track)-[:HAS_GENRE]->(g)
WHERE rec <> t
RETURN
rec.name AS Recomendado,
COUNT(g) AS GenerosEmComum
ORDER BY GenerosEmComum DESC
LIMIT 20;


### 🤖 Base para Recomendação
Sugestão de músicas baseada em:

- Energia
- Danceability
- Valence
- Tempo

Utilizando cálculo de distância entre features musicais.

MATCH (base:Track {id: "0vSWgAlfpye0WCGeNmuNhy"})-[:HAS_GENRE]->(g:Genre)
MATCH (rec:Track)-[:HAS_GENRE]->(g)
WHERE base <> rec
AND rec.name IS NOT NULL
WITH base, rec, COUNT(g) AS genreScore
WITH base, rec, genreScore,
ABS(base.energy - rec.energy) * 0.35 +
ABS(base.danceability - rec.danceability) * 0.30 +
ABS(base.valence - rec.valence) * 0.20 +
ABS(base.tempo - rec.tempo)/200 * 0.15 AS featureDist
WITH rec, genreScore, featureDist,
(genreScore * 0.3) + ((1 - featureDist) * 0.7) AS finalScore
RETURN
rec.name,
round(featureDist,4) AS FeatureDist,
genreScore,
round(finalScore,4) AS FinalScore
ORDER BY FinalScore DESC
LIMIT 20;

## Lógica de Similaridade

A recomendação utiliza distância ponderada entre características musicais:

- Energia → 35%
- Danceability → 30%
- Valence → 20%
- Tempo → 15%

##  Possibilidades Futuras

- Recomendação híbrida (Gênero + Similaridade sonora)
- API de recomendação
- Dashboard de visualização
- Integração com dados externos

## 📁 Estrutura do Projeto

Indicacao_de_musica_cypher/
│
├── data/
│ ├── genres_v2.csv
│ └── playlists.csv
│
├── queries/
│
├── docs/
│
└── README.md


## 📚 Aprendizados
Durante o desenvolvimento foram praticados:

- Modelagem de dados em grafos
- Criação de constraints
- Importação de dados via LOAD CSV
- Criação de relacionamentos
- Construção de lógica de recomendação

## Autor
Projeto desenvolvido para fins educacionais e portfólio.


## Observação
Este projeto faz parte dos estudos de Data Sciency de dados e análise de dados utilizando tecnologias modernas de banco de dados.
