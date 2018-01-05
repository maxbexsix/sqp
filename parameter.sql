column text format a55
column stringvalue format a55
set linesize 299
set pagesize 0

select '[' || text || ']' as text, '[' || stringvalue || ']' as stringvalue  from parameter order by 2
/
EXIT 
