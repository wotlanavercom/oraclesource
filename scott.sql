--scott

--select : 데이터 조회

--emp(employee) 테이블 구성 보기
--   필드명(열이름)       제약조건       데이터타입
--  EMPNO(사원번호)      NOT NULL      NUMBER(4)
--  ENAME(사원명), JOB(직책), MGR(직속상관 번호), HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능
-- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2) : 전체 자릿수는 8 자리이고 소수점 2자리를 포함한다
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장 가능
-- DATE : 날짜 데이터
DESC emp;

--DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC dept;

--GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
DESC salgrade;

--select : 데이터 조회  !!!중요!!!가장 많이 사용!!!
--조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두개 이상의 테이블을 사용하여 조회)
--SELECT 열이름1,열이름2... EMP;(조회할 열이 전체라면 *로 처리)
--FROM 테이블명;

--1.EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2.EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

--3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;
--4. DEPT 테이블안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
--5. EMP 테이블안에 부서번호
SELECT
    deptno
FROM
    emp;
--6. EMP 테이블안에서 부서번호 조회(단, 중복된 부서 번호는 제거)
SELECT DISTINCT
    deptno
FROM
    emp;
 
 --열이 여러 개인 경우 (묶어서 중복이냐 아니냐를 판단)   
SELECT DISTINCT
    job,
    deptno
FROM
    emp;    

--7. 연산
--별칭 : 필드에 별칭을 임의로 부여 ( AS 별칭, 혹은 한칸 띄고 별칭, 별칭에 공간이 있다면 ""로 묶어주기)
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;
    
--8. 정렬 : ORDER BY
--         내림차순 => DESC, 오름차순 => ASC

--ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;
--ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal;   --ASC는 생략이 가능  

--전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno;
    
--전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여의 내림차순으로 정렬 
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;
    
--[실습] EMP 테이블의 모든 열 출력
--EMPNO => EMPLOYEE_NO
--ENAME => EMPLOYEE_NAME
--MGR => MANAGER
--SAL => SALARY
--COMM => COMMISSION
--DEPTNO => DEPARTMENT_NO
--부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면
--사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  employee_no,
    ename  employee_name,
    mgr    manager,
    sal    salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename;
    
--WHERE : 특정 조건을 기준으로 원하는 행을 조회

--부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30;  -- = : 같다

--사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
--부서번호가 30이고, 사원직책이 SALESMAN인 행 조회
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';
    
--사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;
    
--부서번호가 30이거나, 사원직책이 CLERK 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';
    
    
--산술연산자 : +, -, *, /, MOD(나머지 - 표준은 아님(오라클에서만 제공))
--비교연산자 : >, >=, <, <=
--등가비교연산자 : =, !=, <>, ^= (!=, <>, ^= : A값과 B값이 다를 경우 TRUE, 같을 경우 FALSE)
--논리부정연산자 : NOT
--IN 연산자
--BETWEEN A AND B 연산자
--LIKE연산자와 와일드 카드(_, %)
--IS NULL 연산자
--집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

--연산자 우선순위
--1)산술연산자 *, /
--2)산술연산자 +, -
--3)비교연산자
--4)IS NULL, IS NOT NULL, LIKE ,IN
--5)BETWEEN A AND B
--6)NOT
--7)AND
--8)OR
--우선순위를 줘야 한다면 소괄호 사용 추천



--EMP 테이블에서 급여 열에 12를 곱한값이 36000 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;
    
--ENAME 이 F 이후의 문자로 시작하는 사원 조회
--문자 표현시 ''만 사용
SELECT
    *
FROM
    emp
WHERE
    ename <= 'F';

--JOB이 MANAGER, SALESMAN, CLERK사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';
    
--SAL이 3000이 아닌 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;

SELECT
    *
FROM
    emp
WHERE
    sal <> 3000;

SELECT
    *
FROM
    emp
WHERE
    sal^= 3000; 

--JOB이 MANAGER, SALESMAN, CLERK사원 조회 ==>IN 연산자
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
--JOB이 MANAGER, SALESMAN, CLERK 아닌 사원 조회 
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';

SELECT
    *
FROM
    emp
WHERE
    NOT sal = 3000;

SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
--부서번호가 10,20 사원조회(IN 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );
    
--급여가 2000 이상 3000이하인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;
--BETWEEN 최소값 AND 최대값;
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;
--급여가 2000이상 3000이하가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;
    
--LIKE 연산자와 와일드 카드(_, %)
-- _ : 어떤값이든 상관없이 한 개의 문자 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

--사원 이름이 S 로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%'; 
--사원 이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%';    -- '_'언더바 한개가 문자 하나
--사원 이름에 AM이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%';
--사원 이름에 AM이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%';
    
--NULL : 데이터 값이 완전히 비어 있는 상태
--
--COMM 이 NULL인 사원
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;
--MGR 이 NULL인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;
--MGR 이 NULL이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;

SELECT
    empno,
    sal,
    comm,
    ename,
    job,
    sal * 12 + comm annsal
FROM
    emp;
    
--집합연산자
--UNION(동일한 결과값인 경우 중복 제거), UNION ALL(중복 제거 안함) : 합집합
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
--    
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
--MINUS(차집합)
SELECT
    empno,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
--INTERSECT(교집합)
SELECT
    empno,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
--EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';
--EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의
--사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;
--EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원 조최
--사원번호, 이름 ,급여, 부서번호 조회
--집합 연산자를 사용하는 방식과 사용하지 않는 방식 두가지를 사용한다
--집합 연산자를 사용하지 않는 방식
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;
--집합 연산자를 사용하는 방식    
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
--집합 연산자를 사용하는 방식
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;
--사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름
--사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 1000 AND 2000;
--추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원 이름의 
--두번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';
    

