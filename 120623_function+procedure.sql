		/*12.06.23*/
/* 복습 포인트 */
-- prepared statement
-- limit
-- 제어흐름함수(각 함수에서 인수의 의미)
-- concat, concat_ws
-- select elt, field, find_in_set, locate, instr, format

	/* CONSTRAINT 별도 생성 */
/*
특정 제약조건을 생성하는데, 그 제약조건의 이름을 설정하는 것.
다시말하면 네임 택을 붙이는 것.
나중에 수정할 때 이름표를 보고 삭제하고 더할수 있도록.
*/
CREATE TABLE userTBL(
	userID CHAR(8) NOT NULL,
	userPW VARCHAR(20) NOT NULL,
	userName CHAR(8) NOT NULL,
	userGen CHAR(1) CHECK(userGen IN ('M', 'F')),
	birthYear INT CHECK(birthYear BETWEEN 1900 AND 2023),
	email VARCHAR(50) UNIQUE,
	addr CHAR(2) NOT NULL DEFAULT '서울',
	CONSTRAINT ck_uName CHECK(userName IS NOT NULL)
);
ALTER TABLE userTBL
DROP CONSTRAINT ck_uName;

CREATE TABLE buyTBL(
	num INT AUTO_INCREMENT PRIMARY KEY,
	userID CHAR(8) NOT NULL,
	prodName CHAR(6) NOT NULL
);
ALTER TABLE buyTBL
ADD
CONSTRAINT FK_userTBL_buyTBL
FOREIGN KEY (userID) REFERENCES userTBL(userID)
ON DELETE SET NULL;
DROP TABLE buytbl;
DROP TABLE usertbl;

	/* Stored function */
/*
	1. Stored function의 parameter는 모두 입력parameter로 사용한다.
		*parameter = 매개변수
	2. returns문으로 반환할 값의 자료형을 지정.
	3. return문은 하나의 값을 반환해야 한다.
	4. Stored function을 호출할 때는 select문을 사용한다.
*/

DELIMITER
$$
CREATE FUNCTION userFunc(VALUE1 INT, VALUE2 INT)
	RETURNS INT
BEGIN
	RETURN VALUE1 + VALUE2;
END $$
DELIMITER;
-- 함수의 시작과 끝은 '$$'
SELECT userFunc(10, 20) AS 합계;
DROP FUNCTION userFunc;

DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
	RETURNS INT
BEGIN
	DECLARE age INT;
	RETURN YEAR(CURDATE()) - bYear;
	RETURN age;
END $$test00
DELIMITER ;
DROP FUNCTION getAgeFunc;

	/* Stored Procedure */
DELIMITER $$
CREATE PROCEDURE userProc()
BEGIN
	SELECT * FROM student;
END $$
DELIMITER ;
CALL userProc();
-- procedure의 호출은 call을 사용.
DROP PROCEDURE userProc;

DELIMITER $$
CREATE PROCEDURE stuProc1(IN stuName VARCHAR(20))
BEGIN
	SELECT * FROM student WHERE stu_Name = stuName;
END $$
DELIMITER ;
CALL stuProc1('유가인')
DROP PROCEDURE stuProc1;

CREATE PROCEDURE userProc2(
	IN height INT,
	IN weight INT
)
BEGIN
	SELECT * FROM student
	WHERE stu_height > height
	AND stu_weight < weight
END $$
DELIMITER ;
CALL userProc2(170, 100);
DROP procedure userProc2;

DELIMITER $$
CREATE PROCEDURE userProc3(
	IN txtValue CHAR(10),
	OUT outvalue INT
)
BEGIN
	INSERT INTO testTBL VALUES(NULL, txtValue);
	SELECT MAX(userID) INTO outvalue FROM testTBL;
END $$
DELIMITER ;
-- txtValue에 입력(IN) 받아서, outValue로 출력(OUT) 하겠다.
CALL userProc3('test value', @myValue);
-- 따라서 @myValue가 가지는 값은 outValue가 된다.
SELECT CONCAT('현재 입력된 id값 ==>', @myValue);
DROP PROCEDURE userProc3;

/*
	함수: 기본적으로 정의된 기본함수 외에, 특정기능을 수행하는 함수가 필요하다.
		그럴때 사용자가 임의로 함수를 선언할 수 있도록 마련해 둔 것.
	procedure: 이런 것들을 묶어서 일괄적으로 처리할 수 있도록 마련된 것.
		주로 쿼리 작업을 자동화 해야할 때 쓰인다.
		IN 입력매개변수, OUT 출력매개변수
*/

	/* if ~ else */
DELIMITER $$
CREATE PROCEDURE ifelseProc(
	IN userName VARCHAR(20)
)
BEGIN
	DECLARE height INT;
	SELECT stu_height INTO height FROM student
	WHERE stu_name = userName;
	
	if(height >= 170) then
		SELECT '키가 크쿤요..';
	ELSE
		SELECT '키가 크진 않군요..';
	END if;
END $$
DELIMITER ;C
CALL ifelseProc('옥성우');
DROP PROCEDURE ifelseProc;