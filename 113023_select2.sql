		/*11.30.23*/
/* 복습 포인트 */
-- 조건부 조회(최대/최소값, 정렬(오름차순/내림차순), 글자 포함)
-- 서브쿼리
-- 값 갱신 (null값 삭제, 가산/감산)
/* 오답 찾아보기
UPDATE kor_score
FROM tbl_students
kor_score = kor_score + 5
WHERE kor_score = 65;
*/
-- 기본기 (마인드셋, 코드 가독성)


SELECT grade, SUM(kor_score)
FROM tbl_students
WHERE grade = 3
GROUP BY grade
-- SYNTAX :: WHERE절은 FROM뒤에서만 쓰일 수 있다.
-- 3학년 학생들의 국어점수 총점을 조회
;
SELECT gender AS '성별', COUNT(gender) AS '수'
FROM employees
GROUP BY gender
HAVING COUNT(gender) > 130000
;
-- SYNTAX :: HAVING은 위치가 상관없다....

CREATE TABLE student(
	stu_no CHAR(9) PRIMARY KEY,
	stu_name VARCHAR(20) NOT NULL,
	stu_dept VARCHAR(20) NOT NULL,
	stu_grade CHAR(1) NOT NULL CHECK ((stu_grade) IN ('1', '2', '3')),
	stu_class CHAR(1) NOT NULL,
	stu_gender CHAR(1) NOT NULL CHECK ((stu_gender) IN ('M', 'F')),
	stu_height INT DEFAULT 0 CHECK(stu_height < 200),
	stu_weight INT	DEFAULT 0
);
DESC student;

INSERT INTO student
VALUES
	('20153075', '옥한빛', '기계', '1', 'C', 'M', 177, 80),
	('20153088', '이태연', '기계', '1', 'C', 'F', 162, 50),
	('20143054', '유가인', '기계', '2', 'C', 'F', 154, 47),
	('20152088', '조민우', '전기전자', '1', 'C', 'M', 188, 90),
	('20142021', '심수정', '전기전자', '2', 'A', 'F', 168, 45),
	('20132003', '박희철', '전기전자', '3', 'B', 'M', NULL, 63),
	('20151062', '김인중', '컴퓨터정보', '1', 'B', 'M', 166, 67),
	('20141007', '진현무', '컴퓨터정보', '2', 'A', 'M', 174, 64),
	('20131001', '김종헌', '컴퓨터정보', '3', 'C', 'M', NULL, 72),
	('20131025', '옥성우', '컴퓨터정보', '3', 'A', 'F', 172, 63)
;

SELECT DISTINCT stu_dept FROM student;
-- 중복된 행을 제외하고 조회
SELECT stu_dept FROM student GROUP BY stu_dept;
-- ??

SELECT stu_name, stu_dept, stu_grade, stu_class FROM student
WHERE stu_grade = '2' AND stu_dept = '컴퓨터정보'
;
-- 컴퓨터정보학과 2학년 학생의 이름, 학과, 학년, 반 조회

SELECT * FROM student
WHERE stu_weight BETWEEN 60 AND 70
;
-- 몸무게가 60kg 이상 70kg이하인 학생 조회

SELECT stu_no AS 'ID', stu_name AS 'NAME' FROM student;
-- 학생 테이블에서 학번, 이름을 조회, 조회 결과 열의 제목을 ID, NAME으로 표시

SELECT * FROM student
WHERE stu_no LIKE '2014%'
;
-- 2014 학번 학생 조회

SELECT * FROM student
WHERE stu_name LIKE '김__'
;
-- 성이 김씨인 학생들의 정보를 조회

SELECT stu_name AS '이름에 수가 포함된 학생'  FROM student
WHERE stu_name LIKE '_수_'
;
-- 학생 중 이름의 두번째 문자가 '수'인 학생의 이름을 조회

SELECT stu_no, stu_name FROM student
WHERE stu_dept IN ('컴퓨터정보', '기계')
;
-- 학과가 '컴퓨터정보'이거나 '기계'인 학생의 학번과 이름 조회

SELECT stu_no, stu_name FROM student
WHERE stu_height IS NULL
;
-- 학생의 키 정보가 NULL인 학생의 학번, 이름, 키를 조회

SELECT stu_dept, AVG(stu_weight)
AS '몸무게 평균'
FROM student
GROUP BY stu_dept
;
-- 학과별 몸무게 평균을 조회

SELECT
AVG(stu_height)
-- SUM(stu_height) / (SELECT COUNT(stu_no) FROM student EXCLUDE WHERE stu_height IS NULL)
AS '키 평균'
FROM student
GROUP BY stu_dept
;


DROP TABLE student;

