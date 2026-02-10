### Recomendação por Gênero
MATCH (t:Track {id: $trackId})-[:HAS_GENRE]->(g:Genre)
MATCH (rec:Track)-[:HAS_GENRE]->(g)
WHERE rec <> t
RETURN
t.name AS MusicaBase,
rec.name AS Recomendado,
g.name AS Genero
LIMIT 20;

//---------------------------------------------------------------//

### Recomendação por Similaridade Sonora
MATCH (base:Track {id: $trackId})
MATCH (rec:Track)
WHERE base <> rec
AND rec.energy IS NOT NULL
AND rec.danceability IS NOT NULL
AND rec.valence IS NOT NULL
AND rec.tempo IS NOT NULL
WITH base, rec,
ABS(base.energy - rec.energy) * 0.35 +
ABS(base.danceability - rec.danceability) * 0.30 +
ABS(base.valence - rec.valence) * 0.20 +
ABS(base.tempo - rec.tempo) / 200 * 0.15
AS distancia
RETURN
rec.name AS Recomendado,
distancia,
1 - distancia AS score_similaridade
ORDER BY distancia ASC
LIMIT 20;

//---------------------------------------------------------------//

### Recomendação Hibrida (Gênero + Áudio)
MATCH (base:Track {id: $trackId})-[:HAS_GENRE]->(g:Genre)
MATCH (rec:Track)-[:HAS_GENRE]->(g)
WHERE base <> rec
WITH base, rec, COUNT(g) AS generos_compartilhados
WITH base, rec, generos_compartilhados,
ABS(base.energy - rec.energy) * 0.35 +
ABS(base.danceability - rec.danceability) * 0.30 +
ABS(base.valence - rec.valence) * 0.20 +
ABS(base.tempo - rec.tempo) / 200 * 0.15
AS distancia
RETURN
rec.name AS Recomendado,
generos_compartilhados,
distancia,
generos_compartilhados * 0.4 + (1 - distancia) * 0.6 AS score_final
ORDER BY score_final DESC
LIMIT 20;





