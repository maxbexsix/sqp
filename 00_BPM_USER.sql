DECLARE 
  lResult VARCHAR2(2000);

  PROCEDURE sp_CreateTS(
    pTAB_NAME IN VARCHAR2,
    pINITIAL  IN INT,
    pNEXT     IN INT,
    pResult   OUT VARCHAR2
  ) IS
    lCnt        NUMBER;
    lPath       VARCHAR2(255);
    lSQL        VARCHAR2(2000);
    lParameters VARCHAR2(2000);
  BEGIN
    lParameters := 'SIZE ' || TO_CHAR(pInitial) || ' M  AUTOEXTEND ON NEXT ' || TO_CHAR(pNext) || ' M  extent management LOCAL autoallocate ';
    SELECT CONCAT(SUBSTR(file_name,
                         1,
                         INSTR(file_name,DECODE(INSTR(file_name, CHR(92)), 0, CHR(47), CHR(92)), -1, 1)),
                  LOWER(pTAB_NAME) || '.dbf')
      INTO lPath
      FROM DBA_DATA_FILES
     WHERE tablespace_name = 'SYSTEM';

    SELECT COUNT(*)
      INTO lCnt
      FROM (SELECT tablespace_name
              FROM dba_data_files
             UNION ALL
            SELECT tablespace_name 
              FROM dba_temp_files)
     WHERE tablespace_name = upper(pTAB_NAME);

    lSQL := ' CREATE TABLESPACE ' || pTAB_NAME || ' DATAFILE ''' || lPath || ''' ' || lParameters;
    IF (lCnt = 0) THEN
      EXECUTE IMMEDIATE lSQL;
    
      dbms_output.put_line(' Tablespace created. ');
      pResult := ' Tablespace created. ' || lSQL;
    ELSE
      dbms_output.put_line(' Tablespace IS present. ');
      pResult := ' Tablespace IS present. ' || lSQL;
    END IF;

  END sp_CreateTS;
begin
  sp_CreateTS('TS_BPM_TAB', 10, 10, lResult);
END;
/

DECLARE
 lID  PLS_INTEGER;
BEGIN
  BEGIN
    SELECT user_id
      INTO lID
      FROM all_users
     WHERE UPPER(username) = 'BPM';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXECUTE IMMEDIATE
        'CREATE USER BPM IDENTIFIED BY BPM
		  DEFAULT TABLESPACE TS_BPM_TAB
		  TEMPORARY TABLESPACE TEMP';
  END;
  EXECUTE IMMEDIATE 'GRANT CONNECT TO BPM';
  EXECUTE IMMEDIATE 'GRANT RESOURCE TO BPM';
  EXECUTE IMMEDIATE 'ALTER USER BPM DEFAULT ROLE ALL';
  EXECUTE IMMEDIATE 'ALTER USER BPM QUOTA UNLIMITED ON TS_BPM_TAB';
END;
/
exit
/