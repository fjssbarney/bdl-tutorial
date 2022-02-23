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



MAIN
    
  --DEFER INTERRUPT
  
  CONNECT TO "custdemo"
  CLOSE WINDOW SCREEN
  OPEN WINDOW w1 WITH FORM "custform"

  MENU "Customer"
    COMMAND "query" "Search for customers"
      CALL query_cust() 
    COMMAND "next"           
      CALL fetch_rel_cust(1)
    COMMAND "previous"
      CALL fetch_rel_cust(-1)
    COMMAND "quit"
      EXIT MENU
  END MENU
  
  CLOSE WINDOW w1
 
  DISCONNECT CURRENT

END MAIN


 
  







    

   
