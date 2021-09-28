/*--- 10g or newer ---*/

-- set tracing on (sid and serial# from v$sql are required parameters)
begin
dbms_monitor.session_trace_enable(session_id => SID, serial_num => SERIAL, waits => true, binds => true);
end;

-- turns tracing off (sid and serial# from v$sql are required parameters)
begin
dbms_monitor.session_trace_disable(session_id => SID, serial_num => SERIAL);
end;

-- path to trace file
SELECT p.tracefile
FROM v$session s,
v$process p
WHERE s.paddr = p.addr
AND s.sid = SID
AND s.SERIAL# = SERIAL;

/*--- 9i ---*/

-- set tracing on (sid and serial# from v$sql are required parameters)
begin
sys.dbms_support.start_trace_in_session(SID, SERIAL, true, true);
end;

-- turns tracing off (sid and serial# from v$sql are required parameters)
begin
sys.dbms_support.stop_trace_in_session(SID, SERIAL);
end;

-- path to trace file
SELECT par.value || '\' || user || '_ora_' || p.spid || '.trc'
FROM v$session s,
v$process p,
v$parameter par
WHERE s.paddr = p.addr
AND s.sid = SID
AND s.SERIAL# = SERIAL
AND par.name = 'user_dump_dest';
