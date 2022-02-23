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


-------------------------------------------------------------
FUNCTION display_custarr()
-------------------------------------------------------------
DEFINE cust_arr DYNAMIC ARRAY OF RECORD
     store_num     LIKE customer.store_num,
     store_name    LIKE customer.store_name,
     city          LIKE customer.city,
     state         LIKE customer.state,
     zipcode       LIKE customer.zipcode,
     contact_name  LIKE customer.contact_name,
     phone         LIKE customer.phone
    END RECORD ,
        ret_num     LIKE customer.store_num,
        ret_name    LIKE customer.store_name,
        cont_disp   SMALLINT,
        ofs, len, i SMALLINT,
        sql_text    STRING,
        curr_pa     SMALLINT,
        rec_count   SMALLINT
  
  
  OPEN WINDOW wcust WITH FORM "manycust"
 
  LET rec_count = 0
  WHENEVER ERROR CONTINUE
  SELECT COUNT(*) INTO rec_count FROM customer
  WHENEVER ERROR STOP
  IF (rec_count > 0) THEN
    LET cont_disp = TRUE 
  ELSE
    LET ret_num = 0
    LET ret_name = "  "
    LET cont_disp = FALSE
  END IF   
 
  IF (cont_disp) THEN 
    LET sql_text =  
    "SELECT store_num,
            store_name,
            city,
            state,
            zipcode,
            contact_name,
            phone 
          FROM customer ",
    "  WHERE store_num = ?"
    PREPARE fetch_all FROM sql_text


    DECLARE num_curs SCROLL CURSOR FOR
     SELECT store_num FROM customer    

    OPEN num_curs
    DISPLAY ARRAY cust_arr TO sa_cust.* ATTRIBUTES (UNBUFFERED, COUNT=rec_count)

    ON FILL BUFFER
      LET ofs = FGL_DIALOG_GETBUFFERSTART()
      LET len = FGL_DIALOG_GETBUFFERLENGTH()

      FOR i = 1 to len

        WHENEVER ERROR CONTINUE
        FETCH ABSOLUTE ofs+i-1 num_curs 
          INTO cust_arr[i].store_num
        EXECUTE fetch_all INTO cust_arr[i].* 
          USING cust_arr[i].store_num
        WHENEVER ERROR STOP
        IF SQLCA.SQLCODE = NOTFOUND THEN
          MESSAGE "Row deleted by another user."
          CONTINUE FOR
        ELSE
           IF SQLCA.SQLCODE < 0 THEN
             ERROR SQLERRMESSAGE 
             CONTINUE FOR
           END IF
        END IF
     END FOR

    AFTER DISPLAY
     IF (INT_FLAG) THEN
       LET ret_num = 0
       LET ret_name = "   "
     ELSE
       LET curr_pa = (ARR_CURR())-ofs+1
       LET ret_num = cust_arr[curr_pa].store_num 
       LET ret_name = cust_arr[curr_pa].store_name
     END IF

    END DISPLAY

  END IF  

  CLOSE WINDOW wcust
  RETURN ret_num, ret_name

END FUNCTION -- display_custarr







