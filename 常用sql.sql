select count(*) fromv$process; --查看当前链接数
select value from v$parameter where name ='processes';--查看最大连接数
--查看被锁表
SELECT l.session_id sid,
       s.serial#,
       l.locked_mode 锁模式,
       l.oracle_username 登录用户,
       l.os_user_name 登录机器用户名,
       s.machine 机器名,
       s.terminal 终端用户名,
       o.object_name 被锁对象名,
       s.logon_time 登录数据库时间
FROM v$locked_object l, all_objects o, v$session s
WHERE l.object_id = o.object_id
   AND l.session_id = s.sid
ORDER BY sid, s.serial#;
--解锁表
alter system kill session '16, 64483';
--生成给数据为0的表分配存储空间的sql
select 'alter table '||table_name||' allocate extent;' sql_text,table_name,tablespace_name
 from user_tables where table_name not in (select segment_name from user_segments where segment_type = 'TABLE');
--查看数据库编码
select * from nls_database_parameters t where t.parameter='NLS_CHARACTERSET';
--该参数值默认是TRUE，当改为FALSE时，无论是空表还是非空表，都分配segment。修改SQL语句：
alter system set deferred_segment_creation=false scope=both;
show parameter deferred_segment_creation;
Select segment_created,table_name from user_tables where segment_created = 'NO';
