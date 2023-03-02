USE web;
DROP TABLE sell_bill;

CREATE TABLE sell_bill (
bill_order VARCHAR(50) PRIMARY KEY,
bill_date TIMESTAMP DEFAULT NOW(),
s_progress INT NOT NULL,
s_code VARCHAR(50) NOT NULL,
s_name VARCHAR(50) NOT NULL,
s_cate VARCHAR(50),
s_check INT DEFAULT 0,
s_price INT DEFAULT 0,
sell_id VARCHAR(50) NOT NULL,
sell_name VARCHAR(50) NOT NULL,
sell_tel VARCHAR(50) NOT NULL,
sell_eail VARCHAR(50) NOT NULL,
sell_post VARCHAR(50),
sell_address VARCHAR(100),
bill_deliver INT DEFAULT 0,
bill_total INT DEFAULT 0,
FOREIGN KEY(sell_id) REFERENCES user(user_id),
FOREIGN KEY(s_code) REFERENCES product(product_code)
);

delimiter $$
DROP PROCEDURE if EXISTS loopInsert$$
CREATE PROCEDURE loopInsert()
BEGIN
   DECLARE i INT DEFAULT 1;
   DELETE FROM sell_bill;
   while i<=20 do
      INSERT INTO sell_bill (bill_order,s_code,sell_id,s_name,bill_date, s_price, bill_deliver,bill_total)
      VALUES (i,CONCAT('CZ-5060H',i),'kim','오방향 전기히터','22-12-28', 37900, 5000, 42900);
      SET i = i + 1;
   END while;
END$$
delimiter $$

CALL loopInsert

SELECT * FROM sell_bill;

SELECT COUNT(*) FROM sell_bill;

SELECT * from sell_bill WHERE s_code = 'CZ-5060H10';
