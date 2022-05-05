
/* STUDENTS */
INSERT INTO students (student_id, name, student_level, major, email)
  VALUES (1, 'Student 1', 'Freshman', 'CS', 'student1@uni.edu');

INSERT INTO students
  VALUES (2, 'Student 2', 'Freshman', 'CS', 'student2@uni.edu');
  
INSERT INTO students 
  VALUES (3, 'Student 3', 'Freshman', 'MATH', 'student3@uni.edu');
  
INSERT INTO students
  VALUES (4, 'Student 4', 'Freshman', 'MATH', 'student4@uni.edu');
  
/* ASSIGNMENTS */
    
INSERT INTO assignments (assignment_id, assignment_category, assignment_value)
  VALUES (1, 'quiz', 10);
  
INSERT INTO assignments 
  VALUES (2, 'quiz', 10);
  
INSERT INTO assignments
  VALUES (3, 'exam', 100);
  
/* GRADES */
    
INSERT INTO grades (assignment_id, student_id, numeric_grade)
  VALUES (1, 1, 0.85);
  
INSERT INTO grades
  VALUES (2, 1, 0.75);
  
INSERT INTO grades
  VALUES (3, 1, 0.9);
  
INSERT INTO grades 
  VALUES (1, 2, 0.7);
  
INSERT INTO grades
  VALUES (2, 2, 0.6);
  
INSERT INTO grades
  VALUES (3, 2, 0.65);
  
INSERT INTO grades 
  VALUES (1, 3, 0.99);
  
INSERT INTO grades
  VALUES (2, 3, 1);
  
INSERT INTO grades
  VALUES (3, 3, .92);



