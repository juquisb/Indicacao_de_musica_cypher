// ============================
// TOP GÊNEROS
// ============================

MATCH (g:Genre)<-[:HAS_GENRE]-(t:Track)
RETURN
g.name AS Genero,
COUNT(*) AS Quantidade
ORDER BY Quantidade DESC
LIMIT 20;


// ============================
// PLAYLIST MAIS DIVERSA
// ============================

MATCH (g:Genre)<-[:HAS_GENRE]-(t:Track)(g:Genre)<-[:HAS_GENRE]-(t:Track)
RETURN
p.id AS Playlist,
COUNT(DISTINCT g) AS GenerosDistintos
ORDER BY GenerosDistintos DESC
LIMIT 20;


// ============================
// QUANTIDADE DE MÚSICAS POR PLAYLIST
// ============================

MATCH (g:Genre)<-[:HAS_GENRE]-(t:Track)
RETURN
p.id AS Playlist,
COUNT(t) AS TotalMusicas
ORDER BY TotalMusicas DESC
LIMIT 20;
