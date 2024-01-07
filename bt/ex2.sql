drop table if exists professor;
create table professor (
  prof_id int primary key auto_increment,
  prof_lname varchar(50),
  prof_fname varchar(50)
);

drop table if exists student;
create table student (
  stud_id int primary key auto_increment,
  stud_lname varchar(50),
  stud_fname varchar(50),
  stud_street varchar(255),
  stud_city varchar(50),
  stud_zip varchar(10)
);

drop table if exists course;
create table course (
  course_id int primary key auto_increment,
  course_name varchar(255)
);


drop table if exists `class`;
create table `class`(
  class_id int primary key auto_increment
  class_name varchar(255),
  prof_id int,
  course_id int,
  room_id int,
  foreign key(prof_id) references professor(prof_id),
  foreign key(course_id) references course(course_id),
  foreign key(room_id) references room(room_id)
);

drop table if exists enroll;
create table enroll(
  stud_id int,
  class_id int,
  `grade` varchar(3),
  primary key(stud_id, class_id),
  foreign key(stud_id) references student(stud_id),
  foreign key(class_id) references `class`(class_id)
);

drop table if exists room;
create table room (
  room_id int primary key auto_increment,
  room_loc varchar(50),
  room_cap varchar(50),
  class_id int,
  foreign key(class_id) references `class`(class_id)
);

