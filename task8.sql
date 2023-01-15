
use financial16_25;


SELECT
    count(di.client_id) AS nr_of_customers,
    ac.district_id AS region_id,
    dis.A2 AS region

    FROM disp di
    INNER JOIN account ac ON di.account_id = ac.account_id
    INNER JOIN district dis ON ac.district_id = dis.district_id
    WHERE di.client_id IN (select client_id
from disp
where type = 'OWNER')
GROUP BY 2,3
ORDER BY 1 desc

SELECT
   count(l.account_id) AS number_of_loans,
    ac.district_id as region_id
FROM loan l
INNER JOIN account ac ON l.account_id = ac.account_id
WHERE l.status IN ('A','C') AND ac.account_id IN (select account_id
from disp
where type = 'OWNER')
GROUP BY 2
ORDER BY 1 DESC

-----------------

SELECT
    c.gender,
    2021 - extract(year from birth_date) as age,

    -- agregaty
    sum(l.amount) as loans_amount,
    count(l.amount) as loans_count -- na późniejsze potrzeby
FROM
        loan as l
    INNER JOIN
        account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
        client as c using (client_id)
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
GROUP BY c.gender, 2
;


SELECT
    -- agregaty
    sum(l.amount) as loans_amount,
    count(l.amount) as loans_count -- na późniejsze potrzeby
FROM
        loan as l
    INNER JOIN
       account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
        client as c using (client_id)
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
;


SELECT
    d2.district_id,

    count(distinct c.client_id) as customer_amount,
    sum(l.amount) as loans_given_amount,
    count(l.amount) as loans_given_count
FROM
        loan as l
    INNER JOIN
        account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
        client as c using (client_id)
    INNER JOIN
        district as d2 on
            c.district_id = d2.district_id
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
GROUP BY d2.district_id
;



DROP TABLE IF EXISTS tmp_district_analytics;
CREATE TEMPORARY TABLE tmp_district_analytics AS
SELECT
    d2.district_id,

    count(distinct c.client_id) as customer_amount,
    sum(l.amount) as loans_given_amount,
    count(l.amount) as loans_given_count
FROM
        loan as l
    INNER JOIN
        account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
       client as c using (client_id)
    INNER JOIN
        district as d2 on
            c.district_id = d2.district_id
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
GROUP BY d2.district_id
;


SELECT *
FROM tmp_district_analytics
ORDER BY customer_amount DESC
LIMIT 1



SELECT *
FROM tmp_district_analytics
ORDER BY loans_given_amount DESC
LIMIT 1



SELECT *
FROM tmp_district_analytics
ORDER BY loans_given_count DESC
LIMIT 1