--BAI 1: PROCEDURE
--1.1 

CREATE OR REPLACE PROCEDURE dept_info (
    id   NUMBER,
    name OUT departments.department_name%TYPE
) AS
BEGIN
    SELECT
        department_name
    INTO name
    FROM
        departments
    WHERE
        department_id = id;

    dbms_output.put_line('Ten phong ban: ' || name);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Khong co phong ban');
END;

DECLARE
    name departments.department_name%TYPE;
BEGIN
    dept_info(10, name);
END;


--1.2 

CREATE OR REPLACE PROCEDURE add_job (
    in_job_id    jobs.job_id%TYPE,
    in_job_title jobs.job_title%TYPE
) IS
    error_ex EXCEPTION;
    tempid jobs.job_id%TYPE; --luu cac id cong viec da co vao temp
BEGIN
    SELECT
        job_id
    INTO tempid
    FROM
        jobs j
    WHERE
        j.job_id = in_job_id;

    IF tempid IS NOT NULL THEN
        RAISE error_ex;
    END IF;
EXCEPTION
    WHEN error_ex THEN
        dbms_output.put_line('Job da ton tai, khong them duoc');
    WHEN no_data_found THEN
        INSERT INTO jobs (
            job_id,
            job_title
        ) VALUES (
            in_job_id,
            in_job_title
        );

        dbms_output.put_line('Them thanh cong: ' || in_job_id);
END;

DECLARE BEGIN
    add_job('lili', 'AN TEST123');
END;

--
--1.3)   update_comm -> CAP NHAT 5% HOA HONG BAN DAU, THAM SO MA NHAN VIEN
--
CREATE OR REPLACE PROCEDURE update_comm (
    in_employee_id employees.employee_id%TYPE
) IS
BEGIN
    UPDATE employees e
    SET
        e.commission_pct = e.commission_pct * 1.05
    WHERE
        e.employee_id = in_employee_id;

    dbms_output.put_line('Cap nhat thanh cong:' || in_employee_id);
END;

DECLARE BEGIN
    update_comm(177);
END;


--1.4  add_emp them mot nhan vien voi tat cac gia tri truyen vao

CREATE OR REPLACE PROCEDURE add_emp (
    id         employees.employee_id%TYPE,
    fname      employees.first_name%TYPE,
    lname      employees.last_name%TYPE,
    email      employees.email%TYPE,
    phone      employees.phone_number%TYPE,
    h_date     employees.hire_date%TYPE,
    job_id     employees.job_id%TYPE,
    salary     employees.salary%TYPE,
    com_pct    employees.commission_pct%TYPE,
    manager_id employees.manager_id%TYPE,
    depart_id  employees.department_id%TYPE
) IS
    temp_count NUMBER;
    error_ex EXCEPTION;
BEGIN
    SELECT
        COUNT(1)
    INTO temp_count
    FROM
        employees
    WHERE
        employee_id = id;

    IF ( temp_count > 0 ) THEN
        RAISE error_ex;
    ELSE
        INSERT INTO employees VALUES (
            id,
            fname,
            lname,
            email,
            phone,
            h_date,
            job_id,
            salary,
            com_pct,
            manager_id,
            depart_id
        );

        dbms_output.put_line('Them thanh cong!');
    END IF;

EXCEPTION
    WHEN error_ex THEN
        dbms_output.put_line('Nhan vien da ton tai!');
END;

DECLARE BEGIN
    add_emp(1, 'An', 'Le', 'AnLe', '011.44.1346.329268',
           '24-JAN-08', 'SA_REP', 7200, 0.1, 147,
           80);
END;


--1.5 delete_emp xoa 1 nhan vien, thso truyen vao la ma nhan vien

CREATE OR REPLACE PROCEDURE delete_emp (
    in_employee_id employees.employee_id%TYPE
) IS
    temp_count NUMBER;
    error_ex EXCEPTION;
BEGIN
    SELECT
        COUNT(1)
    INTO temp_count
    FROM
        employees
    WHERE
        employee_id = in_employee_id;

    IF ( temp_count <= 0 ) THEN
        RAISE error_ex;
    ELSE
        DELETE FROM employees
        WHERE
            employee_id = in_employee_id;

        dbms_output.put_line('Da xoa: ' || in_employee_id);
    END IF;

