// ============================
// CONSTRAINTS
// ============================

CREATE CONSTRAINT playlist_id IF NOT EXISTS
FOR (p:Playlist)
REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT track_id IF NOT EXISTS
FOR (t:Track)
REQUIRE t.id IS UNIQUE;

CREATE CONSTRAINT genre_name IF NOT EXISTS
FOR (g:Genre)
REQUIRE g.name IS UNIQUE;


// ============================
// LOAD TRACKS + GENRES
// ============================

LOAD CSV WITH HEADERS FROM
'https://raw.githubusercontent.com/juquisb/Indicacao_de_musica_cypher/main/genres_v2.csv'
AS row

WITH row
WHERE row.id IS NOT NULL

MERGE (t:Track {id: row.id})

SET
t.name = row.song_name,
t.danceability = toFloat(row.danceability),
t.energy = toFloat(row.energy),
t.tempo = toFloat(row.tempo),
t.valence = toFloat(row.valence),
t.duration_ms = toInteger(row.duration_ms)

MERGE (g:Genre {name: row.genre})

MERGE (t)-[:HAS_GENRE]->(g);


// ============================
// LOAD PLAYLISTS RELATION
// ============================

LOAD CSV WITH HEADERS FROM
'https://raw.githubusercontent.com/juquisb/Indicacao_de_musica_cypher/main/playlists.csv'
AS row

WITH row
WHERE row.Playlist IS NOT NULL AND row.Track IS NOT NULL

MERGE (p:Playlist {id: row.Playlist})
MERGE (t:Track {id: row.Track})

MERGE (p)-[:HAS_TRACK]->(t);
