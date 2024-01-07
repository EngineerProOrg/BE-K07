-- những cặp student-professor có dạy học nhau và số lớp mà họ có liên quan

select p.prof_id, s.stud_id, count(c.class_id)
from professer as p
inner join `class` as c on p.prof_id = c.prof_id
inner join enroll as e on e.class_id = c.class_id
inner join student as s on s.stud_id = e.stud_id
group by p.prof_id, s.stud_id;


-- những course (distinct) mà 1 professor cụ thể đang dạy
select p.prof_id, c.course_id
from professer as p 
inner join `class` as cl on cl.prof_id = p.prof_id
inner join course as c on c.course_id = cl.course_id
group by p.prof_id, c.course_id;

-- những course (distinct) mà 1 student cụ thể đang học
select s.stud_id, c.course_id
from student as s 
inner join enroll as e on e.stud_id = s.stud_id
inner join `class` as cl on cl.class_id = e.class_id
inner join course as c on c.course_id = cl.course_id
group by s.stud_id, c.course_id;

-- điểm số là A, B, C, D, E, F tương đương với 10, 8, 6, 4, 2, 0
alter table enroll add column `gpa` varchar(1) generated always as (
  case 
    when grade + 0 >= 10 then 'A',
    When grade + 0 >=8 then 'B',
    When grade + 0 >=6 then 'C',
    When grade + 0 >=4 then 'D',
    When grade + 0 >=2 then 'E',
    When grade + 0 >=0 then 'F',
    else ''
  end
) stored;

-- điểm số trung bình của 1 học sinh cụ thể (quy ra lại theo chữ cái, và xếp loại học lực (weak nếu avg < 5, average nếu >=5 < 8, good nếu >=8 )
select s.stud_id, sum(e.grade+0)/count(e.grade) as average_score, 
  (
    case 
      when average_score >= 8 then 'good',
      when (average_score >= 5 and average_score<8) then 'average',
      else 'weak'
    end
  ) as average_grad
from student as s 
inner join enroll as e on e.stud_id = s.stud_id
group by s.stud_id;


-- điểm số trung bình của các class (quy ra lại theo chữ cái)
select cl.class_id, sum(e.grade+0)/count(e.grade) as average_score, 
  (
    case 
      when average_score >= 8 then 'good',
      when (average_score >= 5 and average_score<8) then 'average',
      else 'weak'
    end
  ) as average_grad
from `class` as cl
inner join enroll as e on e.class_id = cl.class_id
group by cl.class_id;

-- điểm số trung bình của các course (quy ra lại theo chữ cái)
select e.course_id, sum(e.grade+0)/count(e.grade) as average_score, 
  (
    case 
      when average_score >= 8 then 'good',
      when (average_score >= 5 and average_score<8) then 'average',
      else 'weak'
    end
  ) as average_grad
from course as c 
inner join `class` as cl on cl.class_id = c.class_id
inner join enroll as e on e.class_id = cl.class_id
group by e.course_id;
