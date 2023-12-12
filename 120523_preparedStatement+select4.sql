		/*12.05.23*/
/* 복습 포인트 */
-- ON UPDATE CASCADE, ON DELETE SET NULL
-- 조회시 TABLE.COLUMN
-- ALTER 구문(ADD, MODIFY, CHANGE, DROP, RENAME) (AFTER)
-- PRIMARY KEY 복합 부여

	/* prepared statement */
/*
잘 쓰지 않음. but 자바와 SQL연동할 때,
즉, DBNS에 접속할 때 prepared statement가 자주 사용됨.
*/
PREPARE myQuery
	FROM 'SELECT * FROM student WHERE stu_height BETWEEN ? AND ?';
-- 미완성된 변수 부분은 '?'로해서 query문을 미리 입력.
SET @myval1 = 160;
SET @myval2 = 170;
-- 두개의 변수를 설정하고,
EXECUTE myQuery USING @myVal1, @myVal2;
-- myQuery에 사전에 입력된 query문을 execute

	/* limit */
SELECT * FROM student ORDER BY stu_height DESC LIMIT 3;
-- LIMIT START, END 행의 시작부분과 마지막 부분.
-- 인수 하나만 입력하면, 시작부분은 자동으로 0설정.
	/* 제어 흐름 함수 */
/*
인수? 함수에서 괄호 사이에 들어가는 것들.
매개변수, 외계세계와 내계세계를 연결하는 변수.
실인수: 실제값을 가지는 인수.
가인수: 입력받기 전까지 가상의 값을 가지는 인수.
*/
SELECT if(100 > 200, 'True', 'False') AS TF;
SELECT IFNULL(NULL, 'no input');
SELECT IFNULL((SELECT stu_height FROM student WHERE stu_no =13), 'no input');
-- IF((1) == NULL) 두번째 인수, else 첫번째 인수.
SELECT NULLIF(100, 300);
-- IF((1) == (2)) NULL, else 첫번째 인수 출력
SELECT case 10
		 when 1 then '일'
		 when 5 then '오'
		 when 10 then '십'
		 ELSE '모름'
END;
-- switch문.

	/* 문자열 */
SELECT
CONCAT('abc', '가', 'def', '나', 1),
CONCAT('이것이', SPACE(5), 'MariaDB다'),
CONCAT_WS('-', '010', '1111', '2222') ,
CONCAT_WS('/', '2013', '12', '05');
-- CONCAT = 각 문자열을 이어붙여서 출력
-- CONCAT_WS 인자(2번째~마지막) 사이에 첫번째 인자를 삽입해서 출력.
SELECT
REPLACE('이것이 MariaDB', '이것이', 'This is');

SELECT
ELT(3, 'a', 'b', 'c'),
FIELD ('b', 'a', 'b','c'),
FIND_IN_SET ('a', 'a, b, c'),
LOCATE ('나', '하나둘셋'),
INSTR ('하나둘셋', '넷'),
FORMAT (123456.123456, 2);
/*
elt n번째 인자 출력
field 특정문자가 있는 행을 숫자로 출력.
find_in_set 문자열에서 첫번째 인자의 위치
locate 두번째 인자 내에서 첫번째 인자의 위치
instr 첫번째 인자 내에서 두번째 인자의 위치
format 소수점 자리를 지정하고 이하의 값은 반올림.
*/

SELECT
LEFT('abcdefg', 3),
RIGHT('abcdefg', 2),
MID('abcdefg', 4, 2),
SUBSTRING('abcdefg', 4, 2),
SUBSTRING('abcdefg' FROM 4 FOR 2),
REVERSE('abcdefg'),
LTRIM('		abc'),
RTRIM('abc		'),
TRIM('	abc	');
/*
left 첫번째 인자를 왼쪽에서부터 두번째 인자만큼 출력
right 첫번째 인자를 오른쪽에서부터 두번째 인자만큼 출력
mid 첫번째 인자에서 두번째 인자부터 세번째 인자만큼 출력
substring mid와 같은 함수.
trim 문자열내에 공백 제거(left: 왼쪽, right: 오른쪽).
*/

SELECT
repeat('abc', 3);
-- repeat 첫번째 인자를 두번째 인자만큼 출력
SELECT RIGHT(LEFT('abcdefg', 5), 2);
-- mid나 substring을쓰지 않고 mid결과값 출력.
SELECT INSERT('abcdefghi', 2, 8, '@@@@');
-- 2번째부터 8개의 글자를 삭제하고 4번째 인자를 삽입

	/* 진수 */
/*
과거 컴퓨터 메모리 양이 작을 때,
개발자들은 메모리양에 제한이 있었다.
사용할 수 있는 메모리에 제한이 있을 때엔,
내가 작성하는 코드가 사용할 메모리,
작성하는 코드의 메모리가 차지할 공간에 대해 민감할 수 밖에 없었고,
진수표현
*/
SELECT
ASCII('A'),
CHAR(65);
-- 아스키코드상 A 는 65.
SELECT
BIT_LENGTH('abc') AS '할당된 bit 수',
CHAR_LENGTH('abc') AS '글자 수',
LENGTH('abc') AS '할당된 byte 수';
-- 1글자가 1byte인것을 추론할 수 있다.
SELECT
BIT_LENGTH('가') AS '할당된 bit 수',
CHAR_LENGTH('가') AS '글자 수',
LENGTH('가') AS '할당된 byte 수';
-- 한글은 한글자당 3byte.

SELECT BIN(9), BIN(5), BIN(2);
-- binary: 인자값을 2진수로 변환.
SELECT OCT(17), OCT(8), OCT(3);
-- octal: 인자값을 8진수로 변환.
SELECT HEX(9), HEX(10), HEX(11), HEX(12), HEX(13), HEX(14), HEX(15), HEX(16), HEX(17),
HEX(63), HEX(1205234);
-- hexadecimal: 인자값을 16진수로 변환.
