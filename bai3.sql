use ep_week1;

-- những cặp student-professor có dạy học nhau và số lớp mà họ có liên quan
SELECT Student.stud_fname"Studen_Name", Professor.prof_fname as "Professor_Name", Class.class_id as "Class"
FROM Student 
INNER JOIN Enroll ON Student.stud_id = Enroll.stud_id
INNER JOIN Class ON Class.class_id = Enroll.class_id
INNER JOIN Professor ON Professor.prof_id = Class.prof_id;

-- những course (distinct) mà 1 professor cụ thể đang dạy

SELECT DISTINCT CONCAT(Professor.prof_lname, Professor.prof_fname),Course.course_name
From Course
INNER JOIN Class ON Course.course_id = Class.course_id
INNER JOIN Professor ON Class.prof_id = Professor.prof_id;

-- những course (distinct) mà 1 student cụ thể đang học
select distinct concat(Student.stud_fname, " ", Student.stud_lname), Course.course_name
from Student
inner join Enroll on Enroll.stud_id = Student.stud_id
inner join Class on Enroll.class_id = Class.class_id
inner join Course on Course.course_id = Class.course_id;

-- điểm số là A, B, C, D, E, F tương đương với 10, 8, 6, 4, 2, 0
select * from Enroll;
create view Student_Grade as
select Enroll.stud_id, Enroll.class_id,
case Enroll.grade 
	when "A" then 10
    when "B" then 8
    when "C" then 6
    when "D" then 4
    when "E" then 2
    when "F" then 0
end as "gpa"
from Enroll;

 select * from Student_Grade;

 -- điểm số trung bình của 1 học sinh cụ thể (quy ra lại theo chữ cái, và xếp loại học lực (weak nếu avg < 5, average nếu >=5 < 8, good nếu >=8 )
 select Student.stud_id, 
		Student.stud_fname,
		AVG(Student_Grade.gpa) as 'average_score',
case 
	when AVG(Student_Grade.gpa) < 5 then 'week'
    when AVG(Student_Grade.gpa) >= 8 then 'good'
    else 'average'
end as "assess"
 from Student
 inner join Student_Grade on Student_Grade.stud_id = Student.stud_id
 group by Student.stud_id;
 
 -- điểm số trung bình của các class (quy ra lại theo chữ cái)
 select Class.class_id, Class.class_name, AVG(Student_Grade.gpa) as 'average_score',
 case
	when AVG(Student_Grade.gpa) < 5 then 'week'
    when AVG(Student_Grade.gpa) >= 8 then 'good'
    else 'average'
 end as 'assess'
 from Class
 inner join Student_Grade on Student_Grade.class_id = Class.class_id
 group by Class.class_id;
 
 -- điểm số trung bình của các course (quy ra lại theo chữ cái)
 select Course.course_id, Course.course_name, AVG(Student_Grade.gpa) as 'average_score',
  case
	when AVG(Student_Grade.gpa) < 5 then 'week'
    when AVG(Student_Grade.gpa) >= 8 then 'good'
    else 'average'
 end as 'assess'
 from Course 
 inner join Class on Class.course_id = Course.course_id
 inner join Student_Grade on Student_Grade.class_id = Class.class_id
 group by Course.course_id
