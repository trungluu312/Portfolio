SELECT Department, Count(Department)
FROM [HR Employee]..[HR_Employee_Data$]
WHERE satisfaction_level > last_evaluation and Departure <> 1
GROUP BY Department


SELECT time_spend_company, Count(time_spend_company) AS Num, AVG(satisfaction_level)
FROM [HR Employee]..[HR_Employee_Data$]
GROUP BY time_spend_company
ORDER BY 1

SELECT Departure, Count(Departure) AS Num
FROM [HR Employee]..[HR_Employee_Data$]
GROUP BY Departure

SELECT number_project, AVG(satisfaction_level) 
FROM [HR Employee]..[HR_Employee_Data$]
GROUP BY number_project
ORDER BY 1

SELECT AVG(last_evaluation)
FROM [HR Employee]..[HR_Employee_Data$]
WHERE Departure = 0

SELECT AVG(satisfaction_level), Work_accident, Departure
FROM [HR Employee]..[HR_Employee_Data$]
GROUP BY Work_accident, Departure

SELECT promotion_last_5years, Count(promotion_last_5years) AS Num, AVG(satisfaction_level)
FROM [HR Employee]..[HR_Employee_Data$]
GROUP BY promotion_last_5years
ORDER BY 1



SELECT *
FROM [HR Employee]..[HR_Employee_Data$]