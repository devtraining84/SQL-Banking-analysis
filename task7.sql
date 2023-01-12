use financial16_25;



DROP TABLE IF EXISTS tmp_analysis;
CREATE TEMPORARY TABLE tmp_analysis AS
SELECT
    c.gender,
    2023 - extract(year from birth_date) as age,

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

select * from tmp_analysis;

SELECT SUM(loans_count) FROM tmp_analysis
;

SELECT
    gender,
    avg(age) as avg_age
FROM tmp_analysis
GROUP BY gender
;