--오라클 함수
--오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

--1.문자열 함수
--1).UPPER, LOWER, INITCAP
--UPPER : 모두 대문자, LOWER : 모두 소문자, INITCAP : 첫 글자만 대문자
--LIKE '%ORACLE%' OR LIKE '%oracle%' OR LIKE '%Oracle%' ==>검색 시 사용
SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';

SELECT
    *
FROM
    emp
WHERE
    upper(ename) LIKE upper('%ford%');
    
--2)LENGTH : 문자열 길이
SELECT
    ename,
    length(ename)
FROM
    emp;

--사원 이름의 길이가 5이상인 사원 조회
SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;
    
--한글일 때
--DUAL : SYS가 소유하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
--length, LENGTHB(문자가 실제사용하는 바이트)
--영어 : 문자1 => 1BYTE,  한글 : 문자1 => 3BYTE
SELECT
    length('한글'),
    lengthb('한글'),
    lengthb('AB')
FROM
    dual;
    
--3)SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략 가능
--  문자열 일부 추출

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5),
    substr(job, - 3)
FROM
    emp;
    
--ENAME, 세번째 글자부터 출력
SELECT
    ename,
    substr(ename, 3)
FROM
    emp;
    
--3)INSTR : 문자열 데이터안에서 특정ㅇ 문자 위치 찾기
--INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 문자가 몇번째인지 지정(선택))

--HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT
    instr('HELLO, ORACLE!', 'L')       AS instr_1,
    instr('HELLO, ORACLE!', 'L', 5)    AS instr_2,
    instr('HELLO, ORACLE!', 'L', 2, 2) AS instr_3
FROM
    dual;
    
--4)REPLACE : 특정 문자를 다른 문자로 변경
--REPLACE(문자열데이터, 찾는문자, 변경문자)

--010-1234-5678  - 를 빈 문자열로 변경 / -를 없애기
SELECT
    '010-1234-5678'                    AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace_1,
    replace('010-1234-5678', '_')      AS replace_2
FROM
    dual;

--'이것이 Oracle 이다', '이것이' => This is 변경
SELECT
    '이것이 Oracle 이다'                             AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is ') AS replace_1
FROM
    dual;
    
--5)CONCAT :무조건 두 문자열 데이터 합치기
SELECT
    concat(empno, ename)
FROM
    emp;

SELECT
    concat(empno,
           concat(':', ename))
FROM
    emp;
    
-- || : 문자열 연결 연산자
SELECT
    empno || ename,
    empno
    || ':'
    || ename
FROM
    emp;
    
--6) TRIM, LTRIM, RTRIM : 공백포함 특정 문자 제거
-- ' ORACLE' = 'ORACLE' =>FALSE
SELECT
    '     이것이     ',
    TRIM('   이것이       ')
FROM
    emp;


--2.숫자함수
--1)ROUND, TRUNC, CEIL, FLOOR, MOD

--ROUND : 반올림
--ROUND(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,            --소수점 첫째 자리에서 반올림
    round(1234.5678, 0)   AS round0,           --소수점 첫째 자리에서 반올림
    round(1234.5678, 1)   AS round1,           --소수점 둘째 자리에서 반올림
    round(1234.5678, 2)   AS round2,           --소수점 세번째 자리에서 반올림
    round(1234.5678, - 1) AS round_minus1,     --자연수 첫째 자리에서 반올림
    round(1234.5678, - 2) AS round_minus2      --자연수 둘째 자리에서 반올림
FROM
    dual;
    
--TRUNC : 특정 위치에서 버리는 함수
--TRUNC(숫자,버림 위치(선택))
SELECT
    trunc(1234.5678)      AS trunc,            --소수점 첫째 자리에서 버림
    trunc(1234.5678, 0)   AS trunc0,           --소수점 첫째 자리에서 버림
    trunc(1234.5678, 1)   AS trunc1,           --소수점 둘째 자리에서 버림
    trunc(1234.5678, 2)   AS trunc2,           --소수점 세번째 자리에서 버림
    trunc(1234.5678, - 1) AS trunc_minus1,     --자연수 첫째 자리에서 버림
    trunc(1234.5678, - 2) AS trunc_minus2      --자연수 둘째 자리에서 버림
FROM
    dual;
    
--CEIL(숫자), FLOOR(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수

SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;

--MOD(숫자, 나눌수) : 나머지값
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;
    
--날짜 함수
--날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
--날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이

--날짜 데이터 + 날짜 데이터 : 연산불가

--1)SYSDATE 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
--ADD_MONTHS(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기   
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;
    
--입사 50주년이 되는 날짜 구하기
--EMPNO, ENAME, HIREDATE, 입사50주년 날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;

--3)MONTHS_BETWEEN(첫번째 날짜, 두번째 날짜) : 두 날짜 데이터 간의 날짜 차이를 개월수로 계산하여 출력    
--입사가 45년 미만인 사원 데이터 조회
--EMPNO, ENAME, HIREDATE
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;
    
--현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
--4)NEXT_DAY(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출려
--  LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

--날짜의 반올림, 버림 : ROUND, TRUNC
--CC : 네 자리 연도의 끝 두자리를 기준으로 사용
--     2023 년인 경우 2050 이하이므로 2001년으로 처리
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;
    
--형변환 함수 : 자료형을 형 변환
--NUMBER, VARCHAR2, DATE
SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'ABCD' + empno
FROM
    emp
WHERE
    ename = 'FORD';
--ORA-01722: 수치가 부적합합니다
--01722. 00000 -  "invalid number"


--TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
--TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
--TO_DATE() : 문자 데이터를 날짜 데이터로 변환

--원하는 출력 형태로 날짜 출력하기 TO_CHAR 주로 사용됨
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;
--MOM,MONTH : 월 이름
--DDD : 365일 중에서 며칠
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')    AS 현재날짜시간,
    to_char(sysdate, 'YYYY')          AS 현재연도,
    to_char(sysdate, 'MM')            AS 현재월,
    to_char(sysdate, 'MON')           AS 현재월1,
    to_char(sysdate, 'DD')            AS 현재일자,
    to_char(sysdate, 'DDD')           AS 현재일자1,
    to_char(sysdate, 'HH24:MI:SS AM') AS 현재날짜시간
FROM
    dual;

--SAL 필드에 ',' 나 '통화표시'를 하고 싶다면?
--L(LOCALE) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;

-- TO_NUMBER(문자열데이터, 인식될 숫자형태)

--자동형변화
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;
--자동형변환안되는 상황
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;
    
--TO_DATE(문자열 데이터, '인식된 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20230320', 'YYYY-MM-DD')   AS todate2
FROM
    dual;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;
    
--널처리 함수
--NULL + 300 => NULL

--NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;
    
--NVL2(데이터, 널이 아닐겨우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
--DECODE함수 / CASE 문
--DECODE(검사 대상이 될 데이터,
--       조건1, 조건1이 일치할때 실행할 구문
--       조건2, 조건2이 일치할때 실행할 구문)

--EMP 테이블에 직책이 MANAGER 인 사람은 급여의 10% 인상,
--SALESMAN 인 사람은 5%, ANALYST 인 사람은 그대로, 나머지는 3% 인상된 급여 출력

SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;

--실습
SELECT
    empno,
    ename                     sal,
    trunc(sal / 21.5)         AS day_pay,
    round(sal / 21.5 / 8 / 1) time_pay
FROM
    emp;
    
--실습
--SELECT COMM,
--NVL(TO_CHAR(COMM),'N/A')
--FROM EMP;
SELECT
    empno,
    ename,
    hiredate,
    TO_DATE('yyyy - mm - dd') + TO_DATE('YYYY-03-DD') AS r_job,
    comm,
    nv2(to_char(comm),
        'N/A')
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;
    
--실습
SELECT EMPNO, ENAME,MGR,
CASE MGR
WHEN 'KING' THEN
'0000'
WHEN MGR(75%) THEN
'5555'
WHEN MGR(76%) THEN
'6666'
WHEN MGR(77%) THEN
'7777'
WHEN MGR(78%) THEN
'8888'
END FROM emp;

SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),
                  1,
                  2),
           NULL,
           '0000',
           '75',
           '5555',
           '76',
           '6666',
           '77',
           '7777',
           '78',
           '8888',
           substr(to_char(mgr),
                  1)) AS chg_mgr
