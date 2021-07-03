CREATE OR REPLACE trigger mr_Section_audit
BEFORE INSERT OR DELETE OR UPDATE ON MR_Section
FOR EACH ROW
ENABLE

DECLARE  

v_user varchar2 (30);  
v_date  varchar2(30);  


BEGIN 

 SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO v_user, v_date  FROM dual;  

     IF INSERTING THEN    
         INSERT INTO MR_Section_audit (new_IDpk,old_IDpk, user_name, entry_date, operation)     
         VALUES(:NEW.Sect_ID, Null , v_user, v_date, 'Insert');    
    
    ELSIF DELETING THEN   
         INSERT INTO mr_Section_audit (new_IDpk,old_IDpk, user_name, entry_date, operation)    
         VALUES(NULL, :OLD.Sect_ID, v_user, v_date, 'Delete');  
    
    ELSIF UPDATING THEN    
         INSERT INTO mr_Section_audit (new_IDpk,old_IDpk, user_name, entry_date, operation)     
         VALUES(:NEW.Sect_ID, :OLD.Sect_ID, v_user, v_date,'Update');  
    
    END IF;
    
    END;
    
   /
   
   
   
   
   
   CREATE OR REPLACE TRIGGER mr_Schema_audit
AFTER DDL ON SCHEMA

BEGIN    
INSERT INTO schema_audit VALUES (
    sysdate,  --//rerutn the date on which the trigger is fired
    sys_context('USERENV','CURRENT_USER'),  --//return the user that has done the DDL
    ora_dict_obj_type, --//return the type of the object on which DDL operation occured
    ora_dict_obj_name, --//return the name of the object given by the user
    ora_sysevent   --//return the type of the operation done
    );
    END;
    /



CREATE OR REPLACE TRIGGER mr_lgon_audit
AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO mr_evnt_audit VALUES(
    ora_sysevent,
    sysdate,
    TO_CHAR(sysdate, 'hh24:mi:ss'), --//return only the time
    NULL,
    NULL
  );
  COMMIT;
END;
/
   
CREATE OR REPLACE TRIGGER log_off_audit
BEFORE LOGOFF ON SCHEMA
BEGIN
  INSERT INTO mr_evnt_audit VALUES(
    ora_sysevent,
    NULL,
    NULL,
    SYSDATE,
    TO_CHAR(sysdate, 'hh24:mi:ss')
  );
  COMMIT;
END;
/
   
   
   
CREATE OR REPLACE TRIGGER mr_startup_audit
AFTER STARTUP ON DATABASE
BEGIN
  INSERT INTO mr_startup_audit VALUES
(
    ora_sysevent,
    SYSDATE,
    TO_CHAR(sysdate, 'hh24:mm:ss')
  );
END;
/   

CREATE OR REPLACE TRIGGER mr_shutdown_audit
BEFORE SHUTDOWN ON DATABASE
BEGIN
  INSERT INTO mr_startup_audit VALUES(
    ora_sysevent,
    SYSDATE,
    TO_CHAR(sysdate, 'hh24:mm:ss')
  );
END;
/
   