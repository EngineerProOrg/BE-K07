-- 1. student professor
SELECT s.stud_id, p.prof_id, COUNT(c.class_id) AS number_of_classes
FROM student s
JOIN enroll e ON s.stud_id = e.stud_id
JOIN class c ON e.class_id = c.class_id
JOIN professor p ON c.prof_id = p.prof_id
GROUP BY s.stud_id, p.prof_id
HAVING COUNT(c.class_id) > 0;