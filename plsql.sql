--PL/SQL : SQL 만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라틀에서 제공하는 프로그래밍 언어

--실행 결과를 화면에 출력
SET SERVEROUTPUT ON;

--블로 : DECLARE ~ BEGIN ~ END
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

--변수 선언
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_Empno);
END;
/

--상수선언
DECLARE
    V_TAX CONSTANT NUMBER(4) := 7788;    
BEGIN   
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);    
END;
/

--변수 + DEFAULT(기본값)
DECLARE
    V_TAX NUMBER(4) DEFAULT 10;    
BEGIN   
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);    
END;
/

--변수 + NOT NULL
DECLARE
    V_TAX NUMBER(4) NOT NULL := 10;    
BEGIN   
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);    
END;
/

--변수 + NOT NULL + DEFAULT
DECLARE
    V_TAX NUMBER(4) NOT NULL DEFAULT 10;    
BEGIN   
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);    
END;
/

--변수나 상수의 자료형
--스칼라 : 오라클이 사용하는 타입(NUMBER, CHAR, DATE....)
--참조형 : 오라클 데이터 베이스에 존재하는 특정 테이블의 열의 자료형이나 하나의 행 구조를 참조하는 자료형
--  1)변수이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
--  2)변수이름 테이블명.열이름%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;    
BEGIN   
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);    
END;
/

DECLARE
    --V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE;    
BEGIN 
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
    FROM DEPT
    WHERE DEPTNO = 40;
    
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('V_LOC : ' || V_DEPT_ROW.LOC);
END;
/

--조건문 : IF, IF~THEN~END IF,

DECLARE
    V_NUMBER NUMBER := 15;    
BEGIN
    --V_NUMBER 홀수, 짝수 구별
    --MOD() : 나머지 구하는 오라클 함수
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수');  
    END IF;
END;
/

DECLARE
    V_NUMBER NUMBER := 14;    
BEGIN
    --V_NUMBER 홀수, 짝수 구별
    --MOD() : 나머지 구하는 오라클 함수
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 짝수'); 
    END IF;
END;
/

--학점 출력
DECLARE
    V_NUMBER NUMBER := 87;    
BEGIN    
    IF V_NUMBER >=90 THEN
        DBMS_OUTPUT.PUT_LINE('A 학점'); 
    ELSIF V_NUMBER >=80 THEN
        DBMS_OUTPUT.PUT_LINE('B 학점');
    ELSIF V_NUMBER >=70 THEN
        DBMS_OUTPUT.PUT_LINE('C 학점');
    ELSIF V_NUMBER >=60 THEN
        DBMS_OUTPUT.PUT_LINE('D 학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F 학점'); 
    END IF;
END;
/

DECLARE
    V_NUMBER NUMBER := 87;    
BEGIN  
    CASE TRUNC(V_NUMBER/10)
    WHEN 10 THEN
        DBMS_OUTPUT.PUT_LINE('A 학점'); 
    WHEN 9 THEN
        DBMS_OUTPUT.PUT_LINE('A 학점');
    WHEN 8 THEN
        DBMS_OUTPUT.PUT_LINE('B 학점');
    WHEN 7 THEN
        DBMS_OUTPUT.PUT_LINE('C 학점');
    WHEN 6 THEN
        DBMS_OUTPUT.PUT_LINE('D 학점');
    ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
    END CASE;
END;
/

DECLARE
    V_NUMBER NUMBER := 87;    
BEGIN  
    CASE 
    WHEN V_NUMBER >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A 학점'); 
    WHEN V_NUMBER >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B 학점');
    WHEN V_NUMBER >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C 학점');
    WHEN V_NUMBER >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D 학점');    
    ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
    END CASE;
END;
/

--반복문
--LOOP ~ END LOOP, WHILE LOOP, Cusor FOR LOOP
DECLARE
    V_NUM NUMBER := 0;    
