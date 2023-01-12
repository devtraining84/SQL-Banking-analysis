use financial16_25;

SELECT
    c.gender,
    count(l.loan_id) as amount
FROM
        loan as l
    INNER JOIN
        account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
        client as c using (client_id)
WHERE l.status IN ('A', 'C')
GROUP BY c.gender


-- test
DROP TABLE IF EXISTS tmp_results;
CREATE TEMPORARY TABLE tmp_results AS
SELECT
    c.gender,
    sum(l.amount) as amount
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
GROUP BY c.gender;

select * from tmp_results;


WITH cte as (
    SELECT sum(amount) as amount
    FROM loan as l
    WHERE l.status IN ('A', 'C'))



SELECT (SELECT SUM(amount) FROM tmp_results) - (SELECT amount FROM cte)