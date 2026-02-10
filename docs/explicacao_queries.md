# Explicação das Queries — Recomendação de Músicas

## Objetivo
Construir consultas Cypher para análise musical e recomendação baseada em:
- Gênero musical
- Similaridade sonora
- Diversidade de playlists


## 🔥 Top Gêneros

Consulta utilizada para identificar os gêneros mais presentes na base.

Objetivo:
- Entender distribuição musical
- Validar qualidade dos dados carregados


## 🎧 Playlist Mais Diversa

Consulta para identificar playlists com maior variedade de gêneros.

Uso prático:
- Identificar playlists com maior diversidade musical
- Base para recomendação híbrida


## 🤖 Base de Recomendação

### Recomendação por Gênero
Relaciona músicas que compartilham o mesmo gênero.

Vantagem:
- Simples
- Alta precisão semântica

Limitação:
- Pouca personalização sonora


### Recomendação por Similaridade Sonora

Utiliza métricas:
- Energy
- Danceability
- Valence
- Tempo

Modelo baseado em distância ponderada.

Objetivo:
Simular lógica de recomendação baseada em características sonoras.
