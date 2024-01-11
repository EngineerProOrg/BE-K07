CREATE TABLE IF NOT EXISTS professor (
    prof_id INTEGER PRIMARY KEY,
    prof_lname VARCHAR(50),
    prof_fname VARCHAR(50)
);

create table IF NOT EXISTS student (
	stud_id integer primary key,
	stub_fname varchar(50),
	stub_lname varchar(50),
	stub_street varchar(255),
	stub_city varchar(50),
	stub_zip varchar(10)

);

create table IF NOT EXISTS course (
	course_id INTEGER  PRIMARY KEY,
	course_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS class (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(255),
    prof_id INTEGER,
	course_id INTEGER,
	room_id INTEGER,
    FOREIGN KEY (prof_id) REFERENCES professor (prof_id),
	FOREIGN KEY (course_id) references course (course_id)
);

CREATE TABLE enroll (
    stud_id INT,
    class_id INT,
	grade varchar(3),
	PRIMARY KEY (stud_id, class_id),
    FOREIGN KEY (stud_id) REFERENCES student (stud_id),
    FOREIGN KEY (class_id) REFERENCES class (class_id)
);

create table if not exists room (
	room_id integer primary key,
	room_loc integer,
	room_cap integer,
	class_id integer UNIQUE,
	foreign key (class_id) references class (class_id)
);

