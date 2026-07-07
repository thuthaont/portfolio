--create a full data table
SELECT a.*, c.compensation as Compensation, r.Reason as Reason
FROM `absenteeism-analysis.absenteeism_data.absenteeism_at_work` as a
JOIN `absenteeism-analysis.absenteeism_data.compensation` as c
ON a.ID = c.ID
JOIN `absenteeism-analysis.absenteeism_data.reasons` as r
ON a.`Reason for absence` = r.Number;

--find the healthiest individuals and low absenteeism
SELECT * FROM `absenteeism-analysis.absenteeism_data.absenteeism_at_work`
WHERE `Social drinker` = 0 
AND `Social smoker` = 0 
AND `Body mass index` < 25
AND `Absenteeism time in hours` < (SELECT AVG(`Absenteeism time in hours`) FROM `absenteeism-analysis.absenteeism_data.absenteeism_at_work`);

--create categorical columns for season and BMI for final data table
SELECT a.*, c.compensation as Compensation, r.Reason as Reason,
CASE WHEN `Month of absence` IN (11,12,1) THEN "Winter"
     WHEN `Month of absence` IN (2,3,4) THEN "Spring"
     WHEN `Month of absence` IN (5 ,6,7) THEN "Summer"
     WHEN `Month of absence` IN (8,9,10) THEN "Autumn"
     ELSE "Unknown" END AS `Season names`,
CASE WHEN `Body mass index` <18.5 THEN "Underweight"
     WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN "Healthy Weight"
     WHEN `Body mass index` BETWEEN 25 AND 30 THEN "Overweight"
     WHEN `Body mass index` >30 THEN "Obese"
     ELSE "Unknown" END AS `BMI Category`
FROM `absenteeism-analysis.absenteeism_data.absenteeism_at_work` as a
JOIN `absenteeism-analysis.absenteeism_data.compensation` as c
ON a.ID = c.ID
JOIN `absenteeism-analysis.absenteeism_data.reasons` as r
ON a.`Reason for absence` = r.Number;