FROM
emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr), 1, 2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr), 1, 2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr), 1, 2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr), 1, 2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;
        
--다중행 함수 :SUM, CONT, MAX, MIN, AVG

SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;
    
--COMM : NULL 은 제외하고 합계 구해줌
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp;
 --부서번호가 20인 사원의 입사일 중 제일 최근 입사일   
SELECT
    max ( hiredate ) FROM emp WHERE
        deptNO = 20;
 --부서번호가 20인 사원의 입사일 중 제일 오래된 입사일
SELECT
    min ( hiredate ) FROM emp WHERE
        deptno = 20;

SELECT
    AVG(sal)
FROM
    emp;
    
--GROUP BY : 결과값을 원하는 열로 묶어 출력

--부서별 SAL 평균 구하기
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=10;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=20;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=30;
SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;
    
--부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;
--GROUP BY 표현식이 아닙니다.    
--SELECT
--    deptno,
--    AVG(SAL),
--    ENAME
--FROM
--    emp
--GROUP BY
--    deptno;

--GROUP BY + HAVING : GROUP BY 절에 조건을 줄때 
--HAVING : 그룹화된 대상을 출력 제한 걸때

--각서의 직책별 평균 급여 구하기(단, 평균 급여가 2000 이상인 그룹만 출력)
--DEPTNO, JOB, 평균
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;
 
--그룹 함수는 허가되지 않습니다   
--SELECT
--    deptno,
--    job,
--    AVG(sal)
--FROM
--    emp
--WHERE
--    AVG(sal) >= 2000
--GROUP BY
--    deptno,
--    job
--
--ORDER BY
--    deptno,
--    job;


--SELECT 실행순서
--1)FROM 구문 실행 2)WHERE 실행 3)GROUP BY 4)HAVING 5)SELECT 6)ORDER BY

SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

--실습
SELECT
    deptno,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
    emp
GROUP BY
    deptno;
--실습
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3; 
--실습
SELECT
    to_char(hiredate, 'YYYY') AS hier_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;
    
    
--조인 : 여러 테이블을 하나의 테이블처럼 사용
--1)내부조인(inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--   ①등가조인 : 두 개의 열이 일치할 때 값 추출
--   ②비등가조인 : 범위에 해당할 때 값 추출
--2)외부조인(outer join)
--   ①left outer join
--   ②right outer join
--   ③full outer join

--DEPT : 4행, EMP : 12행 ==>4*12=48행
--크로스 조인(나올 수 있는 모든 조합 추출)
SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;

--ORA-00918: 열의 정의가 애매합니다(column ambiguously defined)  -중복된 칼럼이 있을때 이런 오류가남
--각테이블을 명확하게 구분 한다. - E.EMPNO/D.DEPTNO 
--inner join
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno;
--SQL-99 표준
--JOIN ~ ON
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno;

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal >= 3000;
--SQL-99 표준
--JOIN ~ ON
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    sal >= 3000;
    
--EMP, DEPT INNER JOIN, 급여가 2500 이하이고, 사원번호가 9999 이하인 사원 정보 조회
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal >= 2500
        AND e.empno <= 9999;
