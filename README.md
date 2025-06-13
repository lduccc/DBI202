# SQL Query Problems for EducateDB (Set 9.2)

## User 1 Test

**Problem 1.1:**
List all `course_id`s, `description`s, and `tuition_fee`s for courses whose `description` includes 'Tiếng Anh' or the `tuition_fee` is above 5,000,000. Order by `tuition_fee` descending.

**Problem 1.2:**
Display the `first_name`, `last_name`, `email`, and the calculated age (current year - year of `date_birth`) for all `Teacher`s older than 40.

**Problem 1.3:**
For every `Class`, show its `id` (as `ClassID`), its `schedule_info`, the `description` of the `Course` it belongs to, and the `tuition_fee` of that course.

**Problem 1.4:**
List all `Student`s (`id`, `FullName` as 'LastName FirstName'). For each student, show the `id` and `amount` of their most recent 'Success' `Payment` made in the current year. If no successful payments, details should be NULL.

**Problem 1.5:**
For each `Course`, calculate the average number of days between the course `last_modified` date and the `date_add` of its materials. Display `course_id`, `description`, and `AvgMaterialLagDays`.

**Problem 1.6:**
List the `student_id`, student `FullName`, the `description` of the `Exam`, and the `value` of the `Grade` for grades where the `Exam.exam_type` is 'Final' and the `Grade.date` was after '2023-11-01'.

**Problem 1.7:**
For each `Course`, display its `id` and `description`, and the number of distinct `Teacher`s who teach at least one `Class` for that course. Only include courses taught by 2 or more distinct teachers.

**Problem 1.8:**
Find the `FullName` of `Student`s who are enrolled in classes that are part of courses having a `tuition_fee` equal to the maximum `tuition_fee` found across all courses.

**Problem 1.9:**
List `Teacher`s (`id`, `FullName`) who are not currently assigned to teach any `Class` that starts in the year 2024.

**Problem 1.10:**
For each `Course` that 'David Smith' teaches at least one class for, list the `course_id`, `description`, and the average `balance` of all unique `Student`s enrolled in any class of that specific course.

---

## User 2 Test

**Problem 2.1:**
List all `student_id`s, `first_name`s, `last_name`s, and `created_date`. Add a column `MembershipDuration` showing the number of months since the student's `created_date`. Order by `MembershipDuration` descending.

**Problem 2.2:**
Display the `id`, `material_type`, `description`, and `course_id` for all `Course_Material` where the `material_url` is provided and the `date_add` was between '2023-01-01' and '2023-03-31'.

**Problem 2.3:**
Show the `payment_id`, `amount`, payment `status`, the `FullName` (LastName FirstName) of the `Student`, and the `email` of that student for each `Payment`.

**Problem 2.4:**
List all `Course`s (`id` and `description`). For each course, show the `id` and `schedule_info` of any `Class`es offered for it *only if* the class `room_number` starts with 'P2'. If no such classes, details should be NULL for the class information.

**Problem 2.5:**
For each `exam_type`, count the total number of exams and the number of exams with `duration_minutes` less than 90. Display `exam_type`, `TotalExams`, `ShortExamsCount`.

**Problem 2.6:**
List `class_id`, `Teacher` `FullName`, `Course` `description`, and the number of days the `Class` runs (difference between `end_date` and `start_date`).

**Problem 2.7:**
For each `Student`, find the `course_id` for which they made their payment with the largest `amount` (successful payments only). Display student `FullName`, `course_id`, and that `MaxPaymentAmount`.

**Problem 2.8:**
Find `Course`s (`id`, `description`) that have at least one `Course_Material` of type 'Sách giáo trình' but do NOT have any material of type 'Tệp âm thanh'.

**Problem 2.9:**
List `Student`s (`FullName`) and their `Grade` `value` for `Exam` 'EX003', but only if their grade is equal to or greater than the average grade for that specific exam 'EX003'.

**Problem 2.10:**
For each `Teacher`, list their `FullName`, the number of distinct `Student`s they teach, and the average `tuition_fee` of the distinct `Course`s associated with the classes they teach.

---

## User 3 Test

**Problem 3.1:**
List all `exam_id`s, `description`s, `date`s, and `class_id`s for exams where the `exam_type` is 'Midterm' OR the `duration_minutes` is greater than or equal to 180.

**Problem 3.2:**
Display the `id`, `first_name`, `last_name`, and `user_name` of all `Student`s whose `city` is NOT 'Hà Nội' and whose `email` does not end with '@educenter.vn'.

**Problem 3.3:**
For every `Grade`, show the `grade_id`, `value`, the `FullName` of the `Student` who received it, and the `schedule_info` of the `Class` where the `Exam` took place.

**Problem 3.4:**
List all `Exam`s (`id` and `description`). For each exam, show the `value` of any `Grade`s associated with it. If an exam has no grades, the `value` should be NULL.

**Problem 3.5:**
For each `city` `Teacher`s reside in, count the number of teachers and calculate the average length of their `description` (if not NULL).

