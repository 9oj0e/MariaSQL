		/*11.29.23*/
/* 복습 포인트 */
-- ??
CREATE TABLE tbl_students(
	sno INT PRIMARY KEY AUTO_INCREMENT,
	sname VARCHAR(20),
	grade CHAR(1),
	class CHAR(1),
	kor_score INT,
	eng_score INT,
	sql_score INT
);
INSERT INTO tbl_students
	(sname, grade, class, kor_score, eng_score, sql_score)
VALUES
	('John', '1', '1', 70, 80, 90),
	('Ann', '1', '1', 80, 80, 90),
	('Kane', '2', '1', 20, 80, 90),
	('Hong', '2', '1', 30, 70, 90),
	('Kang', '2', '2', 40, 60, 90),
	('Choi', '2', '2', 50, 80, 90),
	('Jeong', '1', '2', 60, 80, 90),
	('Oh', '1', '1', 70, 90, 90),
	('Park', '1', '2', 80, 90, 90),
	('Lee', '3', '1', 90, 60, 90),
	('Seo', '3', '1', 100, 80, 90)
;
INSERT INTO tbl_students
	(sname, grade, class, kor_score, eng_score, sql_score)
VALUES
	('김철수', '3', '2', 65, 75, 80),
	('김동수', '3', '1', 65, 65, 70),
	('김희선', '3', '2', 65, 85, 60),
	('나동수', '3', '1', 65, 95, 50),
	('한철수', '3', '2', 65, 35, 40),
	('마동석', '3', '1', 65, 55, 80)
;
INSERT INTO tbl_students
	(sname, grade, class, kor_score, eng_score, sql_score)
VALUES
	(NULL, '4', '1', 70, 80, 90);
-- 전체 column수는 늘었지만, null값 항목은 count되지않는다.

SELECT COUNT(sname)
FROM tbl_students; -- result: 10
DELETE FROM tbl_students WHERE sname IS NULL;
-- 이름 값이 NULL인 모든 학생의 모든 데이터 삭제

	/* 조건부 조회 */
SELECT COUNT(*) FROM tbl_students;
SELECT COUNT(sno) AS 학생수 FROM tbl_students;
-- select한 결과를 '학생수'라는 항목으로 조회하겠다.

SELECT sname, grade, class FROM tbl_students WHERE grade = '1';
-- 1학년인 학생 조회

SELECT sname, grade FROM tbl_students WHERE kor_score > 70;
-- 국어점수가 70점을 초과한 학생 조회

SELECT COUNT(sname) FROM tbl_students WHERE eng_score BETWEEN 75 AND 85;
SELECT sname FROM tbl_students WHERE eng_score >= 65 AND eng_score <= 75;
-- 65이상 75이하

SELECT COUNT(sname) FROM tbl_students WHERE eng_score > 75 AND eng_score < 85;
-- a초과 b미만

SELECT * FROM tbl_students WHERE sname LIKE '김%';
-- '김'으로 시작하는 모든 사람

SELECT * FROM tbl_students WHERE sname LIKE '%동%';
-- 이름 사이에 '동'이 포함된 모든 사람

SELECT * FROM tbl_students WHERE sname IS NULL;
-- 'WHERE sname = NULL'는 잘못된 구문

SELECT * FROM tbl_students WHERE sname LIKE '_동%';
-- 두 번째 글자가 '동'인 모든 학생 조회
-- underbar '_'는 글자 하나를 의미.
-- percent '%'는 윈도우 탐색기에서 '*'의 의미.
SELECT * FROM tbl_students WHERE sname LIKE '%o%';
-- 글자에 'o'를 포함하는 모든 학생
SELECT * FROM tbl_students WHERE sname LIKE '__o%';
-- 세 번째 글자가 'o'인 모든 학생
SELECT * FROM tbl_students WHERE sname LIKE '__o';
-- 이름이 세글자이고, 마지막 글자가 o로 끝나는 모든 학생

	/* 조건부 조회: 정렬 */
SELECT *, kor_score+eng_score+sql_score AS 총점 FROM tbl_students
ORDER BY 총점 DESC;
-- 학생들의 국어, 영어, SQL총점을 구해서 총점이 높은 학생순으로 정렬
SELECT sname, kor_score FROM tbl_students
ORDER BY kor_score DESC;
-- DESCending order 내림차순
SELECT sname, kor_score FROM tbl_students
ORDER BY kor_score ASC;
-- ASCending order 오름차순

	/* 데이터 수정: 조건부 */
UPDATE tbl_students SET sname = '마석동' WHERE sname = '마동석';
SELECT * FROM tbl_students WHERE kor_score = 65;
UPDATE tbl_students SET kor_score = kor_score + 5 WHERE kor_score = 65;
-- 국어점수가 65점인 학생들에게 5점을 가산.

SELECT sname FROM tbl_students
WHERE kor_score = (SELECT MAX(kor_score) FROM tbl_students);
-- QUERY문이 또하나의 QUERY문을 가질 때. 내포문을 SUB QUERY문이라고 한다.
/*
SELECT sname FROM tbl_students
WHERE kor_score = MAX(kor_score)
-- ERROR: 테이블 명 누락 'FROM TABLE'.
-- MAX(), MIN()함수는 어디에서 참고할 것인지. 범위'FROM'를 지정해주어야한다.
-- "어느 TABLE(?)의 어느 항목(kor_score)의 MAX값/MIN값을 구할 것인가.
*/

SELECT MIN(kor_score) AS '최저점' FROM tbl_students;


SELECT * FROM tbl_students;
DROP TABLE tbl_students;
DROP DATABASE test00;