--SQL-99 표준
--JOIN ~ ON       
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e JOIN
    dept d
ON
        e.deptno = d.deptno
    WHERE e.sal >= 2500
        AND e.empno <= 9999;
        
--EMP와 SALGRADE 조인
--EMP 테이블의 SAL 이 SALGRADE 테이블의 LOSAL 과 HISAL 범위에 들어가는 형태로 조인
SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;
--SQL-99 표준
--JOIN ~ ON    
SELECT
    *
FROM
    emp      e JOIN
    salgrade s
ON
    e.sal BETWEEN s.losal AND s.hisal;
    
--SELF JOIN : 자기 자신 테이블과 조인

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;

--OUTER JOIN
--1)LEFT OUTER JOIN
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,  --LEFT
    emp e2   --right
WHERE
    e1.mgr = e2.empno (+);
--SQL-99 표준
--JOIN ~ ON
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 LEFT OUTER JOIN  
    emp e2 
ON
    e1.mgr = e2.empno;
    
--2)RIGHT OUTER JOIN
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,  --LEFT
    emp e2   --right
WHERE
    e1.mgr (+) = e2.empno;
--SQL-99 표준
--JOIN ~ ON    
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 right OUTER JOIN
    emp e2   
ON
    e1.mgr = e2.empno;
--SQL-99 표준
--JOIN ~ ON
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 FULL OUTER JOIN
    emp e2   
ON
    e1.mgr =
e2.empno;
--ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다
--01468. 00000 -  "a predicate may reference only one outer-joined table"    
--SELECT
--    e1.empno,
--    e1.ename,
--    e1.mgr,
--    e2.empno AS mgr_empno,
--    e2.ename AS mgr_ename
--FROM
--    emp e1,  --LEFT
--    emp e2   --right
--WHERE
--    e1.mgr(+) = e2.empno(+);


--연결해야 할 테이블이 세개일때
SELECT
    *
FROM
    table1 t1,
    table2 t2,
    table3 t3
WHERE
        t1.empno = t2.empno
    AND t2.deptno = t3.deptno;

SELECT
    *    
FROM
         table1 t1
    JOIN table2 t2 ON t1.empno = t2.empno
    JOIN table3 t3 ON t2.deptno = t3.deptno;

--실습1    
SELECT D.DEPTNO,D.DNAME, E.EMPNO, E.ENAME, E.SAL 
FROM EMP E,DEPT D
WHERE D.DEPTNO = E.DEPTNO AND E.SAL>2000;
--SQL-99 표준
--JOIN ~ ON
SELECT D.DEPTNO,D.DNAME, E.EMPNO, E.ENAME, E.SAL 
FROM EMP E JOIN DEPT D
ON D.DEPTNO = E.DEPTNO WHERE E.SAL>2000;
--실습2
SELECT D.DEPTNO, D.DNAME, TRUNC(AVG(E.SAL)) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME ORDER BY DEPTNO;
--SQL-99 표준
--JOIN ~ ON
SELECT D.DEPTNO, D.DNAME, TRUNC(AVG(E.SAL)) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME ORDER BY DEPTNO;
--실습3
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO(+) ORDER BY DEPTNO;
--SQL-99 표준
--JOIN ~ ON
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.JOB, E.SAL
FROM EMP E JOIN DEPT D
ON D.DEPTNO = E.DEPTNO(+) ORDER BY DEPTNO;
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.JOB, E.SAL
FROM DEPT D left outer
JOIN emp e ON d.deptno = e.deptno ORDER BY
deptno;

--서브쿼리
--SQL 문을 실행하는데 필요한 데이터를 추가로 조회하기 위해 SQL 문 내부에서 사용하는 SELECT문
--1)단일행 서브쿼리 2)다중행 서브쿼리 3)다중열 서브쿼리

--SELECT 조회할 열
--FROM 테이블명
--WHERE조건식(SELECT 조회할 열 FROM 테이블 WHERE 조건식)

--존스의 급여보다 높은 급여를 받는 사원 조회
--JONES 급여 알아내기 / 알아낸 JONES 급여를 가지고 조건식

SELECT
    sal
FROM
    emp
WHERE
    ename = 'JONES';   --2975

--단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 반환
-- =, >, <, >=, <=, <>, ^=, != 연산자 허용

--존스의 급여보다 높은 급여를 받는 사원 조회(서브쿼리)
SELECT
    *
FROM
    emp
WHERE
    sal > 2975;

SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            sal
        FROM
            emp
        WHERE
            ename = 'JONES'
    );
    
--사원이름이 ALLEN 인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm > (
        SELECT
            comm
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );
    
--사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT
    *
FROM
    emp
WHERE
    hiredate < (
        SELECT
            hiredate
        FROM
            emp
        WHERE
            ename = 'WARD'
    );
    
--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및
--부서정보 조회
--사원번호, 사원명, 직무, 급여, 부서번호, 지역
SELECT E.EMPNO,E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20 AND E.SAL > (SELECT AVG(SAL) FROM EMP );
--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및
--부서정보 조회
SELECT E.EMPNO,E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20 AND E.SAL <= (SELECT AVG(SAL) FROM EMP );


--다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
--IN, ANY(SOME), ALL, EXISTS 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

--각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회
SELECT deptno, MAX(SAL) FROM EMP GROUP BY DEPTNO;

--ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--IN : 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE
SELECT * FROM EMP WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나 이상이면 TRUE
--30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회
SELECT * FROM EMP WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP WHERE SAL < SOME (SELECT SAL FROM EMP WHERE DEPTNO = 30);

--위 결과는 단일행 쿼리로 작성이 가능한 상황임   
SELECT * FROM EMP WHERE SAL < (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회
--①단일행 서브쿼리
SELECT * FROM EMP WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);
--②다중행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

