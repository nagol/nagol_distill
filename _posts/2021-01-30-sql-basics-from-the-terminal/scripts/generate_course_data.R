
# Genernate Grade Data

library(babynames)
library(tidyverse)

# Set simulation parameters ----
set_seed(123)
num_students <- 100
num_assignments <- 20
majors <- c('Statistics and Math', 'Science', 'English', 'Engineering', 'Business', 'Philosophy')
student_levels <- c('Freshmen', 'Sophmore', 'Junior', 'Senior')
names <- babynames::babynames %>%
    filter(year > 1980, prop > 0.01) %>%
    group_by(name) %>%
    summarise(total = sum(n)) %>%
    ungroup() %>%
    arrange(desc(total)) %>%
    select(name) %>%
    pull()


# STUDENTS ----
# + student_id - Integer Primary Key
# + student_name - Text
# + student_level (Freshmen, Sophmore, Junior, Senior) - Text
# + major - Text
# + email - Text
students <- tibble(
    student_id = 1:num_students,
    student_name = sample(names, size = num_students, replace = TRUE),
    student_level = sample(student_levels, size = num_students, replace = TRUE),
    major = sample(majors, size = num_students, replace = TRUE)
    ) %>%
    mutate(email = str_glue("{str_to_lower(student_name)}@university.edu"))

# ASSIGNMENTS ----
# - one row per assignment containing all assignment specific information
# + assignment_id - Integer Primary Key
# + assignment_category - Text
# + assignment_value - Real or Integer
assignments <- tibble(assignment_id = 1:num_assignments) %>%
    mutate(assignment_category = case_when(
        assignment_id %% 10 %in% c(1,2,3,5,6,7,9) ~ 'Homework',
        assignment_id %% 10 %in% c(4, 8) ~ 'Quiz',
        TRUE ~ 'Exam')
        ) %>%
    mutate(assignment_value = case_when(
        assignment_category == 'Homework' ~ 10,
        assignment_category == 'Quiz' ~ 20,
        assignment_category == 'Exam' ~ 100
    ))


# GRADE ----
# - one row per graded assignment per student
# + assignment_id - Integer
# + student_id - Integer
# + numeric_grade - Integer or Real
grades <- expand_grid(
    student_id = students$student_id, 
    assignment_id = assignments$assignment_id) %>%
    mutate(numeric_grade = rnorm(n(), mean = 0.8, sd = 0.15)
    ) %>%
    mutate(numeric_grade = if_else(numeric_grade > 1, 1, round(numeric_grade,3)))


write_csv(students, "./_posts/2021-01-30-sql-basics-from-the-terminal/data/students.csv", col_names = FALSE)
write_csv(assignments, "./_posts/2021-01-30-sql-basics-from-the-terminal/data/assignments.csv", col_names = FALSE)
write_csv(grades, "./_posts/2021-01-30-sql-basics-from-the-terminal/data/grades.csv", col_names = FALSE)
