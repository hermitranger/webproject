USE web;
DROP TABLE buy_bill;

CREATE TABLE buy_bill (
bill_order VARCHAR(50) PRIMARY KEY,
bill_date TIMESTAMP DEFAULT NOW(),
b_progress INT NOT NULL,
b_code VARCHAR(50) NOT NULL,
b_name VARCHAR(50) NOT NULL,
b_cate VARCHAR(50),
b_check INT DEFAULT 0,
b_price INT DEFAULT 0,
buy_id VARCHAR(50) NOT NULL,
buy_name VARCHAR(50) NOT NULL,
buy_post VARCHAR(50),
buy_address VARCHAR(100),
bill_deliver INT DEFAULT 0,

FOREIGN KEY(buy_id) REFERENCES user(user_id),
FOREIGN KEY(b_code) REFERENCES product(product_code)
);
delimiter $$
DROP PROCEDURE if EXISTS loopInsert$$
CREATE PROCEDURE loopInsert()
BEGIN
   DECLARE i INT DEFAULT 1;
   DELETE FROM buy_bill;
   while i<=20 do
      INSERT INTO buy_bill (bill_order,b_code,buy_id,b_name,bill_date,b_price,bill_deliver,bill_total)
      VALUES (i,CONCAT('CZ-5060H',i),'kim','오방향 전기히터','22-12-28',37900, 5000, 42900);
      SET i = i + 1;
   END while;
END$$
delimiter $$

CALL loopInsert

SELECT * FROM buy_bill;

SELECT * FROM buy_bill;