--ALL : 서브쿼리 모든 결과가 조건식에 맞아 떨어져야만 메인 쿼리 조건식이 TURE
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

--EXISTS : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );

SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 50
    );

--실습                     X
SELECT e.job, e.empno, e.ename, e.sal, d.deptno, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno  
AND e.job = (SELECT job FROM emp WHERE ename = 'ALLEN');
        
--실습
SELECT
    e.empno,
    e.ename,
    d.dname,
    e.hiredate,
    d.loc,
    e.sal,
    s.grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal
        AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    e.sal DESC,
    e.empno ASC;

--다중열 서브쿼리 : 서브쿼리의 SELECT 절에 비교할 데이터를 여러 개 지정
SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

--FROM 절에 사용하는 서브쿼리(인라인 뷰)
--FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;
    
--SELECT 절에 사용하는 서브쿼리 (스칼라 서브쿼리)
--SELECT 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;

--실습
SELECT
    e.empno,
    e.ename,
    e.job,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    )
        AND e.deptno = 10;

--실습
SELECT
    e.empno,
    e.ename,
    e.sal,
    s.grade
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grad
FROM
    emp e
WHERE
    e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;
    
--DML(Date Manipulation Language) : 데이터 추가(INSERT), 수정(PUDATE), 삭제(DELETE)하는 데이터 조작어
--COMMIT : DML 작업을 데이터 베이스에 최종 반영
--ROLLBACK : DML 작업을 취소
--SELECT + DML ==> 자주 사용하는 sql 임

--연습용 테이블 생성
CREATE TABLE dept_temp AS SELECT * FROM dept;

DROP TABLE dept_temp; --제거

--열이름은 선택사항임
--insert into 테이블이름(열이름1,열이름2.....)
--values(데이터1, 데이터2.....);

--dept_temp 새로운 부서 추가하기
INSERT INTO dept_temp(deptno,dname, loc)   --(deptno,dname, loc) : 열이름
VALUES(50,'DATABASE','SEOUL');

SELECT * FROM dept_temp;

--열 이름 제거할 때
INSERT INTO dept_temp
VALUES(60,'NETWORK','BUSAN');

--INSERT 시 오류

--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--INSERT INTO dept_temp
--VALUES(600,'NETWORK','BUSAN');

--수치가 부적합합니다
--INSERT INTO dept_temp
--VALUES('NO','NETWORK','BUSAN');

--값의 수가 충분하지 않습니다
--INSERT INTO dept_temp(deptno,dname, loc)   
--VALUES(70,'DATABASE');

--NULL 삽입
INSERT INTO dept_temp(deptno,dname, loc)   
VALUES(80,'WEB','NULL');

INSERT INTO dept_temp(deptno,dname, loc)  
VALUES(70,'MOBILE','');

--NULL 삽입할 컬럼명 지정하지 않았음
--삽입시 전체 컬럼을 삽입하지 않는다면 필드명 필수
INSERT INTO dept_temp(deptno,loc)   
VALUES(91,'INCHON');

SELECT * FROM dept_temp;

-- emp_temp 생성(emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1 <> 1;

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(9999,'홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(1111,'성춘향', 'MANAGER', 9999, '2002-01-05', 4000, NULL, 20);

--날짜 입력 시 년/월/일 순서 => 일/월/년 삽입
--날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(2222,'이순신', 'MANAGER', 9999, TO_DATE('07-01-2001','DD/MM/YYYY'), 4000, NULL, 20);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(3333,'심봉사', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

--서브쿼리로 INSERT 구현
--emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp 에 추가

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno 
FROM emp e, salgrade s 
WHERE e.sal BETWEEN s.losal AND s.hisal AND s.grade =1;

SELECT * FROM emp_temp;


COMMIT;



--UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--SET 변경할열이름 = 데이터, 변경할열이름 = 데이터.....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

SELECT * FROM dept_temp;

--dept_temp loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL';

ROLLBACK;

--데이터 일부분 수정 : WHERE 사용
--dept_temp 부서번호가 40번인 loc 열의 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL'
WHERE deptno = 40;

--dept_temp 부서번호가 80번인 dname 은 SALES, LOC 는 CHICAGO
UPDATE dept_temp
SET dname = 'SALES', loc = 'CHICAGO'
WHERE deptno = 80;

SELECT * FROM dept_temp;

--emp_temp 사원들 중에서 급여가 2500이하인 사원만 추가수당을 50으로 수정
UPDATE emp_temp
SET COMM = 50
WHERE sal <= 2500;

--서브쿼리를 사용하여 데이터 수정
--dept 테이블에 40번 부서의 dname, loc 를 dept_temp 40번 부서의 dname,loc로 업데이트
UPDATE dept_temp
SET (dname,loc) = (SELECT dname, loc
                    FROM dept
                    WHERE deptno = 40)
WHERE deptno = 40;

COMMIT;

--DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM  (선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE emp_temp2 AS SELECT * FROM emp;

-- job 이 MANAGER 인 사원 삭제
DELETE FROM emp_temp2
WHERE job = 'MANAGER';

-- job 이 SALESMAN 인 사원 삭제
DELETE emp_temp2
WHERE job = 'SALESMAN';

--전체삭제
DELETE emp_temp2;

ROLLBACK;

--서브쿼리를 사용하여 삭제
--급여 등급이 3등급이고, 30번부서의 사원 삭제
DELETE FROM emp_temp2
WHERE EMPNO IN (SELECT e.empno
FROM emp_temp2 e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal AND s.grade =3 AND e.deptno = 30);

COMMIT;

SELECT * FROM emp_temp2;

--1
CREATE TABLE EXAM_EMP AS SELECT * FROM emp WHERE 1 <> 1;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

DELETE EXAM_SALGRADE;

SELECT * FROM EXAM_SALGRADE;
--2
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7201,'TEST_USER1', 'MANAGER', 7788, '2016/01/02', 4500, '', 50);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7202,'TEST_USER2', 'CLERK', 7201, '2016/02/21', 1800, '', 50);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7203,'TEST_USER3', 'ANALYST', 7201 '2016/04/11', 3400, '', 60);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7204,'TEST_USER4', 'SALESMAN', 7201, '2016/05/31', 2700, '300', 60);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7205,'TEST_USER5', 'CLERK', 7201, '2016/07/20', 2600, '', 70);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7206,'TEST_USER6', 'CLERK', 7201, '2016/09/08', 2600, '', 70);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7207,'TEST_USER7', 'LECTURER', 7201, '2016/10/28', 2300, '', 80);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7208,'TEST_USER8', 'STUDENT', 7201, '2018/03/09', 1200, '', 80);
--3
UPDATE EXAM_EMP
SET deptno = 70
WHERE sal < (SELECT AVG(sal) FROM EXAM_EMP WHERE deptno = 50);

