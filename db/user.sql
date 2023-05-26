CREATE DATABASE usersdemo;
use usersdemo;

CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(250) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

insert  into `users`(`user_id`,`user_name`,`user_email`,`user_password`) values
(1,'Soumitra Roy','sroy@gmail.com','Ibr@20222'),
(2,'Rahul Kumar','rahul@gmail.com','Ibr@20223');