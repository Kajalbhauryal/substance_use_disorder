-- Create a cleaned view with standardized and validated data
USE kajal_local_projects;
CREATE OR REPLACE VIEW SUBSTANCE_USE_DISORDERS AS
SELECT 
    `Year`,
    TRIM(`County of Program Location`) AS `County`,
    TRIM(`Program Category`) AS `Program_Category`,
   TRIM(`Service Type`) AS `Service_Type`,
    TRIM(`Age Group`) AS `Age_Group`,
    TRIM(`Primary Substance Group`) AS `Primary_Substance_Group`,
    -- Cap admissions at a realistic threshold (e.g., 99th percentile or a defined max value)
    CASE 
       WHEN `Admissions` > 2861 THEN 2861
       ELSE `Admissions`
   END AS `Admissions`,
CASE 
	WHEN TRIM(`Age Group`) LIKE 'UNDER 18' THEN '<18'
    WHEN TRIM(`Age Group`) LIKE '18 THROUGH 24' THEN '18-24'
	WHEN TRIM(`Age Group`) LIKE '25 THROUGH 34' THEN '25-34'
    WHEN TRIM(`Age Group`) LIKE '35 THROUGH 44' THEN '35-44'
	WHEN TRIM(`Age Group`) LIKE '45 THROUGH 54' THEN '45-54'
	WHEN TRIM(`Age Group`) LIKE '55 AND OLDER' THEN '>54'
 ELSE NULL
END AS 'Age_Range'
FROM `kajal_local_projects`.`substance_use_disorder_treatment_program`
WHERE `Year` BETWEEN 1900 AND 2024; -- Filter out invalid years;




select * From substance_use_disorders