**Problem 3.6:**
List the `course_id` and `description` of `Course`s for which `Student` 'ST002' is enrolled in at least one `Class` AND that `Class` has `room_number` 'P101'.

**Problem 3.7:**
For each `Teacher`, display their `FullName` (LastName FirstName) and the number of `Class_Student` enrollment records for classes that are part of 'IELTS' courses (course_id contains 'IELTS').

**Problem 3.8:**
List `Student`s (`id`, `FullName`) who are enrolled in classes for at least 2 different `Course` IDs.

**Problem 3.9:**
Find `Class`es (`id`, `schedule_info`) that have no `Exam`s of type 'Final' or 'Mock Test' scheduled.

**Problem 3.10:**
For each `Student` enrolled in `Course` 'IELTS_70', list their `FullName`, their highest `Grade` `value` in 'IELTS_70' exams, and the average `Grade` `value` for 'IELTS_70' exams across all students who took them.

---

## User 4 Test

**Problem 4.1:**
List all `class_id`s, `start_date`s, `end_date`s, and the `teacher_id` for `Class`es. Add a calculated column `MonthOfStart` (e.g., 'September'). Order by `MonthOfStart` then `start_date`.

**Problem 4.2:**
Display the `course_id` and `description` for `Course`s. Add a column `HasVideoMaterial` which is 'Yes' if the course has at least one `Course_Material` of type 'Video Links' or 'Tệp âm thanh' with a non-NULL `material_url`, and 'No' otherwise.

**Problem 4.3:**
Show `class_id` from `Class_Student`, and the `user_name` of the `Student`, and the `teacher_id` of the `Class` they are enrolled in.

**Problem 4.4:**
Create a combined contact list of all `Student`s and `Teacher`s. The list should have three columns: `FullName` (LastName FirstName), `Role` ('Student' or 'Teacher'), and `Email`. Order the list by `Role` then by `FullName`.

**Problem 4.5:**
For each `student_id` in the `Payment` table, find their total `amount` paid per `payment_method`. Display `student_id`, `payment_method`, `TotalAmountByMethod`.

**Problem 4.6:**
List `Exam`s (`id` and `description`) that belong to `Class`es for `course_id` 'GE_B1' AND were taught by a `Teacher` whose `first_name` is 'David'.

**Problem 4.7:**
For each `Course`, display its `id`, the number of `Class`es scheduled in 'P101', the number of `Class`es in 'P201', and the number of `Class`es in other rooms.

**Problem 4.8:**
Identify `Course`s (`id`, `description`) where all its offered `Class`es are taught by the *same* `Teacher`.

**Problem 4.9:**
Find `Teacher`s (`FullName`) who teach `Course`s for which the average `tuition_fee` of those specific courses is greater than the overall average `tuition_fee` of all courses in the center.

**Problem 4.10:**
List `Student`s (`FullName`) who are enrolled in at least one `Class` but have NO successful `Payment` record for *any* `Course` they are enrolled in via those classes.

---

## User 5 Test

**Problem 5.1:**
List all `grade_id`s, `value`s, `student_id`s, and `exam_id`s. Add a column `GradeCategory` ('High' if value >= 8.0, 'Medium' if value >= 6.0 and < 8.0, 'Low' if value < 6.0).

**Problem 5.2:**
Display `payment_id`, `payment_date`, `amount`, `status`, `student_id` for `Payment`s where the `notes` field is NOT NULL AND the `payment_method` is different from the `payment_method` of the payment with the highest `amount`.

**Problem 5.3:**
Show the `course_id`, course `description`, the `id` of its `Course_Material`, material `description`, and the `FullName` of any `Teacher` who teaches a class for that course.

**Problem 5.4:**
List all `Student`s (`id` and `FullName`). For each student, show the `exam_id` if they have a `Grade` for an `Exam` of type 'Final' AND that `Grade.value` is greater than the student's own average grade across all their exams. If no such specific grade, exam details should be NULL.

**Problem 5.5:**
For `Course`s that have both 'Sách giáo trình' and 'Tệp âm thanh' as `material_type`s, calculate the number of `Class`es offered. Display `course_id`, `description`, `ClassCount`.

**Problem 5.6:**
Identify the `Student` (`FullName`) who has the largest difference between their highest grade `value` and lowest grade `value` across all exams taken.

**Problem 5.7:**
For each `Course`, find the `Teacher` (`FullName`) who has taught the most number of `Class`es for that specific course. Display `course_id`, course `description`, `TeacherFullName`, and `NumberOfClassesTaughtForCourse`.

**Problem 5.8:**
Find pairs of `Class`es (`class_id1`, `class_id2`) that share at least one common `Student` enrollment AND belong to different `Course`s.

**Problem 5.9:**
List `Student`s (`FullName`) who are enrolled in *every* `Course` that `Teacher` 'TE001' teaches at least one `Class` for.

**Problem 5.10:**
For each `Course`, determine the "payment completion rate" based on `tuition_fee`. This is (Total successful payment amount for this course) / (Number of unique student enrollments for this course * `tuition_fee` of this course). Display `course_id`, `description`, and `PaymentCompletionRate`.
