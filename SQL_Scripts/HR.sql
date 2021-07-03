CREATE TABLE mr_Currency (
Currency_code VARCHAR2(3) NOT NULL,
Cur_Rate NUMBER NOT NULL,
CONSTRAINT mr_pk_Currency PRIMARY KEY(Currency_code)
);

CREATE TABLE mr_Curency_Rate(
FromCur VARCHAR2(3 CHAR) NOT NULL,
FromCur_Rate NUMBER NOT NULL,
ToCur VARCHAR2(3 CHAR) NOT NULL,
ToCur_Result NUMBER NOT NULL,

CONSTRAINT mr_pk_Currency_Rate
  PRIMARY KEY(FromCur, ToCur)
);


CREATE TABLE mr_Invoice_Header (
Inv_ID NUMBER NOT NULL,
ItmTy_ID NUMBER NOT NULL,
BookList_ID NUMBER,
Emp_ID NUMBER NOT NULL,
Cust_ID NUMBER NOT NULL,
Loc_ID NUMBER NOT NULL,
Start_D DATE NOT NULL,
End_D DATE NOT NULL,
Amount NUMBER NOT NULL,

CONSTRAINT mr_pk_Invoice_Header 
  PRIMARY KEY(Inv_ID)
);

CREATE TABLE mr_Invoice_Details (
Inv_ID NUMBER NOT NULL,
Emp_ID NUMBER NOT NULL,
Cust_ID NUMBER NOT NULL,
ItemType_ID NUMBER NOT NULL,
Quan NUMBER NOT NULL,
      CONSTRAINT mr_check_qty0 CHECK (Quan > 0),
Sub_Totalc NUMBER NOT NULL,

CONSTRAINT mr_pk_Invoice_Details
  PRIMARY KEY(Inv_ID)
);


CREATE TABLE mr_Book_List(
List_ID NUMBER(10) NOT NULL,
Inv_ID NUMBER(10) NOT NULL,
Book_ID NUMBER(10) NOT NULL,

Quan    NUMBER 
      CONSTRAINT mr_nn_qty1 NOT NULL 
      CONSTRAINT mr_check_qty1 CHECK (Quan > 0),

Sub_Total NUMBER(25)NOT NULL,

CONSTRAINT mr_pk_Book_List 
  PRIMARY KEY(List_ID)
);

CREATE TABLE mr_Item_Type(
ItmTy_ID NUMBER(10) NOT NULL,
Itm_Desc VARCHAR2(25) NOT NULL,

CONSTRAINT mr_pk_Item_Type PRIMARY KEY(ItmTy_ID)
);

CREATE TABLE mr_Payement(
Pay_ID NUMBER NOT NULL,
Inv_ID NUMBER NOT NULL,
Emp_ID NUMBER NOT NULL,
Payer_ID NUMBER NOT NULL,
Paid_Ammount NUMBER NOT NULL,
Returned_Ammount NUMBER NOT NULL,
Pay_D DATE NOT NULL,
CurReceived_Code VARCHAR2(3 CHAR) NOT NULL,
CurReturned_Code VARCHAR2(3 CHAR) NOT NULL,

CONSTRAINT mr_pk_Payement
  PRIMARY KEY(Pay_ID)
);


CREATE TABLE mr_Book (
Book_ID NUMBER NOT NULL,
Title VARCHAR2(25) NOT NULL,
Ath_ID NUMBER NOT NULL,
Lang VARCHAR2(25) NOT NULL,
Edt_Num NUMBER NOT NULL,
Local_UPrice NUMBER NOT NULL,
Foreing_UPrice NUMBER NOT NULL,
Genre VARCHAR2(25) NOT NULL,
Pub_ID NUMBER NOT NULL,
Pub_Date DATE NOT NULL,
N_Pages VARCHAR2(25) NOT NULL,

CONSTRAINT mr_pk_Book
  PRIMARY KEY (Book_ID)
);

