
/*
SELECT s.student_id, 
       s.name, 
       s.student_level, 
       s.major,
       a.assignment_id,
       a.assignment_category,
       a.assignment_value,
       g.numeric_grade
FROM students s, grades g, assignments a
    ON s.student_id = g.student_id
        AND a.assignment_id = g.assignment_id
ORDER BY s.student_id
LIMIT 5
;
*/


CREATE TEMPORARY TABLE student_avg_by_category as
SELECT student_id, 
       assignment_category,
       avg(numeric_grade) as avg_category
FROM
    (SELECT s.student_id, 
           a.assignment_id,
           a.assignment_category,
           a.assignment_value,
           g.numeric_grade
    FROM students s, grades g, assignments a
        ON s.student_id = g.student_id
            AND a.assignment_id = g.assignment_id
    ORDER BY s.student_id)
GROUP BY student_id, assignment_category
;

CREATE TEMPORARY TABLE student_course_grades as
SELECT student_id,
       course_grade_numeric,
       case
           when course_grade_numeric >= 0.9 then 'A'
           when course_grade_numeric >= 0.8 and course_grade_numeric < 0.9 then 'B'
           when course_grade_numeric >= 0.7 and course_grade_numeric < 0.8 then 'C'
           when course_grade_numeric >= 0.6 and course_grade_numeric < 0.7 then 'D'
           else 'F'
       end course_grade
FROM
    (SELECT student_id, 
           sum(grade_contribution_category) as course_grade_numeric
    FROM
        (SELECT student_id,
               case assignment_category
                    when 'Quiz' then 0.15 * avg_category
                    when 'Homework' then 0.25 * avg_category
                    when 'Exam' then 0.6 * avg_category
               end grade_contribution_category
        FROM student_avg_by_category)
    GROUP BY student_id
    ORDER BY sum(grade_contribution_category) DESC
    ) 
;

/* Grade Roster for Upload */
DROP TABLE final_grades;
CREATE TABLE final_grades as
SELECT s.student_id, 
       s.name, 
       round(g.course_grade_numeric,2) as course_grade_numeric,
       g.course_grade
FROM students s
INNER JOIN student_course_grades g
    ON s.student_id = g.student_id;
 

/* Grade Breakdown by Student Level
SELECT s.student_id, 
       s.student_level,
       g.course_grade,
       count(*) as count
FROM students s
INNER JOIN student_course_grades g
    ON s.student_id = g.student_id
GROUP BY s.student_level, g.course_grade
ORDER BY s.student_level, g.course_grade
;
*/

SELECT * FROM final_grades;