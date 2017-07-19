#CREATE USER 'piapp'@'%' IDENTIFIED BY '1q2w3e4r';
GRANT ALL PRIVILEGES ON * . * TO 'piapp'@'%';
CREATE DATABASE piapp;
use piapp;
CREATE TABLE IF NOT EXISTS pi_list (
  id INT(11) NOT NULL AUTO_INCREMENT,
  value VARCHAR(10000) DEFAULT NULL,
  created TIMESTAMP,  
  PRIMARY KEY (id)
) ENGINE=InnoDB;
