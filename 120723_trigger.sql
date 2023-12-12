		/*12.07.23*/
/* 복습 포인트 */
-- 제약조건에 이름붙이기
-- stored function문 return, returns
-- stored procedure문 in out (+if else)
-- SELECT INSERT UPDATE DELETE
-- CREATE ALTER DROP TRUNCATE

	/* Trigger */
CREATE TABLE testTbl(
	id INT,
	txt VARCHAR(10)
);

INSERT INTO testTbl VALUES
(1, 'aaaa'),
(2, 'bbbb'),
(3, 'cccc');

SELECT * FROM testtbl;

DELIMITER //
CREATE TRIGGER testTrg
	AFTER DELETE
	ON testTbl
	FOR EACH ROW
BEGIN
	SET @msg = '삭제가 되었어요..';
END //
DELIMITER ;

SET @msg = '';
INSERT INTO testTbl VALUES(4, 'dddd');
SELECT @msg;

UPDATE testtbl SET txt = 'xxxx' WHERE id = 4;
SELECT @msg;

DELETE FROM testtbl WHERE id = 4;
SELECT * FROM testtbl;
SELECT @msg;

DROP TRIGGER testTrg;
DROP TABLE testtbl;

	/* Backup Trigger */
/* 수정/삭제 시도시, 사본을 만들어 저장해주는 트리거 */
CREATE TABLE usertbl(
	userID CHAR(8) PRIMARY KEY,
	uName VARCHAR(10) NOT NULL,
	birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height SMALLINT,
	mDate DATE
);
INSERT INTO userTbl VALUES
('hgd12', '홍길동', 1980, '서울', '010', '11112222', 173, '2023-01-23');
SELECT * FROM usertbl;

CREATE TABLE backupUserTbl(
	userID CHAR(8),
	uName VARCHAR(10) NOT NULL,
	birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height SMALLINT,
	mDate DATE,
	modType CHAR(2), -- 수정인지 삭제인지
	modDate DATE, -- 수정된 날짜
	modUser VARCHAR(256) -- 수정한 유저
);
SELECT * FROM backupUserTbl;

/*1) 수정 트리거*/
DELIMITER //
CREATE TRIGGER backupUserTbl_UpdateTrg
	AFTER UPDATE
	ON userTbl
	FOR EACH ROW
BEGIN
	INSERT INTO backupUserTBL VALUES
	(OLD.userID, OLD.uName, OLD.birthYear, OLD.addr,
	OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, '수정', CURDATE(), CURRENT_USER());
END //
DELIMITER ;
UPDATE userTbl SET height = 198 WHERE userID = 'hgd12';
SELECT * FROM usertbl;
SELECT * FROM backupUserTbl;
UPDATE userTbl SET addr = '부산' WHERE userID = 'hgd12';
SELECT * FROM usertbl;
SELECT * FROM backupUserTbl;


/*2) 삭제 트리거*/
DELIMITER //
CREATE TRIGGER backupUserTbl_DeleteTrg
	AFTER DELETE
	ON userTbl
	FOR EACH ROW
BEGIN
	INSERT INTO backupUserTBL VALUES
	(OLD.userID, OLD.uName, OLD.birthyear, OLD.addr,
	OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, '삭제', CURDATE(), CURRENT_USER());
END //
DELIMITER ;
INSERT INTO usertbl VALUES
('ygj32','임꺽정', 1990, '인천', '010', '33332222', 183, '2023-02-23');
SELECT * FROM usertbl;
DELETE FROM userTbl WHERE userID = 'ygj32';
SELECT * FROM usertbl;
SELECT * FROM backupusertbl;

/*3) before trigger */
/*
데이터가 테이블에 입력될 때 출생년도를 검사해서 데이터에 문제가 있는
값을 변경해서 입력시키는 BEFORE INSERT 트리거 작성.
출생년도는 1900년 이상. 작으면 0으로 설정
출생년도가 현재 년도보다 크면 현재 년도로 변경
*/
DELIMITER $$
CREATE TRIGGER beforeInsertTrg
	BEFORE INSERT
	ON userTbl
	FOR EACH ROW
BEGIN
	IF NEW.birthYear < 1900 THEN
		SET NEW.birthYear = 0;
	ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN
		SET NEW.birthYear = YEAR(CURDATE());
	END IF;
END $$
DELIMITER ;
INSERT INTO userTbl VALUES
('IJM','일지매', 1899, '강원', '010', '33334444', 167, '2022-03-23');
SELECT * FROM usertbl;
INSERT INTO userTbl VALUES
('DL','둘리', 2500, '대구', '010', '33334444', 250, '2022-01-23');
SELECT * FROM usertbl;
UPDATE usertbl SET birthYear = 1997 WHERE userID = 'IJM';
SELECT * FROM usertbl;
SELECT * FROM backupusertbl;

DROP TRIGGER backupUsertbl_UpdateTrg;
DROP TRIGGER backupUsertbl_DeleteTrg;
DROP TRIGGER beforeInsertTrg;
DROP TABLE backupUserTbl;
DROP TABLE usertbl;

	/* TRANSACTION */
/*
transaction, roll back, commit
트랜잭션은 끝가지 가야 한 것으로 간주.
트랜잭션: 논리적인 일의 최소 단위(쪼갤수 있으나 수행된것으로 간주하지 않는다.)
commit: 내가 갱신한 데이터 값을 데이터베이스에 반영하는 것.
	MariaDB는 autocommit기능이 있는데 이 기능을 끌 수 있다.
rollback: 지금까지 한 작업을 취소
*/
START TRANSACTION;
INSERT INTO usertbl VALUES
('xxx','엑스',1998, '경기', '010','66667777', 156, '2022-08-20');
SAVEPOINT a;

