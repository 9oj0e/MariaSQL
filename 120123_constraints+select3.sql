		/*12.01.23*/
/* 복습 포인트 */
-- ?
SELECT grade,
COUNT(*) AS '학생수'
FROM tbl_students
GROUP BY grade
;
-- 학년별 학생수를 조회

SELECT grade, class,
COUNT(sno) AS '학생수'
FROM tbl_students
GROUP BY grade, class
;
-- 학년, 반별 학생수 조회

SELECT grade, class,
SUM(kor_score) AS '국어점수 합계'
FROM tbl_students
GROUP BY grade, class;
-- 학년, 반별 국어점수 합계 조회

SELECT grade, class,
SUM(kor_score+eng_score+sql_score) AS 총점
FROM tbl_students
GROUP BY grade, class
ORDER BY 총점
DESC
;
-- 학년, 반별 국어점수, 영어점수, sql점수를 합한 총점을 내림차순으로 조회
-- 그룹화 후 정렬 실행. 'order by'는 'group by'보다 선행할 수 없다.

SELECT grade, class,
SUM(kor_score+eng_score+sql_score) AS 총점
FROM tbl_students
GROUP BY grade, class
HAVING 총점 > 1000
;
-- where절은 from 절과 함께(where절 바로 다음에)만 쓸 수 있다.
-- having절을 써서 조건문을 어느 위치에나 넣을 수 있음.


SELECT sname, grade, class
FROM tbl_students
WHERE sql_score = (SELECT MIN(sql_score) FROM tbl_students)
;
-- sql점수가 최저점인 학생의 이름과 학년, 반을 조회

CREATE TABLE tbl_users(
	id VARCHAR(20) PRIMARY KEY,
	pw VARCHAR(20) NOT NULL,
	uname VARCHAR(20),
	phone VARCHAR(13),
	addr VARCHAR(100)
)
;
INSERT INTO tbl_users
	(id, pw, uname, phone, addr)
VALUES
	('hsh01', '1234', '한상현', '01000000000', '부산'),
	('hsh02', '2345', '둘상현', '01000000000', '부산'),
	('hsh03', '3456', '셋상현', '01000000000', '부산'),
	('hsh04', '4567', '넷상현', '01000000000', '부산'),
	('hsh05', '5678', '다섯상현', '01000000000', '부산')
;

	/* 외부키 참조 table */
CREATE TABLE tbl_boards(
	bno INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	writer VARCHAR(20) NOT NULL,
	regdate DATETIME DEFAULT CURTIME(),
	FOREIGN KEY (writer) REFERENCES tbl_users(id)
)-- 여기서 writer는 외부키 tbl_users의 id컬럼을 참조(연결)한다.
;
/*
tbl_boards의 writer는 오직 tbl_users에 id가 존재하는 사람이어야 한다.
즉 다시말해, tbl_users에 id가 없는 사람은 tbl_boards에 데이터를 넣을 수 없다.
REFERENCES는 후에 등장할 JOIN, INNER JOIN, OUTER JOIN과도 유사한 개념
*/

SELECT u.id, u.uname, b.writer, b.content FROM tbl_users AS u, tbl_boards AS b WHERE u.id = b.writer;

DROP TABLE tbl_boards;
DROP TABLE tbl_users;

INSERT INTO tbl_boards
	(title, content, writer)
VALUES
	('testtitle01', 'test', 'hsh01')
;
SELECT * FROM tbl_boards;

INSERT INTO tbl_boards
	(title, content, writer)
VALUES
	('constraint', 'test', 'blah')
;
-- writer항목과 tbl_users 테이블의 id항목과 차이가 있으므로 애러. 

/*
CREATE TABLE dollops(
	uno INT PRIMARY KEY AUTO_INCREMENT,
	uid VARCHAR(10) NOT NULL UNIQUE,
	ugender CHAR(1) NOT NULL CHECK(ugender IN('M','F')),
	uname VARCHAR(20) NOT NULL,
	uadd CHAR(10),
	umemo VARCHAR(10),
	uregdate DATE DEFAULT CURDATE()
)
;
INSERT INTO dollops
	(uid, ugender, uname, uloc, uhobby, umemo)
VALUES
	('hsh1201', 'm', '한상현', '부산', '컴퓨터', ''),
	('khs82', 'm', '김형석', '창원', '유튜브', ''),
	('uukyi01', 'm', '오진욱', '울산', '축구', ''),
	('imhwangse', 'm', '황상현', '진주', '농구', ''),
	('ghacki', 'm', '최기혁', '동해', '축구', '')
;
CREATE TABLE dungeaters(
	dno INT PRIMARY KEY AUTO_INCREMENT,
	dtitle VARCHAR(10),
	dcontent VARCHAR(1000),
	did VARCHAR(10) NOT NULL UNIQUE,
	dwriter VARCHAR(20) DEFAULT dollops(dname),
	ddate DATETIME CURTIME(),
	FOREIGN KEY (did) REFERENCES dollops(uid)
);
INSERT INTO dungeaters
	(dtitle, dcontent, did)
VALUES
	('ㅎㅇㅇ', '형이거좀', 'hsh1201'),
	('아니', '아무도 대답이없네', 'hsh1201'),
	('인생', '힘들다', 'ghacki'),
	('기혁이', '피방ㄱㄱ', 'uukyi01'),
	('게시글', '볼거 ㅈㄴ없네', 'imhwangse'),
	('안녕하세요', '어디서오신 분들이죠', 'hsh1201')
;
*/

