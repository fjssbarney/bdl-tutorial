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
  
 DEFINE  pr_custrec RECORD
       store_num   LIKE customer.store_num,
       store_name  LIKE customer.store_name,
       addr        LIKE customer.addr,
       addr2       LIKE customer.addr2,
       city        LIKE customer.city,
       state       LIKE customer.state,
       zipcode     LIKE customer.zipcode
     END RECORD

  CONNECT  TO "custdemo"

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
 
  -- START REPORT cust_list TO FILE "rptout" WITH LEFT MARGIN = 5, TOP MARGIN = 2, BOTTOM MARGIN = 2 
  START REPORT cust_list WITH LEFT MARGIN = 5, TOP MARGIN = 2, BOTTOM MARGIN = 2 
  WHENEVER ERROR CONTINUE
  FOREACH custlist INTO pr_custrec.*
  WHENEVER ERROR STOP
        OUTPUT TO REPORT cust_list(pr_custrec.*)
  END FOREACH

  FINISH REPORT cust_list
  
  DISCONNECT CURRENT

END MAIN 

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


   
  ORDER EXTERNAL BY r_custrec.state, r_custrec.city

  FORMAT

    PAGE HEADER
      SKIP 2 LINES
      PRINT COLUMN 30, "Customer Listing"
      PRINT COLUMN 30, "As of ", TODAY USING "mm/dd/yy"
      PRINT 1 space

 
      PRINT COLUMN 2, "Store #",
            COLUMN 12, "Store Name",
            COLUMN 35, "Address"
            
      PRINT 1 space
      PRINT 1 space
      
  
    ON EVERY ROW
      PRINT COLUMN 5, r_custrec.store_num USING "####",
            COLUMN 12, r_custrec.store_name CLIPPED,
            COLUMN 35, r_custrec.addr CLIPPED;
   
      IF r_custrec.addr2 IS NOT NULL THEN
         PRINT 1 SPACE, r_custrec.addr2 CLIPPED;
      ELSE 
         PRINT 1 SPACE;
      END IF
    
      PRINT 1 space, 
            r_custrec.city CLIPPED,1 space, 
            r_custrec.state, 1 space, 
            r_custrec.zipcode 

    BEFORE GROUP OF r_custrec.state
     SKIP TO TOP OF PAGE
                      
    ON LAST ROW
    SKIP 1 LINE
    PRINT COLUMN 5, "Total number of customers: ", COUNT(*) USING "#,###"

                       
    PAGE TRAILER
      SKIP 2 LINES
      PRINT COLUMN 30, "- ", pageno USING "<<", " -"
      
  END REPORT
                         
  
           
        
