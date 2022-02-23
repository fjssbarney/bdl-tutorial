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
-- custreports.4gl

SCHEMA custdemo

MAIN

  DEFER INTERRUPT

  CONNECT TO "custdemo"

  CLOSE WINDOW SCREEN
  OPEN WINDOW w3 WITH FORM "reportprog"  

  MENU "Reports"
  ON ACTION start
      MESSAGE "Report starting"
      CALL cust_report()
  ON ACTION exit
      EXIT MENU
  END MENU

  CLOSE WINDOW w3

DISCONNECT CURRENT

END MAIN

  

FUNCTION cust_report()

DEFINE  pr_custrec RECORD
       store_num   LIKE customer.store_num,
       store_name  LIKE customer.store_name,
       addr        LIKE customer.addr,
       addr2       LIKE customer.addr2,
       city        LIKE customer.city,
       state       LIKE customer.state,
       zipcode     LIKE customer.zipcode
       END RECORD,
       rec_count, rec_total, pbar, break_num  INTEGER
       
  LET pbar = 0
  LET rec_count = 0
  LET rec_total = 0

  LET int_flag = FALSE

  WHENEVER ERROR CONTINUE 
  SELECT COUNT(*) INTO rec_total FROM customer
  WHENEVER ERROR STOP 

  Let break_num = (rec_total/10)  -- maxvalue progress bar is 10

  DECLARE custlist CURSOR FOR
     SELECT store_num, 
       store_name, 
       addr, 
       addr2, 
       city, 
       state, 
       zipcode
     FROM CUSTOMER    
     ORDER BY state, city

  START REPORT cust_list TO FILE "rptout"

  FOREACH custlist INTO pr_custrec.*
  
    OUTPUT TO REPORT cust_list(pr_custrec.*)
    LET rec_count = rec_count+1

    IF rec_count MOD break_num = 0 THEN 
       LET pbar = pbar+1
       DISPLAY pbar TO prgbar
       CALL ui.Interface.refresh() 
       SLEEP 1        -- too few records in the file to see the display without this
       IF int_flag THEN
         EXIT FOREACH
       END IF
    END IF 

  END FOREACH

  IF (int_flag) THEN
    LET int_flag = FALSE
    MESSAGE "Report cancelled"
  ELSE
    FINISH REPORT cust_list
    MESSAGE "Report finished"  
  END IF
  

END FUNCTION 

REPORT cust_list(r_custrec)
 DEFINE  r_custrec RECORD
          store_num  LIKE customer.store_num,
          store_name LIKE customer.store_name,
          addr       LIKE customer.addr,
          addr2      LIKE customer.addr2,
          city       LIKE customer.city,
          state      LIKE customer.state,
          zipcode    LIKE customer.zipcode
       END RECORD


  OUTPUT
    LEFT MARGIN 0
    TOP MARGIN 5
    BOTTOM MARGIN 5

 
  ORDER EXTERNAL BY r_custrec.state, r_custrec.city

  FORMAT

    PAGE HEADER
      SKIP 2 LINES
      PRINT COLUMN 30, "Customer Listing"
      PRINT COLUMN 30, "As of ", TODAY USING "mm/dd/yy"
      PRINT 1 space

 
      PRINT COLUMN 2, "Store #",
            COLUMN 12, "Store Name",
            COLUMN 40, "Address"
            
      PRINT 1 space
      PRINT 1 space
      
  
    ON EVERY ROW
      PRINT COLUMN 5, r_custrec.store_num USING "####",
            COLUMN 12, r_custrec.store_name CLIPPED,
            COLUMN 40, r_custrec.addr CLIPPED;
   
      IF r_custrec.addr2 IS NOT NULL THEN
         PRINT 1 SPACE, r_custrec.addr2 CLIPPED, 1 space;
      ELSE 
         PRINT 1 SPACE;
      END IF
    
      PRINT r_custrec.city CLIPPED,1 space, 
            r_custrec.state, 1 space, 
            r_custrec.zipcode 

    BEFORE GROUP OF r_custrec.state
     SKIP TO TOP OF PAGE
                      
    ON LAST ROW
    SKIP 1 LINE
    PRINT "Total number of customers: ", COUNT(*) USING "#,###"

                       
    PAGE TRAILER
      SKIP 2 LINES
      PRINT COLUMN 30, "- ", pageno USING "<<", " -"
      
  END REPORT
                         
  
           
        
