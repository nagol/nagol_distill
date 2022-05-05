DROP TABLE students;
DROP TABLE assignments;
DROP TABLE grades;

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    student_level TEXT,
    major TEXT,
    email TEXT
);

CREATE TABLE assignments (
  assignment_id INTEGER PRIMARY KEY,
  assignment_category TEXT,
  assignment_value INTEGER
);

CREATE TABLE grades (
  assignment_id INTEGER,
  student_id INTEGER,
  numeric_grade REAL
  
);