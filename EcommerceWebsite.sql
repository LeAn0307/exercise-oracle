CREATE TABLE product (
    id          NUMBER(10, 0) NOT NULL,
    name        VARCHAR2(255),
    type        VARCHAR2(255),
    discount    NUMBER(10, 0),
    avgrating   NUMBER(10, 0),
    material    VARCHAR2(255),
    categoryid  NUMBER(10, 0),
    height      NUMBER(10, 0),
    width       NUMBER(10, 0),
    weight      NUMBER(10, 0),
    description VARCHAR2(255),
    image       VARCHAR2(255),
    brand       VARCHAR2(255),
    madein      VARCHAR2(255),
    amount      NUMBER(10, 0),
    color       VARCHAR2(255)
);
---
CREATE TABLE categories (
    categoriesid   NUMBER(10, 0) NOT NULL,
    categoriesname VARCHAR2(255),
    image          VARCHAR2(255)
);

---
CREATE TABLE billdetails (
    id         NUMBER(10, 0) NOT NULL,
    bill_id    NUMBER(10, 0),
    productid  NUMBER(10, 0),
    quantity   NUMBER(10, 0),
    price      DECIMAL(10, 0),
    created_at DATE,
    updated_at DATE
);


----

CREATE TABLE cart_product (
    id        NUMBER(10, 0) NOT NULL,
    cartid    NUMBER(10, 0),
    productid NUMBER(10, 0),
    quantity  NUMBER(10, 0)
);

--- 
CREATE TABLE cartcoupon (
    id       NUMBER(10, 0) NOT NULL,
    cartid   NUMBER(10, 0),
    couponid NUMBER(10, 0)
);
--- 
CREATE TABLE coupon (
    id       NUMBER(10, 0) NOT NULL,
    name     VARCHAR2(30),
    discount NUMBER(10, 0)
)

---
CREATE TABLE cart (
    id     NUMBER(10, 0) NOT NULL,
    userid NUMBER(10, 0),
    total  DECIMAL(10, 0)
)
------
CREATE TABLE rating (
    id           NUMBER(10, 0) NOT NULL,
    reply        VARCHAR2(100),
    rate         INT,
    idproduct    NUMBER(10, 0),
    iduser       NUMBER(10, 0),
    idbilldetail NUMBER(10, 0)
)
---

CREATE TABLE bill (
    bill_id    NUMBER(10, 0) NOT NULL,
    customerid NUMBER(10, 0),
    date_order DATE,
    total      DECIMAL(10, 0),
    note       VARCHAR2(255),
    status     VARCHAR2(255),
    payment    VARCHAR2(255),
    codemomo   VARCHAR2(255),
    created_at DATE,
    updated_at DATE
)

---

CREATE TABLE account (
    id       NUMBER(10, 0) NOT NULL,
    name     VARCHAR2(100),
    iduser   NUMBER(10, 0),
    address  VARCHAR2(255),
    phone    VARCHAR2(255),
    email    VARCHAR2(255),
    password VARCHAR2(255)
);


---

CREATE TABLE user_website (
    id       NUMBER(10, 0) NOT NULL,
    username VARCHAR2(255),
    password VARCHAR2(255)
);

--


CREATE TABLE user_role (
    id      NUMBER(10, 0) NOT NULL,
    id_role NUMBER(10, 0)
);

--

CREATE TABLE role (
    id_role     NUMBER(10, 0) NOT NULL,
    role        VARCHAR2(50),
    id_function NUMBER(10, 0)
);
--

CREATE TABLE function (
    id     NUMBER(10, 0) NOT NULL,
    name   VARCHAR2(255),
    id_role NUMBER(10,0)
);

--Thêm khóa ngo?i cho   product -categories


--Thêm khóa ngo?i cho cart_product - product


--Thêm khóa ngo?i cho rating - product


--Thêm khóa ngo?i cho bill detail - product


--Thêm khóa ngo?i cho rating bill detail 

--Thêm khóa ngo?i cho 

--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho 

--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho 



--Thêm khóa ngo?i cho 


--Thêm khóa ngo?i cho