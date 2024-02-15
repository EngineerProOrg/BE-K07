INSERT INTO
  PROF (PROF_LNAME, PROF_FNAME)
VALUES
  ("Macey", "Bradshaw"),
  ("Clio", "Ford"),
  ("Naomi", "Snow"),
  ("Mariko", "Maldonado");

INSERT INTO
  STUDENT (
    STUD_LNAME,
    STUD_FNAME,
    STUD_STREET,
    STUD_CITY,
    STUD_ZIP
  )
VALUES
  (
    "Daniel",
    "Mccray",
    "Ap #400-9038 In Road",
    "Lloydminster",
    "621959"
  ),
  (
    "Yeo",
    "Stevenson",
    "Ap #337-6877 Risus Street",
    "Ashburton",
    "738508"
  ),
  (
    "Dale",
    "Ortiz",
    "P.O. Box 926, 571 Feugiat. Street",
    "Gravilias",
    "92-644"
  ),
  (
    "Louis",
    "Graham",
    "361-9858 Luctus, Av.",
    "Caxias do Sul",
    "624673"
  );

INSERT INTO
  COURSE (COURSE_NAME)
VALUES
  ("Programming"),
  ("Cybersecurity"),
  ("Data Analytics"),
  ("Machine Learning"),
  ("Software Engineering"),
  ("Cloud Computing"),
  ("Mobile App Development"),
  ("Internet of Things"),
  ("Computer Science");

INSERT INTO
  ROOM (ROOM_LOC, ROOM_CAP, CLASS_ID)
VALUES
  ("La Libertad", "Peru", NULL),
  ("Styria", "Poland", NULL),
  ("Hải Phòng", "Norway", NULL),
  ("Saskatchewan", "Belgium", NULL),
  ("Connacht", "Sweden", NULL),
  ("Chocó", "South Korea", NULL),
  ("Aceh", "Colombia", NULL),
  ("Jammu and Kashmir", "Ukraine", NULL),
  ("Denbighshire", "Pakistan", NULL);

INSERT INTO
  CLASS (CLASS_NAME, PROF_ID, COURSE_ID, ROOM_ID)
VALUES
  ("ligula.", 2, 5, 3),
  ("eu", 2, 4, 2),
  ("magna.", 1, 2, 1),
  ("risus.", 2, 2, 2),
  ("nec", 2, 7, 8),
  ("facilisis", 1, 7, 3),
  ("Quisque", 2, 7, 1),
  ("rutrum,", 3, 2, 4),
  ("libero.", 1, 8, 3),
  ("vulputate", 3, 4, 4);

INSERT INTO
  CLASS (CLASS_NAME, PROF_ID, COURSE_ID, ROOM_ID)
VALUES
  ("Ut", 3, 3, 4),
  ("Curabitur", 2, 4, 5),
  ("urna", 2, 8, 3),
  ("commodo", 4, 1, 8),
  ("vehicula", 2, 7, 1),
  ("bibendum", 3, 5, 7),
  ("diam", 4, 7, 6),
  ("neque", 1, 7, 1),
  ("leo.", 3, 5, 3),
  ("Curae", 2, 3, 2);

INSERT INTO
  ENROLL (STUD_ID, CLASS_ID, GRADE)
VALUES
  (3, 7, "A"),
  (1, 1, "B"),
  (1, 10, "C"),
  (1, 4, "B"),
  (2, 10, "A"),
  (3, 6, "E"),
  (4, 5, "C"),
  (2, 3, "D"),
  (4, 1, "A"),
  (2, 2, "B");

INSERT INTO
  ENROLL (STUD_ID, CLASS_ID, GRADE)
VALUES
  (3, 10, "D"),
  (2, 1, "C"),
  (4, 7, "A"),
  (1, 6, "F"),
  (4, 10, "B"),
  (3, 1, "A"),
  (2, 5, "C"),
  (4, 9, "F"),
  (3, 2, "E"),
  (1, 9, "D");