SELECT * FROM EXAM_EMP;
--4
UPDATE EXAM_EMP
SET sal = sal*1.1, deptno =80   
WHERE hiredate > (SELECT MIN(hiredate) FROM EXAM_EMP WHERE deptno = 60);

--5
DELETE FROM EXAM_EMP
WHERE EMPNO IN (SELECT EXAM_EMP
FROM EXAM_EMP e, salgrade s
WHERE sal BETWEEN losal AND hisal AND grade =5);

SELECT * FROM EXAM_EMP;


COMMIT;

--트랜잭션(teansaction) : 최소 수행 단위
--트랜잭션 제어하는 구문 TCL(Teansaction Control Language) commit, rollback

CREATE TABLE dept_tcl AS SELECT * FROM dept;

INSERT INTO dept_tcl VALUES(50, 'DATABASE', 'SEOUL');

UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno = 40;

DELETE FROM dept_tcl WHERE dname = 'RESEARCH';

SELECT * FROM DEPT_TCL;

--트랜잭션 최종 방영
COMMIT;

--세션 : 어떤 활동을 위한 시간이나 기간
--데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한수 접속 종료
--LOOK : 잠금(수정 중인 데이터 접근 막기)

DELETE FROM dept_tcl WHERE deptno = 50;

UPDATE FROM dept_tcl SET loc = 'SEOUL' WHERE deptno = 30;


--DDL : 데이터 정의어(데이터 베이스 객체 생성, 수정, 삭제)
--1. 테이블 생성
--CREATE TABLE 테이블명(
--    열이름1 자료형,
--    열이름2 자료형,
--    열이름3 자료형,
--    열이름4 자료형
--    );

--테이블 생성 / 열이름 지정 규칙
--1)테이블 이름은 문자로 시작(한글이름은 가능하나 안씀)
--2)테이블 이름은 30BYTE 이하
--3)같은 사용자 요유의 테이블 이름은 중복될 수 없음
--4)테이블 명에 사용할 수 있는 트수문자는 $,#,_ 가능
--5)SQL 키워드(ex SELECT, FROM, WHERE....)는 테이블명에 사용할 수 없음

--자료형
--1. 문자
--VARCHAR2(길이) : 가변 길이 문자열 데이터 저장(최대 4000BYTE)
--CHAR(길이) : 고정 길이 문자열 데이터 저장
--NVARCHAR2(길이) : 가변 길이(unicode) 데이터 저장
--  name varchar2(10) : 영어는 10자, 한글은 3자 까지 입력
--  name nvarchar2(10) : 영어 10자, 한글 10자 까지 입력
-- NCHAR(길이) : 고정 길이 (unicode)
--  name char(10) : 영어는 10자, 한글은 3자, + 메모리 10byte 고정
--  name nchar(10) : 영어는 10자, 한글은 10자, + 메모리 10byte 고정

--2.숫자
--NUMBER(전체 자릿수, 소수점이하 자릿수)

--3.날짜
--DATE : 날짜,시간 저장
--TIMESTAMP

--4. 기타
--BLOB : 대용량 이진 데이터 저장
--CLOB : 대용량 텍스트 데이터 저장
--JSON : JSON 데이터 저장

CREATE TABLE emp_ddl(
    empno number(4),    --사번을 총 4자리로 지정
    ename varchar2(10), --사원명을 총 10byte 로 지정
    job varchar2(9),    --직무 총 9byte 지정
    mgr number(4),       -- 매니저 번호
    hiredate date,      --날짜/시간 저장
    sal number(7,2),     --급여를 전체 자릿수 7자리 지정(소수점 2자리까지만 허용)
    comm number(7,2),    --추가수당
    deptno NUMBER(2)    --부서번호
     );
DESC EMP_DDL;
--2. 테이블 수정 : ALTER
--1) 열 추가
ALTER TABLE emp_temp2 ADD hp VARCHAR2(20);

--2) 열 이름 변경 : RENAME
ALTER TABLE emp_temp2 RENAME COLUMN hp TO tel;

--3) 열 자료형(길이) 변경 : MODIFY
ALTER TABLE emp_temp2 MODIFY
    empno NUMBER(5);

--4)특정 열을 삭제 : DROP
ALTER TABLE emp_temp2 DROP COLUMN tel;

--3. 테이블 삭제 : DROP
DROP TABLE emp_rename;

--테이블 명 삭제
RENAME emp_temp2 TO emp_rename;

--테이블 데이터 전체 삭제
DELETE FROM emp_rename;

SELECT
    *
FROM
    emp_rename;

ROLLBACK;

--ROLLBACK 안됨 : DDL 구문이기 때문
TRUNCATE TABLE emp_rename;