EXCEPTION
    WHEN error_ex THEN
        dbms_output.put_line('Nhan vien khong ton tai, ko the xoa');
END;

DECLARE BEGIN
    delete_emp(1);
END;


--1.6 find_emp: tim NV co luong > luong thap nhat

CREATE OR REPLACE PROCEDURE find_emp AS

    CURSOR c_employee IS
    SELECT
        employee_id,
        first_name
    FROM
        employees a
    WHERE
            salary > (
                SELECT
                    min_salary
                FROM
                    jobs b
                WHERE
                    a.job_id = b.job_id
            )
        AND salary < (
            SELECT
                max_salary
            FROM
                jobs c
            WHERE
                a.job_id = c.job_id
        );

    v_emp_id     employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
BEGIN
    FOR row_employee IN c_employee LOOP
        v_emp_id := row_employee.employee_id;
        v_first_name := row_employee.first_name;
        dbms_output.put_line('Ma NV: '
                             || v_emp_id
                             || ' TenNV: '
                             || v_first_name);
    END LOOP;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No data found');
END;

DECLARE BEGIN
    find_emp();
END;


--1.7 cap nhat luong nhan vien
CREATE OR REPLACE PROCEDURE update_comm AS
    v_sonam_lamviec VARCHAR2(2);
    temp_add_salary NUMBER := 0;
    CURSOR c_nhanvien IS
    SELECT
        *
    FROM
        employees;

BEGIN
    FOR r_nhanvien IN c_nhanvien LOOP
        v_sonam_lamviec := to_char(sysdate, 'yyyy') - to_char(r_nhanvien.hire_date, 'yyyy');

        IF v_sonam_lamviec >= 2 THEN -- ( >= 2 nam ) tang +200$
            temp_add_salary := 200;
            dbms_output.put_line('Nhan vien :'
                                 || r_nhanvien.last_name
                                 || ' da duoc tang 200$');
        ELSIF v_sonam_lamviec > 1 THEN -- ( >1  && <2NAM ) tang +100$
            temp_add_salary := 200;
            dbms_output.put_line('Nhan vien :'
                                 || r_nhanvien.last_name
                                 || ' da duoc tang 100$');
        ELSIF v_sonam_lamviec = 1 THEN -- ( =1 ) tang +50$
            temp_add_salary := 50;
            dbms_output.put_line('Nhan vien :'
                                 || r_nhanvien.last_name
                                 || ' da duoc tang 50$');
        ELSE
            dbms_output.put_line('Khong tang luong');
        END IF;

        UPDATE employees
        SET
            salary = salary + temp_add_salary
        WHERE
            employee_id = r_nhanvien.employee_id;

    END LOOP;
END;

DECLARE BEGIN
    update_comm();
END;


--  1.8) 

CREATE OR REPLACE PROCEDURE job_his (
    emp_id IN job_history.employee_id%TYPE
) IS
    ex EXCEPTION;
BEGIN
--    IF emp_id NOT IN (
--        SELECT
--            employee_id
--        FROM
--            job_history
--        WHERE
--            employee_id = emp_id
--    ) THEN
--        RAISE ex;
--    END IF;

    FOR emp_his IN (
        SELECT
            *
        FROM
            job_history
        WHERE
            employee_id = emp_id
    ) LOOP
        dbms_output.put_line('Start date: '
                             || emp_his.start_date
                             || '- End date: '
                             || emp_his.end_date
                             || '- Job ID: '
                             || emp_his.job_id
                             || '- Dapartment ID: '
                             || emp_his.department_id);
    END LOOP;

--EXCEPTION
--    WHEN no_data_found THEN
--        dbms_output.put_line('Khong co nhan vien phu hop');
--    WHEN ex THEN
--        dbms_output.put_line('Ma nhan vien khong hop le');
END;

BEGIN
    job_his(176);
END;


-----BAI 2: FUNCTION------------------------------------------------------------------------
--


--2.1) sum_salary 

CREATE OR REPLACE FUNCTION sum_salary (
    dept_id IN departments.department_id%TYPE
) RETURN NUMBER IS
    sum_sal NUMBER;
BEGIN
    SELECT
        SUM(salary)
    INTO sum_sal
    FROM
        employees
    WHERE
        department_id = dept_id;

    IF sum_sal IS NULL THEN
        RETURN 0;
    ELSE
        RETURN sum_sal;
    END IF;
