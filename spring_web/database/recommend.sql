DROP TABLE recommend;
CREATE TABLE recommend(
r_idx INT, 
m_id VARCHAR(50),
p_code VARCHAR(50),
FOREIGN KEY (m_id) REFERENCES user (user_id),
FOREIGN KEY (p_code) REFERENCES product(product_code)
);
# r_idx 좋아요 여부 m_id user_id p_code 상품 일련번호 
SELECT * FROM recommend WHERE r_idx=1
