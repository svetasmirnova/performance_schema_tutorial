drop database if exists test;
create database test;
use test;

CREATE TABLE `a` (
  `i` int(11) NOT NULL AUTO_INCREMENT,
  `c` char(255) DEFAULT NULL,
  PRIMARY KEY (`i`)
) ENGINE=InnoDB;


-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "The replication is broken on the Slave1. Your task it to find what is the error and fix the replication. Show slave status does not show the error, so you will need to use PS" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "select * from performance_schema.replication_applier_status_by_worker will show the error. Copy the table from master and restart slave " AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
 END//

delimiter ;