END;

SELECT
    sum_salary(100)
FROM
    dual;
    
--2.2) 

CREATE OR REPLACE FUNCTION name_con (
    id IN countries.country_id%TYPE
) RETURN countries.country_name%TYPE IS
    name countries.country_name%TYPE;
BEGIN
    SELECT
        country_name
    INTO name
    FROM
        countries
    WHERE
        country_id = id;
    RETURN name;
END;

SELECT
    name_con('EG')
FROM
    dual
    
--2.3) 


CREATE OR REPLACE FUNCTION annual_comp (
    salary IN NUMBER,
    comm   IN NUMBER
) RETURN NUMBER IS
    total_income NUMBER;
BEGIN
    total_income := salary * ( 1 + comm ) * 12;
    dbms_output.put_line('Thu nhap: ' || total_income);
    RETURN total_income;
END;

SELECT
    annual_comp(1000, 0.4)
FROM
    dual;


--2.4)


CREATE OR REPLACE FUNCTION avg_salary (
    id IN employees.department_id%TYPE
) RETURN NUMBER IS
    avg_salary NUMBER;
BEGIN
    SELECT
        AVG(salary)
    INTO avg_salary
    FROM
        employees
    WHERE
        department_id = id;

    dbms_output.put_line('Luong trung binh: ' || avg_salary);
    RETURN avg_salary;
END;

SELECT
    avg_salary(70)
FROM
    dual;

--2.5) 

CREATE OR REPLACE FUNCTION time_work (
    id_emp IN NUMBER
) RETURN NUMBER IS
    working_time NUMBER;
BEGIN
    SELECT
        months_between(sysdate, hire_date)
    INTO working_time
    FROM
        employees
    WHERE
        employee_id = id_emp;

    dbms_output.put_line('Thoi gian lam trung binh: ' || working_time);
    RETURN working_time;
END;

SELECT
    time_work(165) AS month
FROM
    dual;


--BAI 3: TRIGGER

--3.1) 
CREATE OR REPLACE TRIGGER hire_date BEFORE
    INSERT OR UPDATE ON employees
    FOR EACH ROW
DECLARE BEGIN
    IF :new.hire_date > sysdate THEN
        raise_application_error(-20000, 'ERROR: NGAY THUE LON HON NGAY HIEN HANH');
    END IF;
END;
--TEST 3.1
BEGIN
    add_emp('237', 'An', 'Le', 'AnCute@GMAIL.COM', '098.44.1344.429268',
           '20-SEP-22', 'SA_MAN', '14000', '0.8', '100',
           '80');
END;

--3.2) 

CREATE OR REPLACE TRIGGER salary_min_max BEFORE
    INSERT OR UPDATE ON jobs
    FOR EACH ROW
DECLARE BEGIN
    IF :new.min_salary >= :new.max_salary THEN
        raise_application_error(-20000, 'Min lon hon max!!!!');
    END IF;
END;

--TEST 3.2

INSERT INTO jobs VALUES (
    'An1',
    'TEST',
    37000,
    1000
);

UPDATE jobs
SET
    max_salary = 2000
WHERE
    job_id = 'PU_MAN';

--3.3) 

CREATE OR REPLACE TRIGGER date_job_history
BEFORE INSERT OR UPDATE 
    ON job_history
    FOR EACH ROW
DECLARE
BEGIN 
    IF :new.start_date > :new.end_date
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: ngay bat dau > ngay kthuc !!');
    END IF;
END;

--TEST 3.3
INSERT INTO job_history VALUES (
    105,
    current_date,
    TO_DATE('03/07/2001', 'DD/MM/YYYY'),
    'MK_REP',
    70
);

UPDATE job_history
SET
    start_date = current_date
WHERE
    employee_id = 102;

--3.4) 

CREATE OR REPLACE TRIGGER salary_and_commission_employee BEFORE
    UPDATE ON employees
    FOR EACH ROW
DECLARE BEGIN
    IF ( :new.salary < :old.salary ) OR ( :new.commission_pct < :old.commission_pct ) THEN
        raise_application_error(-20000, 'ERROR:Luong va hoa hong giam !!!');
    END IF;
END;
