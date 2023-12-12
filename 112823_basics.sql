		/*11.28.23*/
	/* DATABASE 생성 */
CREATE DATABASE test00;
USE test00; --데이터베이스 'test00'에 커서

	/* TABLE 생성 */
CREATE TABLE tfriends(
num INT,
fname VARCHAR(20),
phone VARCHAR(13) 
);
--통상적인 언어 문법과 다르게, 변수 선언시: 이름 저장형식(길이)

	/* 데이터 추가문 */
INSERT INTO tfriends VALUES
(1, '홍길동', '010-0000-0000'),
(2, '김철수', '010-0001-0001');
INSERT INTO tfriends (fNAME, nUm, pHONe) VALUES
('ㅈㅈㅎ', '3', '010-0303-0303');
--임의의 순서로 저장하고싶으면 table명 과 values사이에 임의이 순서 배정후 값 입력

	/* 데이터 조회문 */
SELECT num, fname, phone FROM tfriends;
-- SELECT * FROM tfriends; --그냥 전체를 표시하고 싶다면.

	/* 데이터 수정문 */
UPDATE tfriends SET fname = 'John' WHERE num = 2;
UPDATE tfriends SET fname = 'master', phone = '010-9273-****' WHERE num = 3;
UPDATE tfriends SET phone = '' WHERE num = 3; 

SELECT fname, phone FROM tfriends;
	/* 데이터 삭제문 */
DELETE FROM tfriends WHERE num = 3;
DROP DATABASE test00;

	/* 게시판 생성 */
CREATE TABLE tbl_board(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(50),
	contents VARCHAR(1000),
	writer VARCHAR(20) NOT NULL UNIQUE,
	regdatre DATETIME DEFAULT CURTIME()
);
	/*
	하나의 행을 다른 행과 구분짓기 위한, 중복을 피하기 위한  식별자가 필요하다.
	이 때, 값을 선언할 때 '식별자'를 제약조건으로 첨가한다.
	'PRIMARY KEY'(PK, 기본키) 혹은 'UNIQUE'(후보키)
	'AUTO_INCREMENT'를 통해 고유의 번호를 가지게 된다.
	그외, NOT NULL을 추가해서, 입력을 필수조건으로 만들수도 있다.
	*/
	/*
	자료형:
	DATE = 'YYYY-MM-DD' DEFAULT CURDATE()
	DATETIME = 'YYYY-MM-SS' DEFAULT CURTIME()
	*/

DESC tbl_board;
-- 특징 조회?

INSERT INTO tbl_board (title, contents, writer)
VALUES ('test title', 'test conents', 'user01');
INSERT INTO tbl_board (title, contents, writer)
VALUES ('test title2', 'test contents', 'user02');
SELECT * FROM tbl_board;

DROP TABLE tbl_board;


