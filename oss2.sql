
  set linesize 255
  set pagesize 10000
  set tab off

  column USERNAME      format a6
  column STATUS        format a8
--  column SID	       format a12
  column OSUSER        format a15
  column MACHINE       format a36
  column PROGRAM       format a28
  column description   format a33
  column LOGON_TIME    format a19

       select s.USERNAME, s.STATUS, s.SID, s.OSUSER, s.MACHINE, s.PROGRAM , to_char(s.LOGON_TIME, 'YYYY-MM-DD HH24:MI:SS') as LOGON_TIME from v$session s
       where username is not null and  s.USERNAME in ('DBO','USAGE','BPM','DL','UCS' ) 
       order by logon_time desc, sid;
   exit