--실습
CREATE TABLE member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation NCHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);
    
--실습
ALTER TABLE member ADD bigo VARCHAR2(20);

ALTER TABLE member MODIFY
    bigo VARCHAR2(30);

ALTER TABLE member RENAME COLUMN bigo TO remark;

DROP TABLE member;

--"SCOTT","MEMBER,"NATION" 열에 대한 값이 너무 큼(실제 : 12, 최대 :4)
INSERT INTO member VALUES (
    'hong1234',
    '홍길동',
    '서울시 구로구 개봉동',
    '대한민국',
    'hong123@naver.com',
    25,
    NULL
);

--데이터 베이스 객체
--테이블, 인덱스, 뷰 ,데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
--생성 : create, 수정 : alter, 삭제 : drop

--인덱스 : 더 빠른 검색을 도와줌
--인덱스 : 사용자가 직접 특정 테이블 열에 지정 가능
--        기본키(혹은 nuique key) 를 생성하면 인덱스로 지정

-- CREATE INDEX 인덱스이름 ON 테이블명(인덱스로 사용할 열이름)

CREATE INDEX idx_emp_sal ON
    emp (
        sal
    );

--select : 검색방식
--FULL Scan
--Index scan

SELECT
    *
FROM
    emp
WHERE
    empno = 7900;

--인덱스 삭제
DROP INDEX idx_emp_sal;

--View : 가상 테이블
--편리성 : SELECT 문의 복잡도를 완화하기 위해
--보안성 : 데이블의 특정 열을 노출하고 싶지 않을 때

--CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름(열이름1, 열이름2....)
--AS (저장할 SELECT 구문)
--[WITH CHECK OPTION]
--[WITH READ ONLY]

--SELECT empno, ename, job, deptno FROM emp WHERE deptno=20 뷰로 생성
CREATE VIEW vm_emp20 AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );

--서브쿼리를 사용
SELECT
    *
FROM
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );

--뷰 사용
SELECT
    *
FROM
    vm_emp20;

--뷰 삭제
DROP VIEW vm_emp20;

--뷰 생성 시 읽기만 가능
CREATE VIEW vm_emp_read AS
    SELECT
        empno,
        ename,
        job
    FROM
        emp
WITH READ ONLY;

--VIEW 에 INSERT 작업?
INSERT INTO vm_emp20 VALUES (
    8888,
    'KIM',
    'SALES',
    20
);
--원본 변경이 일어남
SELECT
    *
FROM
    emp;

--읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO vm_emp_read VALUES (
    9999,
    'KIM',
    'SALES'
);

--인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
--rownum : 조회된 순서대로 일련번호 매김

SELECT
    ROWNUM,
    e.*
FROM
    emp e;

SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e;
--급여 높은 상위 세 사람 조회
SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e
WHERE
    ROWNUM <= 3;

--시퀀스 : 규칙에 따라 순번 생성
--CREATE SEQUENCE 시퀀스이름;(설정안하는 것들은 다 기본값으로 세팅)
--
--CREATE SEQUENCE 시퀀스명
--[INCREMENT BY 숫자]  기본값 1
--[start with 숫자]    기본값 1
--[maxvalue 숫자 | nomaxvalue]
--[minvalue 숫자 | nominvalue]
--[cycle | nocycle]   cycle 인 경우 maxvalue에 값이 다다르면 시작값부터 다시 시작
--[cache 숫자 | nocache]    시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음(기본 cache 20)

CREATE TABLE dept_sequence
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0 NOCYCLE CACHE 2;

--시퀀스 사용 : 시퀀스 이름.CURRVAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

--부서번호 입력시 시퀀스 사용
INSERT INTO dept_seqUence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_seqUence.NEXTVAL,
    'database',
    'seoul'
);

SELECT
    *
FROM
    dept_sequence;

--최대값 90 까지 가능
--시퀀스 SEQ_DEPT_SEQUENCE.NEXTVAL exceeds MAXVALUE : NOCYCLE 옵션으로 생성했기 때문에 번호가 순환되지 않음

--시퀀스 삭제
DROP SEQUENCE seq_dept_seqence;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 3 START WITH 10 MAXVALUE 99 MINVALUE 0 NOCYCLE CACHE 2;
--CREATE SEQUENCE seq_dept_sequence : 1씩만 증가 할때

SELECT seq_dept_sequence.CURRVAL
FROM dual;

--synonym(동의어) : 데이블, 뷰 , 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체

--EMP 테이블의 별칭을 E로 지정
CREATE SYNONYM E FOR EMp;

--PUBLIC : 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정
--CREATE [PUBLIC] SYNONYM E FOR EMO;

SELECT * FROM emp;
SELECT * FROM E;

DROP SYNONYM E;

--실습 ① EMP테이블과 같은 구조의 데이터를 저장하는 EMPIDX 테이블을 생성하시오.
CREATE TABLE EMPIDX AS SELECT * FROM EMP;
--실습 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 생성하시오
CREATE INDEX idx_EMPIDX_EMPNO ON
    EMPIDX (
        EMPNO
    );
--데이터 사전 뷰를 통해 인덱스 확인
SELECT * FROM USER_INDEXES;
--실습  실습1에서 생성한 EMPIDX 테이블의 데이터 중 급여가 1500 초과인 사원들만 출력하는 EMPIDX_OVER15K 뷰를 생성하시오. 
--(사원번호, 사원이름, 직책,부서번호,급여,추가수당 열을 가지고 있다)
CREATE VIEW EMPIDX_OVER115K AS (SELECT empno, ename, job, deptno, sal, comm FROM EMPIDX WHERE sal>1500);
--실습
CREATE TABLE DEPTSEQ AS SELECT * FROM DEPT;
--실습
CREATE SEQUENCE seq_dept
START WITH 1 INCREMENT BY 1 MAXVALUE 99 MINVALUE 1 NOCYCLE  NOCACHE;