CREATE TABLE mr_Person(
P_ID NUMBER(10) NOT NULL,
Pt_ID NUMBER(10) NOT NULL,
Super_ID NUMBER(10) NOT NULL,
P_FName VARCHAR2(25) NOT NULL,
P_MName VARCHAR2(25) NOT NULL,
P_LName VARCHAR2(25) NOT NULL,
Local_PhoneNumber NUMBER(8,6) NULL,
Foreing_PhoneNumber NUMBER(20) NULL,
B_Date DATE NOT NULL,
D_Date DATE NOT NULL,
Nat VARCHAR2(25) NOT NULL,
EMAIL VARCHAR2(25) NOT NULL,
P_BirthID NUMBER(10) NOT NULL,
AddrID NUMBER(10) NOT NULL,
WorkP_ID NUMBER(10) NOT NULL,

CONSTRAINT mr_pk_Person 
  PRIMARY KEY (P_ID)
);

CREATE TABLE mr_Person_Type(
Pt_ID NUMBER(10) NOT NULL,
Pt_Type VARCHAR2(25) NOT NULL,
Pt_Role VARCHAR2(25) NOT NULL,

CONSTRAINT mr_pk_Person_Type
  PRIMARY KEY(Pt_ID)
);

CREATE TABLE mr_Warehouse(
Loc_ID NUMBER(10) NOT NULL,
Room_ID NUMBER(10) NOT NULL,
Sect_ID NUMBER(10) NOT NULL,
Book_ID NUMBER(10) NOT NULL,

CONSTRAINT mr_pk_Waerhouse
  PRIMARY KEY(Loc_ID, Room_ID, Sect_ID)
);

CREATE TABLE mr_Location(
Loc_ID NUMBER(10) NOT NULL,
X_coord NUMBER(38) NOT NULL,
Y_coord NUMBER(38) NOT NULL,
Gov_Name VARCHAR2(25) NOT NULL,
Reg_Name VARCHAR2(25) NOT NULL,
Srt_Name VARCHAR2(25) NOT NULL,
Blg_Num NUMBER(5) NOT NULL,
Flr_Num NUMBER(3) NOT NULL,
Rm_Qant NUMBER(3) NOT NULL,

CONSTRAINT mr_pk_Location 
  PRIMARY KEY(Loc_ID),
  
Rm_Quan    NUMBER 
      CONSTRAINT mr_nn_qty2 NOT NULL 
      CONSTRAINT mr_check_qty2 CHECK (Rm_Quan > 0)
);


CREATE TABLE mr_Room(
Rm_ID NUMBER(10) NOT NULL,
Rm_Desc VARCHAR2(25) NOT NULL,

CONSTRAINT mr_pk_Room
  PRIMARY KEY (Rm_ID)
);

CREATE TABLE mr_Section(
Sect_ID NUMBER(3) NOT NULL,
Sect_Desc VARCHAR2(25) NOT NULL,

CONSTRAINT mr_pk_Section_ID
  PRIMARY KEY(Sect_ID)
);


ALTER TABLE mr_Curency_Rate
ADD CONSTRAINT mr_fk_Currency_Rate_Currency0
  FOREIGN KEY (FromCur)
  REFERENCES mr_Currency (Currency_Code);
  
ALTER TABLE mr_Curency_Rate 
ADD CONSTRAINT mr_fk_Currency_Rate_Currency1
  FOREIGN KEY (ToCur)
  REFERENCES mr_Currency (Currency_Code);


ALTER TABLE mr_Invoice_Header
ADD CONSTRAINT mr_fk_ItemType_Invoice_Header
  FOREIGN KEY (ItmTy_ID)
  REFERENCES mr_Item_Type (ItmTy_ID);
  
ALTER TABLE mr_Invoice_Header
ADD CONSTRAINT mr_fk_Invoice_Header_Book_List
  FOREIGN KEY (BookList_ID)
  REFERENCES mr_Book_List (List_ID);
  

ALTER TABLE mr_Invoice_Header
ADD CONSTRAINT mr_fk_Invoice_Header_Person0
  FOREIGN KEY (Emp_ID)
  REFERENCES mr_Person (P_ID);
  
ALTER TABLE mr_Invoice_Header
ADD CONSTRAINT mr_fk_Invoice_Header_Person1
  FOREIGN KEY (Cust_ID)
  REFERENCES mr_Person (P_ID);
  
