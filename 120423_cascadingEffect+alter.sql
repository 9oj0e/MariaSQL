		/*12.04.23*/
/* 복습 포인트 */
-- 제약조건 CHECK
-- 조건부 조회 DISTINCT, ORDER BY, GROUP BY, DESC/ASC
-- 조건부 조회 HAVING과 WHERE

	/*사원 테이블 */
CREATE TABLE employees(
	empno INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(10),
	phone VARCHAR(13),
	dept CHAR(4)
);
	/* 사원 게시판 테이블 */
CREATE TABLE eboard(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(10),
	content VARCHAR(100),
	empno INT,
-- 참조하려는 항목의 PK 제약조건에 따라 UNIQUE를 넣으면? 1인당 1게시물만 쓸 수 있게 됨.
	FOREIGN KEY (empno) REFERENCES employees(empno)
	ON UPDATE CASCADE -- 참조하는 항목이 갱신되면, 참조된 항목도 갱신.
--	ON DELETE CASCADE -- 참조하는 항목이 삭제되면, 참조된 항목도 삭제. (주의해서 써야할 항목)
	ON DELETE SET NULL -- 참조하는 항목이 삭제되면, 참조된 항목을 값을 비운다.
);
/*
독립적인 TABLE = 어느 TABLE에도 종속되지 않은 데이터.
의존적인 TABLE = 어떤 TABLE(S)에 종속된 데이터. 다른 데이터를 사용하는 TABLE.
무결성 데이터 = 문제가 없게끔 하는 성질
*CASCADING EFFECT 원데이터에서의 변화가 하위데이터에도 일어나는 것.
*/

INSERT INTO employees
	(ename, phone, dept)
VALUE
	('철수', '01000000000', '영업'),
	('영희', '01010001000', '인사')
;
INSERT INTO eboard
	(title, content, empno)
VALUE
	('안녕하세요', '안녕하세요 반갑습니다', 1),
	('또 안녕', '아무도 대답이 없네..', 1),
	('안녕하세요', '처음 뵙습니다', 2)
;

SELECT e.empno, e.ename, e.phone, b.title, b.content
FROM employees e, eboard b -- AS 생략 가능
;

UPDATE employees SET empno = 10 WHERE empno = 2;
-- TABLE제약조건에 ON UPDATE 항목이 없다면 실행불가
DELETE FROM employees WHERE empno = 10;
-- TABLE 제약조건에 ON DELETE 항목이 없다면 실행불가

	/* ALTER: 구조변경 */
/*
회사에서는 DB부서가 따로있고, 신입개발자가 건드릴 일은 거의 없다.
있다면, 중소기업에 따로 부서가없고, 본인이 책임지고 프로젝트를 만들어야하는경우.
*/
	/* ALTER: 추가 */
ALTER TABLE employees
ADD COLUMN address VARCHAR(100),
ADD COLUMN nickname VARCHAR(10) DEFAULT '없음',
ADD COLUMN birthday DATE AFTER phone,
ADD COLUMN gender INT CHECK(gender IN (1, 2)) AFTER birthday;
-- 의도적인 자료형 INT설정.
DESCRIBE employees; -- DESC (DESCend와 구분짓기 위함)
	/* ALTER: 수정 */

/* 항목의 제약조건까지 갱신되어서, 결과적으로 사라짐.
ALTER TABLE employees
MODIFY COLUMN gender CHAR(1);
*/
ALTER TABLE employees
MODIFY gender CHAR(1) CHECK(gender IN ('M', 'F'));
ALTER TABLE employees
MODIFY nickname VARCHAR(10) AFTER birthday;
CHANGE birthday birthDate DATE;
ALTER TABLE employees
CHANGE birthday birthDate DATE;
--
/* 실행불가
ALTER TABLE employees
MODIFY nickname VARCHAR(10) AFTER birthday,
CHANGE birthday birthDate DATE;
*/
ALTER TABLE eboard
RENAME tbl_eboard;

	/* ALTER: 삭제 */
ALTER TABLE employees
DROP COLUMN nickname;

CREATE TABLE test(
	id VARCHAR(10),
	pw VARCHAR(10)
);

	/* 응용 */
ALTER TABLE test
ADD COLUMN empno INT,
ADD FOREIGN KEY (empno) REFERENCES employees(empno);

SELECT *
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'test';
/*
mysql 데이터베이스 informaiton_schema, mysql, performance_schema, sys는 기본 데이터베이스
table_constraints는 기본 데이터베이스에 포함된 테이블.
왠만해서 수정할 일이 없다.
*/

ALTER TABLE test00.test
DROP FOREIGN KEY test_ibfk_1;


	/* 응용2 */
CREATE TABLE tCustomer (
	tID VARCHAR(10) PRIMARY KEY NOT NULL,
	tPW VARCHAR(10) NOT NULL,
	tName VARCHAR(10),
	tGen CHAR(1) CHECK (tGen = BETWEEN 'M' AND 'F'),
	tPhone VARCHAR(13) NOT NULL, -- 주문
	tAd VARCHAR(20), -- 배송지 관리
	tRegDate DATE DEFAULT CURDATE()
);
ALTER TABLE tCustomer
ADD COLUMN tBirthDate DATE;
-- 기념일 

CREATE TABLE tOrder (
	oNum INT AUTO_INCREMENT UNIQUE,
	oName VARCHAR(10),
	oPTitle VARCHAR(10), -- 상품명
	oPCode VARCHAR(10), -- 상품 코드
	oID VARCHAR(10),
	oAd VARCHAR(20) NOT NULL,
	oPhone VARCHAR(13) NOT NULL,
	FOREIGN KEY (o
);
CREATE TABLE tbl_order(
	orderNo INT AUTO_INCREMENT UNIQUE,
	mno INT,
	pname VARCHAR(100),
	ea INT,
	price INT,
	PRIMARY KEY(orderNo, mno, pname)
); -- PK는 여러키를 한꺼번에 묶을 수 있다.

SELECT * FROM employees;
SELECT * FROM tbl_eboard;

DROP TABLE eboard;
DROP TABLE employees;