BEGIN  
    LOOP
    DBMS_OUTPUT.PUT_LINE('V_NUM : ' || V_NUM);
    V_NUM := V_NUM+1;
    EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/
--WHILE
DECLARE
    V_NUM NUMBER := 0;    
BEGIN  
    WHILE V_NUM < 4 LOOP
    DBMS_OUTPUT.PUT_LINE('V_NUM : ' || V_NUM);
    V_NUM := V_NUM+1;    
    END LOOP;
END;
/

--FOR i IN 시작값..종료값 LOOP
--반복수행작업;
--END LOOP;
BEGIN  
    FOR i IN 0..4 LOOP
    DBMS_OUTPUT.PUT_LINE('i : ' || i);       
    END LOOP;
END;
/

BEGIN  
    FOR i IN REVERSE 0..4 LOOP
    DBMS_OUTPUT.PUT_LINE('i : ' || i);       
    END LOOP;
END;
/

BEGIN  
    FOR i IN 0..4 LOOP
    CONTINUE WHEN MOD (i,2) =1;
    DBMS_OUTPUT.PUT_LINE('i : ' || i);       
    END LOOP;
END;
/
--1~10까지 홀수만 출력 
BEGIN  
    FOR i IN 1..10 LOOP
    CONTINUE WHEN MOD(i,2) =0;
    DBMS_OUTPUT.PUT_LINE('i : ' || i);       
    END LOOP;
END;
/
BEGIN  
    FOR i IN 1..10 LOOP
        IF i MOD 2 = 1 THEN
            DBMS_OUTPUT.PUT_LINE('i : ' || i);       
        END IF;
    END LOOP;
END;
/

commit;

--커서 : SELECT 문 또는 데이터 조작어 같은 SQL 문을 실행했을 때
--      해당 SQL 문을 처리하는 정보를 저장한 메모리 공간(포인터)

--명시적 커서
--1) 커서 선언 2) 커서 열기 3) 커서에서 얻어온 데이터 사용 4) 커서 닫기
--결과가 단일행 일때
DECLARE
    --V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE; 
    
    --커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
        WHERE DEPTNO = 40;
BEGIN

    --커서 열기
    OPEN c1;
    
    --커서에서 얻어온 데이터 사용
    FETCH c1 INTO V_DEPT_ROW;
    
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('V_LOC : ' || V_DEPT_ROW.LOC);
    
    --커서 닫기
    CLOSE c1;
END;
/
--결과가 여러행 일때
DECLARE
    --V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE; 
    
    --커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT;        
BEGIN

    --커서 열기
    OPEN c1;
    
    LOOP
    --커서에서 얻어온 데이터 사용
        FETCH c1 INTO V_DEPT_ROW;
        
        --루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
        EXIT WHEN c1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('V_DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('V_LOC : ' || V_DEPT_ROW.LOC);
    
    
    END LOOP;
    --커서 닫기
    CLOSE c1;
END;
/

--FOR LOOP + 커서 : OPEN, FETCH, CLOSE 자동
DECLARE       
    --커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT;        
BEGIN 

    FOR c1_rec IN c1 LOOP         
        
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO || 'DNAME : ' || c1_rec.DNAME || 'LOC : ' || c1_rec.LOC);     
    
    END LOOP;

END;
/

