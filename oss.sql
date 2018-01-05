
  set linesize 255
  set pagesize 10000
  set tab off

  column USERNAME      format a10
  column STATUS        format a10
  column OSUSER        format a20
  column MACHINE       format a36
  column PROGRAM       format a55
  column description   format a40
  column LOGON_TIME    format a19

       select s.USERNAME, s.STATUS, s.OSUSER, s.MACHINE, s.PROGRAM , to_char(s.LOGON_TIME, 'YYYY-MM-DD HH24:MI:SS') as LOGON_TIME from v$session s
       where username is not null and ( s.USERNAME='DBO' or s.USERNAME='USAGE' or s.USERNAME='BPM' or s.USERNAME='DL' or s.USERNAME='UCS' )
       order by logon_time desc, sid;
   exit

