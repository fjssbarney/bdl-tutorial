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

MAIN

  CONNECT TO "custdemo"

  CLOSE WINDOW SCREEN
  OPEN WINDOW w1 WITH FORM "dispcust"
  MESSAGE "Program retrieves customer 101"
  MENU "Customer" 
    COMMAND "query" 
      CALL query_cust()
    COMMAND "exit" "Quit now"
      EXIT MENU
  END MENU

  CLOSE WINDOW w1

  DISCONNECT CURRENT

END MAIN

FUNCTION query_cust()        -- displays one row
  DEFINE  l_custrec RECORD
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

    SELECT store_num, store_name, addr,
          addr2, city, state,zipcode,
          contact_name, phone 
      INTO l_custrec.*
      FROM customer 
      WHERE store_num = 101
   

  DISPLAY BY NAME l_custrec.* 
  MESSAGE "Customer " || l_custrec.store_num || " displayed"
  
  

END FUNCTION









    

   
