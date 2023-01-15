use financial16_25;

SELECT
    c.client_id,

    sum(amount - payments) as client_balance,
    count(loan_id) as loans_amount
FROM loan as l
         INNER JOIN
     account a using (account_id)
         INNER JOIN
     disp as d using (account_id)
         INNER JOIN
     client as c using (client_id)
WHERE True
  AND l.status IN ('A', 'C')
  AND d.type = 'OWNER'
GROUP BY c.client_id
HAVING
    SUM(amount - payments) > 1000
    AND COUNT(loan_id) > 5


SELECT
    c.client_id,

    sum(amount - payments) as client_balance,
    count(loan_id) as loans_amount
FROM loan as l
         INNER JOIN
     account a using (account_id)
         INNER JOIN
     disp as d using (account_id)
         INNER JOIN
     client as c using (client_id)
WHERE True
  AND l.status IN ('A', 'C')
  AND d.type = 'OWNER'
--  AND EXTRACT(YEAR FROM c.birth_date) > 1990
GROUP BY c.client_id
HAVING
    sum(amount - payments) > 1000
--    and count(loan_id) > 5
ORDER BY loans_amount DESC -- tutaj dodajemy sortowanie malejące po liczbie kredytów