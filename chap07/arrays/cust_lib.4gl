# FOURJS_START_COPYRIGHT(U,2002)
# Property of Four Js*
# (c) Copyright Four Js 2002, 2021. All Rights Reserved.
# * Trademark of Four Js Development Tools Europe Ltd
#   in the United States and elsewhere
# 
# Four Js and its suppliers do not warrant or guarantee that these samples are
# accurate and suitable for your purposes.
# Their inclusion is purely for information purposes only.
# FOURJS_END_COPYRIGHT
SCHEMA custdemo

FUNCTION display_custarr()
  DEFINE cust_arr DYNAMIC ARRAY OF RECORD
     store_num     LIKE customer.store_num,
     store_name    LIKE customer.store_name,
     city          LIKE customer.city,
     state         LIKE customer.state,
     zipcode       LIKE customer.zipcode,
     contact_name  LIKE customer.contact_name,
     phone         LIKE customer.phone
    END RECORD, 
     ret_num       LIKE customer.store_num,
     ret_name      LIKE customer.store_name,
     curr_pa, idx  SMALLINT
  
  
  OPEN WINDOW wcust WITH FORM "manycust"
 
  DECLARE custlist_curs CURSOR FOR
    SELECT store_num, 
          store_name, 
          city, 
          state, 
          zipcode, 
          contact_name, 
          phone
        FROM customer
  
  LET idx = 1
  WHENEVER ERROR CONTINUE
  FOREACH custlist_curs 
       INTO cust_arr[idx].*
    LET idx = idx + 1
  END FOREACH
  WHENEVER ERROR STOP
    
   IF (idx > 1) THEN 
     CALL cust_arr.deleteElement(idx)
     LET idx = idx -1 
     DISPLAY ARRAY cust_arr TO sa_cust.* 
         ATTRIBUTES(COUNT=idx)
     LET curr_pa = arr_curr()
     LET ret_num = cust_arr[curr_pa].store_num
     LET ret_name = cust_arr[curr_pa].store_name
   ELSE
       LET ret_num = 0
       LET ret_name = "   "
   END IF   
 
  
  IF (int_flag) THEN
     LET int_flag = FALSE
     LET ret_num = 0
     LET ret_name = "   "
  END IF
 

  CLOSE WINDOW wcust
  RETURN ret_num, ret_name 

END FUNCTION -- display_cust --

