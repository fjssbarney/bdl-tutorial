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
-- custquery.4gl

SCHEMA custdemo

DEFINE  mr_custrec RECORD
     store_num LIKE customer.store_num,
     store_name LIKE customer.store_name,
     addr LIKE customer.addr,
     addr2 LIKE customer.addr2,
     city LIKE customer.city,
     state LIKE customer.state,
     zipcode LIKE customer.zipcode,
     contact_name LIKE customer.contact_name,
     phone LIKE customer.phone
    END RECORD

FUNCTION query_cust()
  DEFINE cont_ok     SMALLINT,
         cust_cnt    SMALLINT,
         where_clause STRING

  MESSAGE "Enter search criteria"
  LET cont_ok = FALSE
  LET int_flag = FALSE
  
  CONSTRUCT BY NAME where_clause ON customer.store_num,
                                   customer.store_name,
                                   customer.addr,
                                   customer.addr2,
                                   customer.city,
                                   customer.state,
                                   customer.zipcode,
                                   customer.contact_name,
                                   customer.phone
                             
  IF (int_flag) = TRUE THEN
    LET int_flag=FALSE
    CLEAR FORM
    LET cont_ok = FALSE
    MESSAGE "Canceled by user."
  ELSE      
    CALL get_cust_cnt(where_clause)
           RETURNING cust_cnt
    IF (cust_cnt > 0) THEN
       MESSAGE cust_cnt using "<<<<", " rows found."
       CALL cust_select(where_clause)
          RETURNING cont_ok
    ELSE
       MESSAGE "No rows found."
       LET cont_ok = FALSE    
    END IF
  END IF
 
  IF (cont_ok) THEN
    CALL display_cust()
  END IF
    
END FUNCTION

FUNCTION get_cust_cnt(p_where_clause)
  DEFINE p_where_clause   STRING,
         sql_text         STRING,
         cust_cnt         SMALLINT
         
  LET sql_text = "SELECT COUNT(*) FROM customer WHERE " || p_where_clause CLIPPED
  
  PREPARE cust_cnt_stmt FROM sql_text
  EXECUTE cust_cnt_stmt INTO cust_cnt
  FREE cust_cnt_stmt
  
  RETURN cust_cnt
  
END FUNCTION
  
FUNCTION cust_select(p_where_clause) 
  DEFINE p_where_clause  STRING,
         sql_text        STRING,
         fetch_ok        SMALLINT
 
  LET sql_text = "SELECT store_num, store_name, addr, addr2," ||
      " city, state, zipcode, contact_name, phone" ||
      " FROM customer WHERE " || p_where_clause clipped ||
      " ORDER BY store_num "
  PREPARE query_stmt FROM sql_text
  DECLARE cust_curs SCROLL CURSOR FOR query_stmt
  OPEN cust_curs
  CALL fetch_cust(1)        --fetch the first row
     RETURNING fetch_ok
  IF NOT (fetch_ok) THEN
     MESSAGE "no rows in table."   -- someone deleted the rows after we checked the count
  END IF
      
  RETURN fetch_ok
 
END FUNCTION
 


FUNCTION fetch_cust (p_fetch_flag)
  DEFINE p_fetch_flag SMALLINT,
         fetch_ok     SMALLINT
         
  LET fetch_ok = TRUE
  IF (p_fetch_flag = 1) THEN
     FETCH NEXT cust_curs
       INTO mr_custrec.*
  ELSE
     FETCH PREVIOUS cust_curs
       INTO mr_custrec.*
  END IF
  
  IF (SQLCA.SQLCODE = NOTFOUND) THEN
    LET fetch_ok = FALSE
  END IF
  
  RETURN fetch_ok
  
END FUNCTION



FUNCTION fetch_rel_cust(p_fetch_flag)
  DEFINE p_fetch_flag SMALLINT,
         fetch_ok     SMALLINT
   
  MESSAGE " "       
  CALL fetch_cust(p_fetch_flag)
    RETURNING fetch_ok
    
  IF (fetch_ok) THEN
    CALL display_cust()
  ELSE
    IF (p_fetch_flag = 1) THEN
      MESSAGE "End of list"
    ELSE
      MESSAGE "Beginning of list"
    END IF
  END IF
    
 END FUNCTION
 




 FUNCTION display_cust()
  DISPLAY BY NAME mr_custrec.*
END FUNCTION
 


      
      
      
      
      
         
    





