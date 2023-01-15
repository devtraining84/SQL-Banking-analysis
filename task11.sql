USE financial16_25;

DELIMITER $$
DROP PROCEDURE IF EXISTS generate_cards_at_expiration_report;
CREATE PROCEDURE generate_cards_at_expiration_report(p_date DATE)
BEGIN
    TRUNCATE TABLE cards_at_expiration;
    INSERT INTO cards_at_expiration
    WITH cte AS (
        SELECT c2.client_id,
               c.card_id,
               date_add(c.issued, interval 3 year) as expiration_date,
               d2.A3
        FROM
            card as c
                 INNER JOIN
             disp as d using (disp_id)
                 INNER JOIN
             client as c2 using (client_id)
                 INNER JOIN
             district as d2 using (district_id)
    )
    SELECT
           *,
           p_date
    FROM cte
    WHERE p_date BETWEEN DATE_ADD(expiration_date, INTERVAL -7 DAY) AND expiration_date
    ;
END;
DELIMITER ;

CALL generate_cards_at_expiration_report('2001-01-01');
SELECT * FROM cards_at_expiration;