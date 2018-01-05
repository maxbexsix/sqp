set linesize 255
set pagesize 10000
set tab off

column OWNER         format a8
column OBJECT_NAME   format a32
column OBJECT_TYPE   format a20
column CREATED       format a20

select ao.OWNER,ao.OBJECT_NAME,ao.OBJECT_TYPE,
to_char(ao.CREATED, 'YYYY-MM-DD HH24:MI:SS') as CREATED 
from all_objects ao where owner in ('DBO','UCS','USAGE') and status != 'VALID' order  by 1,2; 
EXIT