ALTER TABLE mr_Invoice_Header
ADD CONSTRAINT mr_fk_Invoice_Header_Location
  FOREIGN KEY (Loc_ID)
  REFERENCES mr_Location (Loc_ID);


 ALTER TABLE mr_Invoice_Details
 ADD CONSTRAINT mr_fk_Invoice_Details_Person0
  FOREIGN KEY (Emp_ID)
  REFERENCES mr_Person (P_ID);
  
 ALTER TABLE mr_Invoice_Details
 ADD CONSTRAINT mr_fk_Invoice_Details_Person1
  FOREIGN KEY (Cust_ID)
  REFERENCES mr_Person (P_ID);
  
 ALTER TABLE mr_Invoice_Details
 ADD CONSTRAINT mr_fk_Invoice_Details_Item_Type
  FOREIGN KEY (Emp_ID)
  REFERENCES mr_Item_Type (ItmTy_ID);

 ALTER TABLE mr_Book_List
 ADD CONSTRAINT mr_fk_Book_List_Invoice_Header
 FOREIGN KEY (Inv_ID)
 REFERENCES mr_Invoice_Header (Inv_ID);

 ALTER TABLE mr_Book_List
 ADD CONSTRAINT mr_fk_Book_List_Book
  FOREIGN KEY (Book_ID)
  REFERENCES mr_Book (Book_ID);


ALTER TABLE mr_Payement
ADD CONSTRAINT mr_fk_Payement_Invoice_Header
  FOREIGN KEY (Inv_ID)
  REFERENCES mr_Invoice_Header (Inv_ID);
  
ALTER TABLE mr_Payement
ADD CONSTRAINT mr_fk_Payement_Person0
  FOREIGN KEY (Emp_ID)
  REFERENCES mr_Person (P_ID);
  
ALTER TABLE mr_Payement
ADD CONSTRAINT mr_fk_Payement_Person1
  FOREIGN KEY (Payer_ID)
  REFERENCES mr_Person (P_ID);
  
ALTER TABLE mr_Payement
ADD CONSTRAINT mr_fk_Payement_Currency0
  FOREIGN KEY (CurReceived_Code)
  REFERENCES mr_Currency (Currency_Code);
  
ALTER TABLE mr_Payement
ADD CONSTRAINT mr_fk_Payement_Currency1
  FOREIGN KEY (CurReturned_Code)
  REFERENCES mr_Currency (Currency_Code);




ALTER TABLE mr_Book 
ADD CONSTRAINT mr_fk_Book_Person0
  FOREIGN KEY (Ath_ID)
  REFERENCES mr_Person (P_ID);

ALTER TABLE mr_Book 
ADD CONSTRAINT mr_fk_Book_Person1
  FOREIGN KEY (Pub_ID)
  REFERENCES mr_Person (P_ID);

 ALTER TABLE mr_Person
 ADD CONSTRAINT mr_fk_Person_Person
  FOREIGN KEY (Super_ID)
  REFERENCES mr_Person (P_ID);  

ALTER TABLE mr_Person
ADD CONSTRAINT mr_fk_Person_Location0
  FOREIGN KEY (P_BirthID)
  REFERENCES mr_Location (Loc_ID);
  
ALTER TABLE mr_Person
ADD CONSTRAINT mr_fk_Person_Location1
  FOREIGN KEY (AddrID)
  REFERENCES mr_Location (Loc_ID);
  
ALTER TABLE mr_Person
ADD CONSTRAINT mr_fk_Person_Location2
  FOREIGN KEY (WorkP_ID)
  REFERENCES mr_Location (Loc_ID);





 ALTER TABLE mr_Warehouse
 ADD CONSTRAINT mr_fk_Warehouse_Book
  FOREIGN KEY (Book_ID)
  REFERENCES mr_Book (Book_ID); 


CREATE TABLE mr_Tables_Name(
Table_name VARCHAR2(25) NOT NULL);
CREATE TABLE mr_Tabels_Name_Audit(
new_name varchar2(30),  
old_name varchar2(30),  
user_name varchar2(30),  
entry_date varchar2(30),  
operation  varchar2(30)
);




CREATE TABLE mr_schema_audit  (    
ddl_date       DATE,    
ddl_user       VARCHAR2(50),    
object_created VARCHAR2(50),    
object_name    VARCHAR2(50),    
ddl_operation  VARCHAR2(50)  
);


CREATE TABLE mr_evnt_audit
  (
    event_type VARCHAR2(30),  --//type of the event that fires the trigger
    logon_date DATE, 
    logon_time VARCHAR2(15),
    logof_date DATE,
    logof_time VARCHAR2(15)
  );
  
CREATE TABLE mr_startup_audit 
(
  Event_type  VARCHAR2(15),
  event_date  DATE,
  event_time  VARCHAR2(15)
);
