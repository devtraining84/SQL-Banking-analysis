use financial16_25;

SELECT
    status,
    count(status) AS count_status
FROM loan
GROUP BY 1
ORDER BY 1