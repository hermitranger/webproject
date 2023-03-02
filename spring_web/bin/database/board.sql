create TABLE board (
idx int NOT NULL PRIMARY KEY auto_increment,                        
title varchar(200) not null,      
contents VARCHAR(4000),                
writer varchar(50) not null,      
regdate datetime default CURRENT_TIMESTAMP,
hit int default  0            
);

create  table  reply  (
idx  int  not  null  primary  KEY auto_increment,
board_idx  int  default  0  references  board(idx),
reply_text  varchar(1000)  not  null,
replyer  varchar(50)  not  NULL REFERENCES user(user_id),
regdate  datetime  default  current_timestamp
);

create  table  attach  (
    file_name  varchar(150)  primary  key,       
    board_idx  int  not  null  references  board(idx),
    regdate  datetime  default  current_timestamp         
);