--커서 + 파라미터
DECLARE
    --V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE; 
    
    --커서 선언
    CURSOR c1(p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
        WHERE DEPTNO = p_deptno;        
BEGIN

    --커서 열기
    OPEN c1(10);
    
        LOOP
            --커서에서 얻어온 데이터 사용
            FETCH c1 INTO V_DEPT_ROW;
            
            --루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
            EXIT WHEN c1%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('10번 부서 DEPTNO : ' || V_DEPT_ROW.DEPTNO || 'DNAME : ' || V_DEPT_ROW.DNAME || 'LOC : ' || V_DEPT_ROW.LOC);
                
        END LOOP;
        
    --커서 닫기
    CLOSE c1;
    
    --20번 부서
    OPEN c1(20);
    
        LOOP
            --커서에서 얻어온 데이터 사용
            FETCH c1 INTO V_DEPT_ROW;
            
            --루프 탈출 : 커서이름%NOTFOUND => 수행된 FETCH 문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
            EXIT WHEN c1%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('20번 부서 DEPTNO : ' || V_DEPT_ROW.DEPTNO || 'DNAME : ' || V_DEPT_ROW.DNAME || 'LOC : ' || V_DEPT_ROW.LOC);
                
        END LOOP;
        
    --커서 닫기
    CLOSE c1;
END;
/

--커서 + 파라미터 입력받기
DECLARE 
    --사용자가 입력한 부서 번호를 저장하는 변수
    V_DEPTNO DEPT.DEPTNO%TYPE;

    --커서 선언
    CURSOR c1(p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
        WHERE deptno = p_deptno;        
BEGIN 
    --사용자 입력 : &변수
    
    v_deptno := &INPUT_DEPTNO;

    FOR c1_rec IN c1(v_deptno) LOOP         
        
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO || 'DNAME : ' || c1_rec.DNAME || 'LOC : ' || c1_rec.LOC);     
    
    END LOOP;

END;
/

--묵시적 커서 : 별다른 선언 없이 SQL 문 사용
--            여러 행의 결과를 가지는 커서는 명시적 커서로만 사용 함

--SQL%NOTFOUND : 묵시적 커서 안에 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
--               DML 명령어로 영향을 받는 행이 없을 경우에도 TRUE

--SQL%FOUND : 묵시적 커서 안에 추출된 행이 있으면 TRUE, 없으면 FALSE 반환
--            영향을 받는 행이 있다면 TRUE

--SQL%ROWCOUNT : 묵시적 커서에 현재까지 추출한 행 수 또는 DML 명령어로 영향받는 행 수 반환

--SQL%ISOPEN : 묵시적 커서는 자동으로 SQL 문을 실행한 후 CLOSE 되므로 이 속성은 항상 FALSE 반환


BEGIN
    UPDATE dept_temp SET dname = 'DATABASE'
    WHERE deptno = 50;
    
    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
    
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : FALSE');
    END IF;
    
    IF (SQL%ISOPEN) THEN
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : FALSE');
    END IF;
END;
/

--예외 처리
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT dname INTO v_wrong
    FROM DEPT
    WHERE DEPTNO =10;
    
    DBMS_OUTPUT.PUT_LINE('예외 발생시 다음 문장은 실행되지 않음');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/
    
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT dname INTO v_wrong
    FROM DEPT
    WHERE DEPTNO =10;
    
    DBMS_OUTPUT.PUT_LINE('예외 발생시 다음 문장은 실행되지 않음');
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 요구보다 많은 행 추출 오류 발생');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
END;
/

DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT dname INTO v_wrong
    FROM DEPT
    WHERE DEPTNO =10;
    
    DBMS_OUTPUT.PUT_LINE('예외 발생시 다음 문장은 실행되지 않음');
EXCEPTION    
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

--명시적 커서를 사용하여 EMP 테이블의 전체 데이터를 조회한 후 데이터 출력
--FOR LOOP 사용
DECLARE       
    --커서 선언
    CURSOR c1 IS
        SELECT *
        FROM EMP;        
BEGIN 

    FOR c1_rec IN c1 LOOP         
        
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || c1_rec.EMPNO 
                        || 'ENAME : ' || c1_rec.ENAME 
                        || 'JOB : ' || c1_rec.JOB 
                        || 'SAL : ' || c1_rec.SAL
                        || 'DEPTNO : ' || c1_rec.DEPTNO);     
    
    END LOOP;

END;
/

