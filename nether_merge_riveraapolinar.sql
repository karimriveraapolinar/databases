SELECT * FROM fortress1;
SELECT * FROM fortress2;
SELECT * FROM biomes;
SELECT COUNT(*) AS start_count_f1 FROM fortress1;



--Question 1
SELECT MOB_NAME
FROM fortress1
WHERE SPAWNS = (SELECT MAX(SPAWNS) FROM fortress1);
-- Question 2
SELECT MOB_NAME, SPAWNS
FROM fortress1
WHERE SPAWNS >  ANY(SELECT SPAWNS FROM fortress2);
--Question 3
SELECT MOB_NAME, BIOME_ID
FROM fortress1
WHERE (mob_name,biome_id) IN (
    SELECT mob_name, biome_id
    FROM fortress2
);
-- Question 4
SELECT f1.MOB_NAME, f1.BIOME_ID, f1.SPAWNS, (SELECT AVG(SPAWNS) 
FROM fortress1 f2 
WHERE f2.BIOME_ID = f1.BIOME_ID) AS AVG_BIOME_SPAWNS,
    CASE 
        WHEN f1.SPAWNS > (SELECT AVG(SPAWNS) 
                          FROM fortress1 f2 
                          WHERE f2.BIOME_ID = f1.BIOME_ID)
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS STATUS
FROM fortress1 f1;
--Question 5




--Question 7
INSERT INTO fortress1 (mob_name, biome_id, spawns, last_seen)
SELECT f2.mob_name, f2.biome_id, f2.spawns, f2.last_seen
FROM fortress2 f2
WHERE NOT EXISTS (
    SELECT 1
    FROM fortress1 f1
    WHERE f1.mob_name = f2.mob_name
    AND f1.biome_id = f2.biome_id
);
SELECT COUNT(*) FROM fortress1;