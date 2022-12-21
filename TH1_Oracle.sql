CREATE TABLE campus (
    campusid       VARCHAR2(5) NOT NULL,
    campusname     VARCHAR2(100),
    street         VARCHAR2(100),
    city           VARCHAR2(100),
    state          VARCHAR2(100),
    zip            VARCHAR2(100),
    phone          VARCHAR2(100),
    campusdiscount DECIMAL(2, 2),
    CONSTRAINT campus_pk PRIMARY KEY ( campusid )
);

CREATE TABLE position (
    positionid     VARCHAR2(5) NOT NULL,
    position       VARCHAR2(100),
    campusdiscount DECIMAL(7, 2),
    CONSTRAINT position_pk PRIMARY KEY ( positionid )
);

CREATE TABLE members (
    memberid         VARCHAR2(5) NOT NULL,
    lastname         VARCHAR2(100),
    firstname        VARCHAR2(100),
    campusaddress    VARCHAR2(100),
    campusphone      VARCHAR2(100),
    campusid         VARCHAR2(5),
    positionid       VARCHAR2(5),
    contractduration INTEGER,
    CONSTRAINT members_pk PRIMARY KEY ( memberid )
);

CREATE TABLE prices (
    fooditemtypeid NUMBER(20) NOT NULL,
    mealtype       VARCHAR2(100),
    mealprice      DECIMAL(7, 2),
    CONSTRAINT prices_pk PRIMARY KEY ( fooditemtypeid )
);

CREATE TABLE fooditems (
    fooditemid     VARCHAR2(5) NOT NULL,
    fooditemname   VARCHAR2(100),
    fooditemtypeid NUMBER(20),
    CONSTRAINT fooditems_pk PRIMARY KEY ( fooditemid )
);

CREATE TABLE orders (
    orderid   VARCHAR2(5) NOT NULL,
    memberid  VARCHAR2(5),
    orderdate VARCHAR2(25),
    CONSTRAINT orders_pk PRIMARY KEY ( orderid )
);

CREATE TABLE ordersline (
    orderid     VARCHAR2(5) NOT NULL,
    fooditemsid VARCHAR2(5) NOT NULL,
    quantity    INTEGER,
    CONSTRAINT ordersline_pk PRIMARY KEY ( orderid,
                                           fooditemsid )
);


--Them khoa ngoai cho bang

 -- + MemberS - position
ALTER TABLE members
    ADD CONSTRAINT fk01_mb FOREIGN KEY ( positionid )
        REFERENCES position ( positionid )
 
  -- + MemberS - CAMPUS
ALTER TABLE members
    ADD CONSTRAINT fk03_mb FOREIGN KEY ( campusid )
        REFERENCES campus ( campusid )
 
 -- + FOODITEMS - PRICES
ALTER TABLE fooditems
    ADD CONSTRAINT fk02_fi FOREIGN KEY ( fooditemtypeid )
        REFERENCES prices ( fooditemtypeid )

-- + ORDERS - MEMBERS
ALTER TABLE ORDERS
    ADD CONSTRAINT fk04_od FOREIGN KEY ( MEMBERID )
        REFERENCES MEMBERS ( MEMBERID )

-- + ORDERSLINE  - ORDERS
ALTER TABLE ORDERSLINE
    ADD CONSTRAINT fk05_od FOREIGN KEY ( ORDERID )
        REFERENCES ORDERS ( ORDERID )
        
-- + ORDERSLINE  - FOODITEMS     
ALTER TABLE ORDERSLINE
    ADD CONSTRAINT fk06_od FOREIGN KEY ( FOODITEMSID )
        REFERENCES FOODITEMS ( FOODITEMID )

--xOA 
DROP TABLE campus;

DROP TABLE prices;

DROP TABLE fooditems;

DROP TABLE members;

DROP TABLE orders;

DROP TABLE ordersline;

DROP TABLE position;


-- 2. Tao sequence

CREATE Sequence prices_fooditemstypeid_SEQ;

-- 3. Nhap hang

-- Nhap campus
insert into campus values('1','IUPUI','425 University Blvd.','Indianapolis', 'IN','46202', '317-274-4591',.08);
insert into campus values('2','Indiana University','107 S. Indiana Ave.','Bloomington', 'IN','47405', '812-855-4848',.07);
insert into campus values('3','Purdue University','475 Stadium Mall Drive','West Lafayette', 'IN','47907', '765-494-1776',.06);

--Nhap position
insert into POSITION values('1','Lecturer', 1050.50);
insert into POSITION values('2','Associate Professor', 900.50);
insert into POSITION values('3','Assistant Professor', 875.50);
insert into POSITION values('4','Professor', 700.75);
insert into POSITION values('5','Full Professor', 500.50);

