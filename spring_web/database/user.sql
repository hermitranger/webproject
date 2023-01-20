USE web;

DROP TABLE USER;
CREATE TABLE USER(
user_id VARCHAR(50) PRIMARY KEY NOT NULL,
user_passwd VARCHAR(50) NOT NULL,
user_name VARCHAR(50) NOT NULL,
user_birth VARCHAR(50) NOT NULL,
user_gender VARCHAR(50) NOT NULL,
user_email VARCHAR(50) NOT NULL,
user_phone VARCHAR(50) NOT NULL,
user_check INT DEFAULT 0
);


delimiter $$
DROP PROCEDURE if EXISTS loopInsert$$
CREATE PROCEDURE loopInsert()
BEGIN
	DECLARE i INT DEFAULT 1;
	DELETE FROM USER;
	while i<=20 do
		INSERT INTO USER (user_id,user_passwd,user_name,user_birth,user_gender,user_email,user_phone,user_check)
		VALUES (CONCAT('kim',i),CONCAT('1234',i),CONCAT('김갑수',i),CONCAT('09-22',i),'남','0','0','0');
		SET i = i + 1;
	END while;
END$$
delimiter $$

CALL loopInsert

SELECT * FROM USER;
SELECT COUNT(*) from user where user_id = 'park' and user_passwd = '1234';
INSERT INTO user VALUES ('kim','1234','김철수','99-08-29','남','kim@naver.com','010-1234-1234',0); 
INSERT INTO user VALUES ('admin','1234','관리자','00-05-12','남','admin@naver.com','010-1244-1212',1); 
INSERT INTO user VALUES ('park','1234','박이수','96-08-29','남','park@naver.com','010-1237-1235',-1); 


select count(*) from user
		where user_name='김철수' and user_id='kim' and web
		user_email='kim@naver.com'