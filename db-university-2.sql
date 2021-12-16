EX - Query con JOIN;

1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`degree_id`AS`id-corso`,
        `students`.`id`AS`id-studente`,
        `degrees`.`name`AS`Corso`
FROM `students` 
INNER JOIN `degrees`
ON `students`.`degree_id`=`degrees`.`id`
WHERE `degrees`.`name`LIKE"%laurea in economia%"



2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `degrees`.`department_id`AS`id-dipartimento-del-corso`,
        `degrees`.`id`, `degrees`.`name`AS`nome-del-corso`,
        `departments`.`name`AS`Dipartimento`
FROM `degrees`
INNER JOIN `departments`
ON `degrees`.`department_id`= `departments`.`id`
WHERE `departments`.`name`LIKE"%di neuroscienze%"



3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT  `courses`.`id`AS `id-corso`,
        `courses`.`name` AS`nome-corso`,
        `teachers`.`id`AS `id-insegnante`,
        `teachers`.`name`,
        `teachers`.`surname`
FROM `courses`
INNER JOIN `course_teacher` ON `courses`.`id`= `course_teacher`.`course_id`
INNER JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`name`= "fulvio" AND `teachers`.`surname`= "amato"



4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`surname` AS `Cognome Studente`, 
       `students`.`name` AS `Nome Studente`,
       `departments`.`name` AS `Dipartimento`, 
       `degrees`.`name` AS `Corso di Laurea`
FROM `students` 
LEFT JOIN `degrees`ON `students`.`degree_id`=`degrees`.`id`
LEFT JOIN `departments` ON `degrees`.`department_id`=`departments`.`id`  
ORDER BY `students`.`name` ASC, `students`.`surname` ASC



5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS `Corso di Laurea`, 
       `courses`.`name` AS `Corso`, 
       `teachers`.`name` AS `Nome Docente`, 
       `teachers`.`surname` AS `Cognome Docente`
FROM `courses`
LEFT JOIN `degrees` ON `courses`.`degree_id`=`degrees`.`id`
LEFT JOIN `course_teacher` on `course_teacher`.`teacher_id`=`courses`.`id`
LEFT JOIN `teachers` ON `teachers`.`id`= `course_teacher`.`teacher_id`



6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT `departments`.`name`,
        `course_teacher`.`teacher_id`,
        `teachers`.`name`,
        `teachers`.`surname`
FROM `courses`
LEFT JOIN `degrees` ON `courses`.`degree_id`=`degrees`.`id`
LEFT JOIN `departments` ON `degrees`.`department_id`=`departments`.`id`
LEFT JOIN `course_teacher`ON `courses`.`id`=`course_teacher`.`course_id`
LEFT JOIN `teachers` ON `teachers`.`id`=`course_teacher`.`teacher_id`
WHERE `departments`.`name` LIKE "%di matematica"



7. BONUS: Selezionare per ogni studente quanti tentativi d esame a sostenuto per superare ciascuno dei suoi esami
SELECT `students`.`name` AS `Nome Studente`,
       `students`.`surname` AS `Cognome Studente`,
       `courses`.`name` AS `Corso`,
        COUNT(`exams`.`id`) AS `Teantativi`
FROM `courses`
INNER JOIN `exams` ON `exams`.`course_id` = `courses`.`id`
INNER JOIN `exam_student` ON `exam_student`.`exam_id` = `exams`.`id`
INNER JOIN `students` ON `students`.`id` = `exam_student`.`exam_id`
GROUP BY `courses`.`id`, `students`.`id`;



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EX - Query con GROUP BY;
1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`id`),
       YEAR(`enrolment_date`) as `Anno`
FROM `students`  
GROUP BY YEAR(`enrolment_date`)



2. Contare gli insegnati che hanno l ufficio nello stesso edificio
SELECT COUNT(`id`) AS `Numero Insegnati`,
       `office_address` AS `Indirizzo ufficio`
FROM `teachers`
GROUP BY `office_address`;



3. Calcolare la media dei voti di ogni appello d esame
SELECT `exam_id` AS `id-appello`,
        AVG(`vote`) AS `media-voti`
FROM `exam_student`
GROUP BY `exam_id`



4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id`,
        COUNT(`name`) AS `Corsi`
FROM `degrees`
GROUP BY `department_id`