/* Analiza kont
Napisz kwerendę, która uszereguje konta według następujących kryteriów:

liczba udzielonych pożyczek (malejąco),
kwota udzielonych pożyczek (malejąco),
średnia kwota pożyczki.
Pod uwagę bierzemy tylko spłacone pożyczki */

use financial16_25;

SELECT
    account_id,
    count(loan_id) AS nb_of_loan,
    sum(amount) AS sum_amount,
    ROUND(avg(amount),2) AS avg_amount
FROM loan
WHERE status in ('A','C')
GROUP BY account_id
ORDER BY 1 ASC , 2 DESC , 3 DESC;

SELECT * FROM loan
WHERE account_id = 2

SELECT
    account_id,
    sum(amount)   as loans_amount,
    count(amount) as loans_count,
    avg(amount)   as loans_avg
FROM loan
WHERE status IN ('A', 'C')  -- tylko udzielone pożyczki
GROUP BY account_id
ORDER BY 1

WITH cte as (
    SELECT
        account_id,
        sum(amount)   as loans_amount,
        count(amount) as loans_count,
        avg(amount)   as loans_avg
    FROM loan
    WHERE status IN ('A', 'C')  -- tylko udzielone pożyczki
    GROUP BY account_id
)
SELECT *
FROM cte