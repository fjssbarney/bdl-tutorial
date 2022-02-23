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
DEFINE store_num  LIKE customer.store_num,
       store_name LIKE customer.store_name 
       
  DEFER INTERRUPT
  CONNECT TO "custdemo"
  
  CLOSE WINDOW SCREEN
  CALL display_custarr()RETURNING store_num, store_name
  DISPLAY store_num, store_name
  
  DISCONNECT CURRENT

END MAIN


 
  
   








    

   