--데이터 사전 뷰를 통해 시퉌스 확인
SELECT * FROM USER_SEQUENCES;


--제약조건 : 테이블의 특정 열에 지정
--          NULL 허용 / 불허용, 유일한 값, 조건식을 만족하는 데이터만 입력 가능....
--          데이터 무결성(데이터 정확성, 일관성 보장) 유지 ==>DML 작업시 지켜야함
--          영역 무결성, 개체 무결성, 참조 무결성
--          테이블 생성 시 제약조건 지정, OR 생성 후에 ALRER 를 통해 추가, 변경 가능


--1)NOT NULL : 빈값 허용 불가
--사용자로부터 입력값이 필수로 입렵되어야 할 때
CREATE TABLE TABLE_NOTNULL(
    LOGIN_ID VARCHAR2(20) NOT NULL,
    LOGIN_PWD VARCHAR2(20) NOT NULL,
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD) VALUES('hong123','hong123');
--NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
--INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD,TEL) VALUES('hong123',NULL,'010-1234-1234');

SELECT * FROM TABLE_NOTNULL;

--전체 제약조건 조회
SELECT * FROM user_constraints;

--제약조건 + 제약조건 명 지정
CREATE TABLE TABLE_NOTNULL2(
    LOGIN_ID VARCHAR2(20) constraint tblnn2_login_nn NOT NULL,
    LOGIN_PWD VARCHAR2(20) constraint tblnn2_lgpwd_nn NOT NULL,
    TEL VARCHAR2(20)
);

--생성한 테이블에 제약조건 추가
--(SCOTT.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
--이미 삽입된 데이터로 체크 대상이 되기 됨
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL constraint tblnn2_tel_nn NOT NULL);

UPDATE TABLE_NOTNULL
SET TEL = '010-1234-5678'
WHERE LOGIN_ID = 'hong123';

--제약조건 명 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBLNN3_TEL_NN;

--제약조건 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN3_TEL_NN;

--2) UNIQUE : 중복되지 않는 값(NULL 삽입 가능)
--            아이디, 전화번호

CREATE TABLE TABLE_UNIQUE1(
    LOGIN_ID VARCHAR2(20) UNIQUE,
    LOGIN_PWD VARCHAR2(20) NOT NULL,
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_UNIQUE1(LOGIN_ID, LOGIN_PWD,TEL) VALUES('hong123','hong123','010-1234-1234');

--LOGIN_ID 가 중복된 상황일 때 : UNIQUE 위배
--무결성 제약 조건(SCOTT.SYS_C008364)에 위배됩니다.

INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD,TEL) VALUES(NULL,'hong123','010-1234-1234');

SELECT * FROM table_unique;

--테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함

--3)PRIMARY KEY(PK) : UNIQUE + NOT NULL

CREATE TABLE TABLE_PRIMARY(
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) NOT NULL,
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_PRIMARY(LOGIN_ID, LOGIN_PWD,TEL) 
VALUES('hong123','hong123','010-1234-1234');

--PRIMARY KEY ==> INDEX 자동 생성

--NULL을 ("SCOTT"."TABLE_PRIMARY"."LOGIN_ID") 안에 삽입할 수 없습니다
INSERT INTO TABLE_PRIMARY(LOGIN_ID, LOGIN_PWD,TEL) 
VALUES(NULL,'hong123','010-1234-1234');

--무결성 제약 조건(SCOTT.SYS_C008366)에 위배됩니다
INSERT INTO TABLE_PRIMARY(LOGIN_ID, LOGIN_PWD,TEL) 
VALUES('hong123','hong123','010-1234-1234');

--4)외래키 : Foreign key(FK) : 다른 테이블 간 관계를 정의 하는데 사용
--          특정 테이블에서 primart key 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

--사원 추가 시 부서 번호 입력을 해야 함 => dept 테이블의 deptno 만 삽입

CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

--자식 테이블
-- REFERENCES 참조할 테이블명(참조할 열) : 외래키 지정   
CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO));

--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES(1000,'TEST', 'SALES',10);

--외래키 제약 조건
--부모 테이블 데이터가 데이터 먼저 입력 

--삭제 시 
--자식 테이블 데이터 먼저 삭제
--부모 테이블 데이터 삭제

INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');

--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
--DELETE FROM DEPT_FK WHERE DEPTNO=10;


--외래 키 제약조건 옵션
--ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
--ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식 레코드의 값을 NULL로 변경

CREATE TABLE DEPT_FK2(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK2 PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK2 REFERENCES DEPT_FK2(DEPTNO) ON DELETE CASCADE);

INSERT INTO DEPT_FK2 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK2 VALUES(1000,'TEST', 'SALES',10);

DELETE FROM DEPT_FK2 WHERE DEPTNO=10;

--5) CHECK : 열에 지정할 수 있는 값의 범위 또는 패턴 지정
--비밀번호는 3 자리보다 커야 한다.

CREATE TABLE TABLE_CHECK(
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CHECK ( LENGTH(LOGIN_PWD) > 3),
    TEL VARCHAR2(20)
);
--체크 제약조건(SCOTT.SYS_C008373)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('TEST','123','010-1234-5678');

INSERT INTO TABLE_CHECK VALUES('TEST','1234','010-1234-5678');

--6)DEFAULT : 기본값 지정
CREATE TABLE TABLE_DEFAULT(
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('TEST',NULL,'010-1234-5678');
INSERT INTO TABLE_DEFAULT(LOGIN_ID,TEL) VALUES('TEST1','010-1234-5678');
SELECT * FROM TABLE_DEFAULT;

COMMIT;