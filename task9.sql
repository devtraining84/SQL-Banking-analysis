use financial16_25;

WITH cte AS (
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
)
SELECT *
FROM cte


WITH cte AS (
    SELECT d2.district_id,

           count(distinct c.client_id) as customer_amount,
           sum(l.amount)               as loans_given_amount,
           count(l.amount)             as loans_given_count
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
)
SELECT
    *,
    loans_given_amount / SUM(loans_given_amount) OVER () AS share
FROM cte
ORDER BY share DESC