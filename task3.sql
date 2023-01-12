use financial16_25;
SELECT

    extract(YEAR FROM date) as loan_year,
    extract(QUARTER FROM date) as loan_quarter,
    extract(MONTH FROM date) as loan_month,


    sum(payments) as loans_total,
    avg(payments) as loans_avg,
    count(payments) as loans_count
FROM loan
GROUP BY 1, 2, 3 WITH ROLLUP
ORDER BY 1, 2, 3

