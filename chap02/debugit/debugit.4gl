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
--debugit.4gl using DISPLAY to identify runtime errors 
-- in this simple example, the program didn't allow
-- for the possibility that the customer number isn't
-- in the database table. 
 
SCHEMA custdemo 

MAIN
  DEFINE l_store_name LIKE customer.store_name
  
  CONNECT TO "custdemo" 
  
  CALL select_name(11)RETURNING l_store_name
  DISPLAY l_store_name
  
  DISCONNECT CURRENT

END MAIN  

FUNCTION select_name(f_store_num)
  DEFINE f_store_num   LIKE customer.store_num,
         f_store_name  LIKE customer.store_name

--simple debugging for runtime error
  DISPLAY "select_name function"
  DISPLAY "storenum - ", f_store_num
 
  SELECT store_name INTO f_store_name 
    FROM customer
    WHERE store_num = f_store_num
    
  RETURN f_store_name
   
END FUNCTION  -- select_name

