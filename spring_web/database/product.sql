DROP TABLE product;
CREATE TABLE product (
product_code VARCHAR(50) PRIMARY KEY,  
filename VARCHAR(500),
product_name VARCHAR(100) NOT NULL, 
product_cate VARCHAR(50) NOT NULL,       
product_brand VARCHAR(100) NOT NULL, 
product_price INT DEFAULT 0,
product_amount INT NOT NULL, 
product_date TIMESTAMP DEFAULT NOW(),
product_detail VARCHAR(4000), product
product_check INT,
product_saleprice INT DEFAULT 0,
recommend INT DEFAULT 0
);

INSERT INTO product (product_code,filename,product_name, product_cate, product_brand, 
product_price, product_amount, product_detail, product_check) VALUE 
('CZ-5060H','electric_heater', '오방향 전기히터', '난방기구', '모닝컴', 
37900, 10, 'http://item.gmarket.co.kr/Item?goodscode=2626161048', 2);

SELECT * FROM product;

delimiter $$
DROP PROCEDURE if EXISTS loopInsert$$
CREATE PROCEDURE loopInsert()
BEGIN
	DECLARE i INT DEFAULT 1;
	DELETE FROM product;
	while i<=20 do
		INSERT INTO product (product_code,filename,product_name,product_cate,product_brand,product_price,product_amount,product_date, product_detail, product_check, product_saleprice, recommend)
		VALUES (CONCAT('CZ-5060H',i),CONCAT('abc1234',i),CONCAT('오방향 전기히',i),'난방기구','모닝컴', 37900, 10, CONCAT('22-09-22'), CONCAT(i), 1, 37900, 0);
		SET i = i + 1;
	END while;
END$$
delimiter $$

CALL loopInsert