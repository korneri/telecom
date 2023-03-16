DROP DATABASE IF EXISTS telecom; 

CREATE DATABASE telecom; 

USE telecom; 

CREATE TABLE city
  ( 
     id      CHAR(40) NOT NULL, 
     city_name    VARCHAR(40) NOT NULL , 
     population DECIMAL(10, 2) NOT NULL, 
     mean_income DECIMAL(10, 2) NOT NULL, 
     PRIMARY KEY (id)
  );  
  INSERT INTO city (id,city_name,population,mean_income) VALUES
  ('1','Athens','27000','9010'),
  ('2','Τhessaloniki','22000','8500'),
  ('3','Patra','19000','8300');
CREATE TABLE customer 
  ( 
     id      CHAR(40) NOT NULL, 
     first_name    VARCHAR(40) NOT NULL , 
     last_name VARCHAR(40) NOT NULL, 
     birth_date DATE NOT NULL, 
     gender CHAR(1) NOT NULL,
	city_id CHAR(40) NOT NULL,
     PRIMARY KEY (id),
     FOREIGN KEY (city_id) REFERENCES city(id) 
  ); 
  INSERT INTO customer (id,first_name,last_name,birth_date,gender,city_id) VALUES
  ('1','Rita','Sakellariou','1964-03-07','f','1'),
  ('2','Manthos','Foustanos','1992-01-01','m','2'),
  ('3','Maria','Antouaneta','1932-03-02','f','3'),
  ('4','Sakis','Rouvas','1975-01-07','m','1'),
  ('5','Freddy','Mercury','1958-09-06','m','1'),
  ('6','Pamela','Anderson','1968-02-01','f','2'),
  ('7','Anna','Frank','1932-02-09','f','2'),
  ('8','Zoi','Konstantopoulou','1970-08-06','f','3'),
  ('9','Miriam','Αndrikopoulou','1965-05-05','f','3'),
  ('10','Josoua','Αndrikopoulos','1963-05-04','m','3'),
  ('11','Oliver','Twist','1935-09-01','m','3');
  
  CREATE TABLE plan
  ( 
     id      CHAR(40) NOT NULL, 
     plan_name    VARCHAR(40) NOT NULL  , 
     minutes INT,
     sms INT,
     mbs INT,
     PRIMARY KEY (id)
  );
  INSERT INTO plan (id,plan_name,minutes,sms,mbs) VALUES
  ('1','student_mobile','1200','1200','1200'),
  ('2','combo_mobile','600','600','600'),
  ('3','Freedom','600','0','0');
  
  CREATE TABLE contract
  ( 
     id      CHAR(40) NOT NULL, 
     phone_number    VARCHAR(15) NOT NULL  , 
     starting_date DATE NOT NULL,
     ending_date DATE NOT NULL,
     descr VARCHAR(240) NOT NULL,
     customer_id CHAR(40) NOT NULL,
     plan_id      CHAR(40) NOT NULL,
     PRIMARY KEY (id),
     FOREIGN KEY (customer_id) REFERENCES customer(id),
	 FOREIGN KEY (plan_id) REFERENCES plan(id)
  );
  
  INSERT INTO contract (id,phone_number,starting_date,ending_date,descr,customer_id,plan_id) VALUES
  ('1','6912345187','2016-01-01','2020-01-01','4 years','1','1'),
  ('2','6956192310','2016-01-09','2019-01-09','3 year','1','3'),
  ('3','2104449104','2016-01-10','2019-01-10','1 year','3','3'),
  ('4','2151237890','2016-01-10','2020-01-10','4 year','3','2'),
  ('5','6912039182','2016-02-13','2020-02-13','4 year','1','3'),
  ('6','6933501958','2016-02-13','2020-02-13','4 year','4','3'),
  ('7','6933991958','2016-02-13','2020-02-13','4 year','2','3'),
  ('8','6933501954','2016-02-14','2020-02-14','4 year','5','1'),
  ('9','6933881954','2016-02-14','2020-02-14','4 year','6','1'),
  ('10','6933881780','2016-03-14','2020-03-14','4 year','7','2'),
  ('11','6933881430','2016-03-14','2020-03-14','4 year','8','2'),
  ('12','6932681430','2016-03-14','2020-03-14','4 year','9','1'),
  ('13','6932680980','2016-03-15','2020-03-15','4 year','10','1'),
  ('14','6932681180','2016-03-15','2020-03-15','4 year','11','2');
  
  
  CREATE TABLE callT
  ( 
     id      CHAR(40) NOT NULL, 
     date_call DATE NOT NULL,
     hour_call TIME(0) NOT NULL,
     duration  DECIMAL(10, 2) NOT NULL,
     contract_id      CHAR(40) NOT NULL, 
     phone_number    VARCHAR(15) NOT NULL  , 
     PRIMARY KEY (id),
	FOREIGN KEY (contract_id) REFERENCES contract(id)
  );
  
  INSERT INTO callT (id,date_call,hour_call,duration,contract_id,phone_number) VALUES
  ('1','2017-06-30','09:00:00','20','1','6956192310'),
  ('2','2017-07-23','10:00:00','29','1','6912959310'),
  ('3','2018-06-25','09:30:00','31','1','6956192310'),
  ('4','2018-06-27','09:35:00','22','1','6976123465'),
  ('5','2018-06-30','09:40:00','25','2','6976123465'),
  ('6','2018-07-28','09:34:00','28','3','6976123465'),
  ('7','2018-07-28','22:00:00','35','1','6912530129'),
  ('8','2018-07-28','22:01:00','150','8','6912530129'),
  ('9','2018-07-28','22:02:00','33','9','6912530779'),
  ('10','2018-07-28','22:03:00','100','7','6912530779'),
  ('11','2018-07-28','22:04:00','110','12','6912530779'),
  ('12','2018-07-28','22:04:00','10','13','6912530779'),
  ('13','2018-07-28','22:03:00','120','10','6920530779'), 
  ('14','2018-07-29','22:01:00','121','11','6920530779'),
  ('15','2018-07-28','23:00:00','120','1','6912530129'),
  ('16','2018-07-29','23:00:00','23','2','6976123465'),
  ('17','2018-07-29','23:25:00','29','1','6956192310'),
  ('18','2018-07-30','23:29:00','99','8','6957869869'),
  ('19','2018-07-30','23:27:00','23','6','6912345187'),
  ('20','2018-07-30','23:27:00','200','7','6912345187'),
  ('21','2018-07-30','23:25:00','23','2','6912345187'),
  ('22','2019-10-25','12:00:00','22','7','6976123465'),
  ('23','2019-10-25','13:00:00','300','7','6976014594'),
  ('24','2019-10-26','13:00:00','300','7','6976014594'),
  ('25','2019-10-27','13:25:00','350','8','6976395106'),
  ('26','2019-10-27','13:35:00','340','8','6976395106');  
  
  