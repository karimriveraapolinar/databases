--Question 1
SELECT 
    stand_name,
    UPPER(stand_name) as STAND_UPPER,
    LOWER(stand_name) as STAND_LOWER,
    INITCAP(stand_name) as STAND_TITLE
FROM stand_user;
--Question 2
SELECT 
    user_name,
    catchphrase,
    LENGTH(catchphrase) as PHRASE_LENGTH
FROM stand_user
ORDER BY PHRASE_LENGTH DESC;
--Question 3
SELECT 
    stand_name,
    SUBSTR(stand_name, 1,8) as STAND_SHORT
FROM stand_user;
--Question 4
SELECT 
    stand_name,
    INSTR(stand_name, 'World') as WORLD_POSITION
FROM stand_user;
--Question 5
SELECT 
    user_name,
    LPAD(POWER,8,'*') as POWER_BAR
FROM stand_user;
--Question 6
SELECT 
    user_name,
    POWER,
    ROUND(POWER,-2) AS ROUNDED_POWER,
    TRUNC(POWER,-2) AS TRUNCATED_POWER,
    MOD(POWER,300) AS POWER_MOD_300
FROM stand_user;
--Question 7
SELECT 
    user_name,
    NVL2(PRECISION,TO_CHAR(PRECISION), 'Unknown') AS PRECISION_STATUS
FROM stand_user;
--Question 8
SELECT USER_NAME, DEBUT_DATE, NEXT_DAY(ADD_MONTHS (DEBUT_DATE, 6), 'MONDAY') AS "TRAINING_REVIEN"
FROM stand_user;
--Qyestion 9
SELECT USER_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, DEBUT_DATE)) AS "MONTHS_SINCE_DEBUT"
FROM stand_user;
--Question 10
SELECT USER_NAME, STAND_NAME, CONCAT(CATCHPHRASE, CONCAT(' but dreams of', "POWER" * 3)) as DREAM_STATEMENT
FROM stand_user;
--Question 11
SELECT stand_name FROM stand_user
WHERE REGEXP_LIKE(stand_name, 'world', 'i' );
--Question 12
SELECT USER_NAME, STAND_NAME, SOUNDEX(STAND_NAME) AS "SOUND_CODE"
FROM stand_user;