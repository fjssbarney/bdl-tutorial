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
  OPEN WINDOW w1 WITH FORM "form"
  MESSAGE %"customer.msg"
  MENU %"customer.menu"
    ON ACTION query
      CALL query_cust()
    ON ACTION exit
      EXIT MENU
  END MENU

  CLOSE WINDOW w1

  DISCONNECT CURRENT

END MAIN

FUNCTION query_cust()        -- displays one row
  DEFINE  l_custrec RECORD
            store_num LIKE customer.store_num,
            store_name LIKE customer.store_name,
            city LIKE customer.city
          END RECORD,
          msg STRING

    WHENEVER ERROR CONTINUE
    SELECT store_num, store_name, city
      INTO l_custrec.*
      FROM customer
      WHERE store_num = 101
   WHENEVER ERROR STOP

   IF SQLCA.SQLCODE = 0 THEN
      LET msg = SFMT( %"customer.valid",
                      l_custrec.store_num )
      MESSAGE msg
      DISPLAY BY NAME l_custrec.*
   ELSE
      MESSAGE %"customer.notfound"
   END IF

END FUNCTION

