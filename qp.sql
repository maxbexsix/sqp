set linesize 255
set pagesize 10000
set tab off

column name        format a45
column description format a50
column appliedby   format a18
column applydate   format a20



select sp.name||']' as name,sp.description,sp.createdate,to_char(sp.applydate, 'YYYY-MM-DD HH24:MI:SS') as applydate
--select sp.name,sp.description,sp.createdate,to_char(sp.applydate, 'YYYY-MM-DD HH24:MI:SS') as applydate
  --,sp.guid
  ,sp.appliedby
  from dbo.softwarepackage sp
 where (sp.type < 2) -- not a just dynamic but pkg ot its component
    or sp.type is null
 order by sp.applydate desc nulls last ,sp.createdate desc nulls last, sp.name ;

EXIT