--Nhap members
insert into MEMBERS values('1','Ellen','Monk','009 Purnell', '812-123-1234', '2', '5', 12);
insert into MEMBERS values('2','Joe','Brady','008 Statford Hall', '765-234-2345', '3', '2', 10);
insert into MEMBERS values('3','Dave','Davidson','007 Purnell', '812-345-3456', '2', '3', 10);
insert into MEMBERS values('4','Sebastian','Cole','210 Rutherford Hall', '765-234-2345', '3', '5', 10);
insert into MEMBERS values('5','Michael','Doo','66C Peobody', '812-548-8956', '2', '1', 10);
insert into MEMBERS values('6','Jerome','Clark','SL 220', '317-274-9766', '1', '1', 12);
insert into MEMBERS values('7','Bob','House','ET 329', '317-278-9098', '1', '4', 10);
insert into MEMBERS values('8','Bridget','Stanley','SI 234', '317-274-5678', '1', '1', 12);
insert into MEMBERS values('9','Bradley','Wilson','334 Statford Hall', '765-258-2567', '3', '2', 10);

SELECT prices_fooditemstypeid_SEQ.Nextval FROM DUAL;

--Nhap prices
insert into PRICES values(1,'Beer/Wine', 5.50);
insert into PRICES values(prices_fooditemstypeid_SEQ.Nexval,'Beer/Wine', 5.50);
insert into PRICES values(prices_fooditemstypeid_SEQ.Nextval,'Dessert', 2.75);
insert into PRICES values(prices_fooditemstypeid_SEQ.Nextval,'Dinner', 15.50);
insert into PRICES values(prices_fooditemstypeid_SEQ.Nextval,'Soft Drink', 2.50);
insert into PRICES values(prices_fooditemstypeid_SEQ.Nextval,'Lunch', 7.25);

--Nhap fooditems
insert into FOODITEMS values('10001','Lager', '1');
insert into FOODITEMS values('10002','Red Wine', '1');
insert into FOODITEMS values('10003','White Wine', '1');
insert into FOODITEMS values('10004','Coke', '4');
insert into FOODITEMS values('10005','Coffee', '4');
insert into FOODITEMS values('10006','Chicken a la King', '3');
insert into FOODITEMS values('10007','Rib Steak', '3');
insert into FOODITEMS values('10008','Fish and Chips', '3');
insert into FOODITEMS values('10009','Veggie Delight', '3');
insert into FOODITEMS values('10010','Chocolate Mousse', '2');
insert into FOODITEMS values('10011','Carrot Cake', '2');
insert into FOODITEMS values('10012','Fruit Cup', '2');
insert into FOODITEMS values('10013','Fish and Chips', '5');
insert into FOODITEMS values('10014','Angus Beef Burger', '5');
insert into FOODITEMS values('10015','Cobb Salad', '5');

--Nhap order
insert into ORDERS values('1', '9', 'March 5, 2005');
insert into ORDERS values('2', '8', 'March 5, 2005');
insert into ORDERS values('3', '7', 'March 5, 2005');
insert into ORDERS values('4', '6', 'March 7, 2005');
insert into ORDERS values('5', '5', 'March 7, 2005');
insert into ORDERS values('6', '4', 'March 10, 2005');
 
 -- Nhap orderline
insert into ORDERSLINE values('1','10001',1);
insert into ORDERSLINE values('1','10006',1);
insert into ORDERSLINE values('1','10012',1);
insert into ORDERSLINE values('2','10004',2);
insert into ORDERSLINE values('2','10013',1);
insert into ORDERSLINE values('2','10014',1);
insert into ORDERSLINE values('3','10005',1);
insert into ORDERSLINE values('3,'10011',1);
insert into ORDERSLINE values('4','10005',2);
insert into ORDERSLINE values('4','10004',2);
insert into ORDERSLINE values('4','10006',1);
insert into ORDERSLINE values('4','10007',1);
insert into ORDERSLINE values('4','10010',2);
insert into ORDERSLINE values('5','10003',1);
insert into ORDERSLINE values('6','10002',2);
insert into ORDERSLINE values('6','10005',2);
insert into ORDERSLINE values('5','10005',1);
insert into ORDERSLINE values('4','10011',1);
insert into ORDERSLINE values('3','10001',1);

--1. Lay tat ca contraint
select * from all_constraints

--2. Lay tat ca table name
SELECT
  table_name
FROM
  all_tables
--3. Liet ke tat ca cac ten sequence trong db

select sequence_owner, sequence_name from dba_sequences;

-- 4. Li?t kê các thành viên v?i các c?t FirstName, LastName, Position,
-- CampusName, (YearlyMembershipFee / 12 ) Monthly_Dues. Sau ?ó s?p
-- x?p theo tên ??i h?c gi?m d?n, ti?p theo LastName t?ng d?n

select M.FIRSTNAME,C.CAMPUSNAME , M.LASTNAME, P.POSITION , (C.CAMPUSDISCOUNT/12)MONTHLY_DUES
from MEMBERS M, POSITION P, CAMPUS C
WHERE M.POSITIONID = P.POSITIONID AND M.CAMPUSID= C.CAMPUSID
ORDER BY M.LASTNAME ASC, C.CAMPUSNAME DESC
