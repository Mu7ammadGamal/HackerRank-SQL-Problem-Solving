-- MySQL

SELECT C.company_code, C.founder, COUNT(DISTINCT LM.lead_manager_code), COUNT(DISTINCT SM.senior_manager_code), COUNT(DISTINCT M.manager_code), COUNT(DISTINCT E.employee_code)
FROM  COMPANY C, LEAD_MANAGER LM, SENIOR_MANAGER SM, MANAGER M, EMPLOYEE E
WHERE C.company_code = LM.company_code 
AND SM.lead_manager_code = LM.lead_manager_code 
AND M.senior_manager_code = SM.senior_manager_code 
AND E.manager_code = M.manager_code 
GROUP BY C.company_code, C.founder
ORDER BY C.company_code;