--(저장) 프로시저 : 특정 처리 작업을 수행하는 데 사용(다른 응용 프로그램에서 호출 가능)/(저장해 놨다가 필요할때마다 불러서 실행)

--CREATE [OR REPLACE] PROCEDURE 프로시저명
--IS |AS 선언부
--BEGIN
--    실행부
--EXCEPTION
--    예외부
--END;

--작성 후 컴파일
CREATE OR REPLACE PROCEDURE pro_noparam
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_Empno);
END;
/

--실행
EXECUTE pro_noparam;

--블록 안에서 실행
BEGIN
    pro_noparam;
END;
/

--프로시저 삭제
DROP PROCEDURE pro_noparam;


--파라메터 프로시저
--IN(DEFAULT) : 프로시저 호출 시 값을 입력받음
--OUT : 프로시저 호출할 때 값 반환
--IN OUT : 호출할 때 값을 입력 받은 후 실행 결과 값 반환

CREATE OR REPLACE PROCEDURE pro_param(param1 IN NUMBER, param2 NUMBER, param3 NUMBER :=3,  param4 NUMBER DEFAULT 4)
IS
    
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
    DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
    DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
    DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
/

EXECUTE pro_param(1,2,8,9);

EXECUTE pro_param(1,2);

CREATE OR REPLACE PROCEDURE pro_param_out(in_empno IN EMP.EMPNO%TYPE, out_ename OUT EMP.ENAME%TYPE, out_sal OUT EMP.SAL%TYPE)
IS
   
BEGIN
    SELECT ENAME, SAL INTO out_ename, out_sal
    FROM emp
    WHERE EMPNO = in_empno;
END;
/

DECLARE
    V_ENAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
BEGIN
    pro_param_out(7839, V_ENAME, V_SAL);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_SAL : ' || V_SAL);
END;
/

--트리거 : 데이터베이스 안의 특정 상황이나 동작, 즉 이벤트가 발생할 경우 자동으로 실행되는 기능 정의
--회원테이블에서 회원이 삭제가 되면 해당 회원을 다른 테이블로 이동

--CREATE [OR REPLACE] TRIGGER 트리거이름
--BEFORE | AFTER
--INSERT | UPDATE |DELETE ON 테이블 명
--FOR EACH ROW WHEN 조건식
--ENABLE | DISABLE
--
--DECLARE
--    선언부
--BEGIN
--    실행부
--EXCEPTION
--    예외부
--END;

CREATE TABLE EMP_TRG AS SELECT * FROM EMP;

--EMP_TRG 테이블에 DML 명령어 사용 시 주말일 경우는 DML 명령 실행 취소

CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON emp_trg
BEGIN
    IF TO_CHAR(sysdate, 'DY') IN ('토','일') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '주말 사원정보 추가 불가');
        ELSIF UPDATING THEN
            raise_application_error(-20001, '주말 사원정보 추가 불가');
        ELSIF DELETING THEN
            raise_application_error(-20002, '주말 사원정보 추가 불가');
        ELSE
            raise_application_error(-20003, '주말 사원정보 추가 불가');
        END IF;
    END IF;
END;
/

UPDATE emp_trg SET SAL = 8000 WHERE EMPNO = 7369;
commit;

SELECT *FROM emp_trg_log;

--log 기록 트리거

--로그 기록 테이블
CREATE TABLE emp_trg_log(
    tablename VARCHAR2(10),
    DML_TYPE VARCHAR2(10),
    EMPNO NUMBER(4),
    USER_NAME VARCHAR2(30),
    CHANGE_DATE DATE);


CREATE OR REPLACE TRIGGER trg_emp_log
BEFORE
INSERT OR UPDATE OR DELETE ON emp_log
FOR EACH ROW

BEGIN
    
    IF INSERTING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP1_TRG', 'INSERT', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);
    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log
        VALUES ('EM1P_TRG', 'INSERT', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP1_TRG', 'INSERT', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);               
    END IF;
END;
/






