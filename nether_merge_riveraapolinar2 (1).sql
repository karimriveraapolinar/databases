-- Karim Rivera-Apolinar 11/6/25

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
--Question 5  (Chatgpt/ Abid Help)
SELECT MOB_NAME, SPAWNS
FROM FORTRESS1 f1
WHERE SPAWNS > (SELECT AVG(SPAWNS)
    FROM (SELECT AVG(SPAWNS) AS "avg_spawn"
        FROM FORTRESS1
        GROUP BY BIOME_ID
    )
);

--Question 6 
WITH BIOME_SUMMARY AS (
    SELECT b.BIOME_ID, b.BIOME_NAME, 
        (SELECT AVG(SPAWNS) FROM fortress1 f1 WHERE f1.BIOME_ID = b.BIOME_ID) AS F1_AVG, 
        (SELECT AVG(SPAWNS) FROM fortress2 f2 WHERE f2.BIOME_ID = b.BIOME_ID) AS F2_AVG
    FROM biomes b
)
SELECT * 
FROM BIOME_SUMMARY
ORDER BY BIOME_ID;


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

--Question 8
MERGE INTO fortress1 f1
USING fortress2 f2
ON (f1.mob_name = f2.mob_name)
WHEN MATCHED THEN
    UPDATE SET
        f1.spawns = f2.spawns,
        f1.last_seen = f2.last_seen
 
WHEN NOT MATCHED THEN
    INSERT (mob_name, spawns, last_seen, biome_id)
    VALUES (f2.mob_name, f2.spawns, f2.last_seen, f2.biome_id);

--Verification
SELECT * FROM fortress1
ORDER BY biome_id, mob_name;