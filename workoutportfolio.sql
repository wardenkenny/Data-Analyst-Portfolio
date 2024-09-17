-- Creating my gym routine in SQL from scratch in BigQuery

CREATE TABLE portfolio-435717.gymroutine.workouts (
Excercise string(50),
Day string(50),
Sets int,
Reps int
) ;

-- I forgot to add the weights column

ALTER TABLE portfolio-435717.gymroutine.workouts
ADD COLUMN weight int;


-- weight column needs to have an uppercase W. Can not rename column ing Bigquert to just recreate a whole new table
-- if bigquery let you rename columns it would like like this:

ALTER TABLE portfolio-435717.gymroutine.workouts
RENAME COLUMN weight to "Weight"


--but they dont, so just delete table and try again

DROP TABLE portfolio-435717.gymroutine.workouts

-- Try again with the right names

CREATE TABLE portfolio-435717.gymroutine.workouts (
Excercise string(50),
Day string(50),
Sets int,
Reps int,
Weight int
) ;

-- Insert Values
 
INSERT INTO portfolio-435717.gymroutine.workouts 
(Excercise, Day, Sets, Reps, Weight)
VALUES
("bench press", "upper a", 3,3,90),
("peck deck", "upper a",3,10,55),
("cable row", "upper a",3,10,20),
("assisted row", "upper a" ,3,10,50),
("overhead press sit", "upper a",	3,	10,	30),
("bicep curls", "upper a"	,3,	10,	40),
('tricep pulls', "upper a",	3,	10,	60)	,
("incline dumbell press"	, "upper b",3,	10,	60),
("rear delt fly"	, "upper b",3	,10,	40),
("cable chest fly" , "upper b",	3,	10,	25),
("straight arm lat"	, "upper b",3	,10,	30),
("lat pull"	, "upper b", 3	,10,	40),
("tricep push"	, "upper b",3,	10,	55),
("preacher curl"	, "upper b",3	,10,	55)		,		
("squats"	, "lower a",3,	3,	110),
("hip thrust" ,"lower a"	,3	,5	,110),
("hyperextensions"	,"lower a",3	,10,	0),
("seated abduction" ,"lower a"	,3	,15,	75),
("cable abduction",	"lower a", 3,	15,	10)	,
("RDL"	,	"lower b",3	,5	,110),
("hip thrust" ,	"lower b",	3,	5,	110),
("bulgarian" ,"lower b", 3,	8	,25),
("seated abduction"	,	"lower b" ,3	,15,	75),
("cable abduction",	"lower b" ,3	,15	,10);

-- lets now the view the data groupd by when it will be done on what day

SELECT *
FROM portfolio-435717.gymroutine.workouts
ORDER BY DAY desc

-- workout routine done!