INSERT INTO usertbl VALUES
('zzz','제트',1998, '경기', '010','66667777', 156, '2022-08-20');
SAVEPOINT b;

DELETE FROM usertbl WHERE userid = 'DL';
SELECT * FROM usertbl;

ROLLBACK TO a;
SELECT * FROM usertbl;
ROLLBACK;
SELECT * FROM usertbl;

COMMIT;

	/* TRUNCATE */
/*
CRUD와 함께 DBL에 내리는 명령어
table의 구조는 그대로 두지만, 입력된 내용을 모두 지운다.
가인수는 내버려두고, 실인수를 모두 삭제.
*/
TRUNCATE table usertbl;
INSERT INTO usertbl VALUES
('ygj32','임꺽정', 1990, '인천', '010', '33332222', 183, '2023-02-23');
SELECT * FROM usertbl;

/* 중간 점검 */
CREATE TABLE deptTbl(
	deptCode CHAR(2) PRIMARY KEY,
	deptName VARCHAR(10) NOT NULL,
	AREA VARCHAR(10) NOT NULL DEFAULT '부산'
);
CREATE TABLE empTbl(
	eno INT AUTO_INCREMENT PRIMARY KEY,
	ename VARCHAR(20) NOT NULL,
	deptCode CHAR(2) NOT NULL,
	grade CHAR(2) NOT NULL,
	CONSTRAINT ck_grade
	CHECK((grade) IN ('인턴', '사원', '대리', '과장', '부장', '이사', '사장')),
	FOREIGN KEY (deptCode) REFERENCES deptTbl(deptCode)
	ON UPDATE CASCADE
);
INSERT INTO deptTbl
	(deptCode, deptName)
VALUES
	('AA', '인사'),
	('BB', '개발'),
	('CC', '영업');
INSERT INTO empTbl
VALUES
(NULL, '김복길', 'AA', '사원'),
(NULL, '장정수', 'AA', '대리'),
(NULL, '이희정', 'AA', '과장'),
(NULL, '정소희', 'BB', '부장'),
(NULL, '신민아', 'BB', '이사'),
(NULL, '최정후', 'BB', '이사'),
(NULL, '이민아', 'CC', '사장'),
(NULL, '소정민', 'CC', '인턴'),
(NULL, '김성구', 'CC', '사원');

CREATE TABLE backupemployees(
	eno INT AUTO_INCREMENT PRIMARY KEY,
	ename VARCHAR(20) NOT NULL,
	deptCode CHAR(2) NOT NULL UNIQUE,
	grade CHAR(2) NOT NULL,
	modType CHAR(2),
	modUser VARCHAR(256),
	modDate DATE
);
DELMITER //
CREATE TRIGGER onUpdateEmployeesTrg
	AFTER UPDATE
	ON employees
	FOR EACH ROW
BEGIN
	INSERT INTO backupEmployees VALUES
	(OLD.eno, OLD.ename, OLD.deptCode, OLD.grade, '수정', CURRENT_USER(), CURDATE());
END //
DELIMITER ;
DELMITER //
CREATE TRIGGER onDeleteEmployeesTrg
	AFTER DELETE
	ON employees
	FOR EACH ROW
BEGIN
	INSERT INTO backupEmployees VALUES
	(OLD.eno, OLD.ename, OLD.deptCode, OLD.grade, '수정', CURRENT_USER(), CURDATE());
END //
DELIMITER ;
DELMITER //
CREATE TRIGGER autoInputTrg
	BEFORE INSERT
	ON employees
	FOR EACH ROW
BEGIN
	if 
END //
DELIMITER ;

DROP TABLE emptbl;
DROP TABLE deptTbl;

	/* view */
/*
논리적으로 존재하는 가상의 테이블. 물리적으로 존재하진 않는다.
테이블로부터 데이터를 받아와서 테이블'처럼' 운용하는 것.
*/
CREATE VIEW v_usertbl
AS
(SELECT userID, uName, birthYear FROM usertbl);

SELECT * FROM v_usertbl;

	/* 응용 */
-- 1. 직급이 '사원인' 사람의 사번과 이름을 조회하시오
SELECT eno, ename FROM emptbl WHERE grade = '사원';
-- 2. 성이 '김'씨인 직원의 이름, 부서코드를 조회하시오.
SELECT ename, deptCode FROM emptbl WHERE ename LIKE '김%';
-- 3. 부서별 직원 수를 조회하시오.
SELECT deptCode, COUNT(*) FROM emptbl GROUP BY deptCode;
-- 4. 조회결과로 사번, 이름, 부서코드, 부서명이 나오도록 쿼리를 작성하시오.
CREATE VIEW v_emp_dept
AS
(SELECT e.eno, e.ename, d.deptCode, d.deptName
FROM emptbl e, depttbl d
WHERE e.deptCode = d.deptCode);

START TRANSACTION;
-- 5. 사번이 3번인 사원의 직급을 한 단계 승진시키시오.
UPDATE emptbl SET grade = '대리' WHERE grade = '사원';
-- 6. 사번이 5번인 사원을 삭제하시오.
DELETE FROM emptbl WHERE eno = 5;
SELECT * FROM emptbl;
ROLLBACK;