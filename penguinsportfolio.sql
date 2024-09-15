  -- penguins dataset downloaded from https://gist.github.com/slopp/ce3b90b9168f2f921784de84fa445651 
  -- The Palmers Penguins Dataset is a dataet that contains size measurements for penguin species observed on three islands in the Palmer Archipelago, Antarctica. 


SELECT
  *
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins`
LIMIT 1000;

-- How many species OF penguins are IN the Archipelego? 3

SELECT
  COUNT(DISTINCT(species))
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins` 
  
  -- How many islands are there?

SELECT
  COUNT(DISTINCT(island))
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins` 
  
  -- What IS the average bill length BY island?

SELECT
  island,
  AVG(bill_length_mm)
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins`
GROUP BY
  island 
  
  -- Bill length was set as a string IN import, causing an error when trying to aggregate

SELECT
  island,
  AVG(CAST(bill_length_mm AS float64))
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins`
WHERE
  bill_length_mm != "NA"
GROUP BY
  island
ORDER BY
  island 
  
  -- Check the original table schema when uploading. You can either reupload using the right schema or cast the columns as the tight data types to be able to average

CREATE TABLE
  portfolio-435717.PenguinsProject.cleanedpenguins AS
SELECT
  rowid,
  species,
  island,
  CAST(bill_length_mm AS float64) AS bill_length_mm_float,        -- make ALL the measurements float 
  CAST(flipper_length_mm AS float64) AS flipperlength_mm_float,
  CAST(body_mass_g AS float64) AS body_mass_g_float,
  sex,
  year
FROM
  `portfolio-435717.PenguinsProject.Palmer Penguins`
WHERE

  sex != "NA"              


-- "cleanedpenguins" is the new table with the measurements as the right data types and all NA values dropped. now the average function should work

SELECT
  island,
  avg(bill_length_mm_float) as avgbilllengthmm,
FROM 
   portfolio-435717.PenguinsProject.cleanedpenguins
GROUP BY
  island
ORDER BY
  island

--Avergae bill length by island and gender

SELECT
  island,
  sex,
  avg(bill_length_mm_float) as avgbilllengthmm,
FROM 
   portfolio-435717.PenguinsProject.cleanedpenguins
GROUP BY
  island, sex
ORDER BY
  island


-- See all years the data was taken because you only want one year

SELECT
  distinct(year)
FROM 
   portfolio-435717.PenguinsProject.cleanedpenguins


-- I only want body averages by gender from year 2009, the latest data

SELECT
  sex,
  avg(body_mass_g_float)
  
FROM 
   portfolio-435717.PenguinsProject.cleanedpenguins
WHERE
  year = 2009
GROUP BY sex


-- What is the max and min flipper length for the sexes

Select 
sex,
max(flipperlength_mm_float) as maxflipperlength,
min(flipperlength_mm_float) as minflipperlegnth
FROM 
   portfolio-435717.PenguinsProject.cleanedpenguins
GROUP BY
  sex

-- Let us seperate the data into diffrent columns  just to test JOINS

Create table portfolio-435717.PenguinsProject.penguinspecies as
  SELECT
    rowid,
    species
  FROM
    portfolio-435717.PenguinsProject.cleanedpenguins ;

Create table portfolio-435717.PenguinsProject.penguinisland as
  SELECT
    rowid,
    island
  FROM
    portfolio-435717.PenguinsProject.cleanedpenguins;


-- We now have two new tables that just contain row id and species, and row id and island, lets JOIN them


SELECT
  species,
  island,
  pi.rowid,
FROM 
  portfolio-435717.PenguinsProject.penguinisland as pi
JOIN
  portfolio-435717.PenguinsProject.penguinspecies as ps
ON 
pi.rowid = ps.rowid
ORDER BY
  ps.rowid desc

-- lets create a new table out of this JOIN and call it "penguinislandspecies"

CREATE TABLE portfolio-435717.PenguinsProject.penguinislandspecies as
  SELECT
  species,
  island,
  pi.rowid,
FROM 
  portfolio-435717.PenguinsProject.penguinisland as pi
JOIN
  portfolio-435717.PenguinsProject.penguinspecies as ps
ON 
pi.rowid = ps.rowid
ORDER BY
  ps.rowid desc


-- Lets inser a new value into this table

INSERT INTO 
  portfolio-435717.PenguinsProject.penguinislandspecies (species,island,rowid)
VALUES
  ("Kenny", "Kennys House", 355)

-- Check the inserted value

Select 
  *
FROM
  portfolio-435717.PenguinsProject.penguinislandspecies
ORDER BY rowid desc
LIMIT 10

-- Lets delete the inserted value

DELETE
FROM
  portfolio-435717.PenguinsProject.penguinislandspecies
WHERE 
  island = "Kennys House"


-- Check if the value was delted

Select 
  *
FROM
  portfolio-435717.PenguinsProject.penguinislandspecies
ORDER BY rowid desc
LIMIT 10


-- The inserted row is now gone. Thanks for exploring this data with me






 






