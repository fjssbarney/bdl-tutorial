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
--custmain.4gl chapter 6


MAIN
DEFINE query_ok SMALLINT

  DEFER INTERRUPT
  CONNECT TO "custdemo"
  -- SET LOCK MODE TO WAIT   valid depending on database vendor  
  CLOSE WINDOW SCREEN
  OPEN WINDOW w1 WITH FORM "custform"

  MENU "Customer"
     COMMAND "find" 
      CALL query_cust() RETURNING query_ok
    COMMAND "next"           
      IF (query_ok) THEN
        CALL fetch_rel_cust(1)
      ELSE
        MESSAGE "You must query first."
        -- hide the action when ON DIALOG available
       END IF
    COMMAND "previous"
      IF (query_ok) THEN
        CALL fetch_rel_cust(-1)
      ELSE
        MESSAGE "You must query first."
      END IF
     COMMAND "Add"
      IF (inpupd_cust("A")) THEN
        CALL insert_cust()
      END IF
     COMMAND "Delete"
      IF (delete_check()) THEN
         CALL delete_cust()
      END IF
      COMMAND "Modify" 
      IF inpupd_cust("U") THEN
        CALL update_cust()
      END IF
      COMMAND "quit" 
      EXIT MENU
  END MENU
  
  CLOSE WINDOW w1
 
  DISCONNECT CURRENT

END MAIN


 
 
   









    

   
