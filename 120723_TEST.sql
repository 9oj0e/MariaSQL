-- 2 1)
CREATE TABLE departmentTbl(
	deptNo CHAR(2) PRIMARY KEY,
	deptName VARCHAR(10) UNIQUE NOT NULL,
	profName VARCHAR(10) NOT NULL,
	tel CHAR(13) UNIQUE NOT NULL
);
-- 2 2)
CREATE TABLE studentTbl(
	sno INT AUTO_INCREMENT PRIMARY KEY,
	sname VARCHAR(20) NOT NULL,
	deptNo CHAR(2) NOT NULL,
	grade CHAR(1) NOT NULL,
	phone CHAR(13),
	gender CHAR(1) NOT NULL,
	CONSTRAINT ck_grade CHECK((grade) IN('1', '2', '3', '4')),
	CONSTRAINT ck_gender CHECK((gender) IN('M', 'F')),
	FOREIGN KEY (deptNo) REFERENCES departmentTbl(deptNo)
);
-- 3 1)
INSERT INTO departmentTbl
VALUES
	('AA', '경영', '박경영','051-333-3232'),
	('BB', '컴퓨터공학', '김전산','051-444-4242'),
	('CC', '교육공학', '천교육','051-555-5252');

-- 3 2)
INSERT INTO studentTbl
	(sname, deptNo, grade, phone, gender)
VALUES
	('김동주', 'AA', '1', '010-1111-1111', 'M'),
	('나동민', 'BB', '2', '010-2222-2222', 'M'),
	('도미솔', 'CC', '3', '010-3333-3333', 'F'),
	('민건식', 'AA', '4', '010-4444-4444', 'M'),
	('홍민주', 'CC', '1', '010-5555-5555', 'F');
	
-- 4
SELECT sno, gender, grade FROM studentTbl WHERE deptNo = 'AA';
-- 5
SELECT deptNo, COUNT(*) FROM studentTbl GROUP BY deptNo;
-- 6
SELECT s.sno, s.sname, d.deptName, d.profName FROM studentTbl s, departmenttbl d WHERE s.deptNo = d.deptNo;
-- 7
CREATE VIEW v_stuDeptName
AS
(SELECT s.sno, s.sname, d.deptName, d.profName FROM studentTbl s, departmenttbl d WHERE s.deptNo = d.deptNo);
-- 9
SELECT sno, sname, deptNo FROM studentTbl WHERE sname LIKE '_동%' AND deptNo LIKE '%A';

DROP table studentTbl;
DROP table departmenttbl;