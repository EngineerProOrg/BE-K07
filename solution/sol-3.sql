-- những cặp student-professor có dạy học nhau và số lớp mà họ có liên quan
SELECT
  P.PROF_ID,
  E.STUD_ID,
  COUNT(*) AS 'COMMON_CLASSES'
FROM
  PROF AS P
  JOIN CLASS AS C ON P.PROF_ID = C.PROF_ID
  JOIN ENROLL AS E ON C.CLASS_ID = E.CLASS_ID
GROUP BY
  P.PROF_ID,
  E.STUD_ID;

-- những course (distinct) mà 1 professor cụ thể đang dạy
SELECT DISTINCT
  C.COURSE_ID
FROM
  CLASS AS C
  JOIN PROF AS P ON C.PROF_ID = P.PROF_ID
WHERE
  P.PROF_ID = 1;

-- những course (distinct) mà 1 student cụ thể đang học
SELECT DISTINCT
  C.COURSE_ID
FROM
  CLASS AS C
  JOIN ENROLL AS E ON C.CLASS_ID = E.CLASS_ID
  JOIN STUDENT AS S ON E.STUD_ID = S.STUD_ID
WHERE
  S.STUD_ID = 1;

-- điểm số là A, B, C, D, E, F tương đương với 10, 8, 6, 4, 2, 0
CREATE TABLE
  IF NOT EXISTS EXCHANGE_GRADE (
    GRADE VARCHAR(3) PRIMARY KEY,
    NUM_GRADE INT NOT NULL
  );

INSERT INTO
  EXCHANGE_GRADE (GRADE, NUM_GRADE)
VALUES
  ("A", 10),
  ("B", 8),
  ("C", 6),
  ("D", 4),
  ("E", 2),
  ("F", 0);

-- điểm số trung bình của 1 học sinh cụ thể (quy ra lại theo chữ cái, và xếp loại học lực (weak nếu avg < 5, average nếu >=5 < 8, good nếu >=8 )
SELECT
  STUD_ID,
  AVG_SCORE,
  (
    CASE
      WHEN AVG_SCORE < 5 THEN 'weak'
      WHEN AVG_SCORE >= 8 THEN 'good'
      ELSE 'average'
    END
  ) AS RANKING
FROM
  (
    SELECT
      STUD_ID,
      AVG(NUM_GRADE) AS AVG_SCORE
    FROM
      ENROLL
      JOIN EXCHANGE_GRADE ON ENROLL.GRADE = EXCHANGE_GRADE.GRADE
    WHERE
      STUD_ID = 2
    GROUP BY
      STUD_ID
  ) AS S;

-- điểm số trung bình của các class (quy ra lại theo chữ cái)
SELECT
  C.CLASS_ID,
  AVG(EG.NUM_GRADE) AS AVG_SCORE
FROM
  CLASS AS C
  JOIN ENROLL AS E ON C.CLASS_ID = E.CLASS_ID
  JOIN EXCHANGE_GRADE AS EG ON E.GRADE = EG.GRADE
GROUP BY
  C.CLASS_ID;

-- điểm số trung bình của các course (quy ra lại theo chữ cái)
SELECT
  CS.COURSE_ID,
  AVG(EG.NUM_GRADE) AS AVG_SCORE
FROM
  COURSE AS CS
  JOIN CLASS AS C ON CS.COURSE_ID = C.COURSE_ID
  JOIN ENROLL AS E ON C.CLASS_ID = E.CLASS_ID
  JOIN EXCHANGE_GRADE AS EG ON E.GRADE = EG.GRADE
GROUP BY
  CS.COURSE_ID;