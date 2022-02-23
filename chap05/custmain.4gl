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
--custmain2.4gl


MAIN
  DEFINE query_ok SMALLINT

  DEFER INTERRUPT

  CONNECT TO "custdemo"
  CLOSE WINDOW SCREEN
   CALL ui.Interface.setImage( "exit")
  OPEN WINDOW w1 WITH FORM "custform"
  LET query_ok = FALSE

  MENU 
     BEFORE MENU
        CALL DIALOG.setActionActive("next",0)
        CALL DIALOG.setActionActive("previous",0)
     ON ACTION find
        CALL DIALOG.setActionActive("next",0)
        CALL DIALOG.setActionActive("previous",0)    
        CALL query_cust() RETURNING query_ok
       IF (query_ok) THEN 
          CALL DIALOG.setActionActive("next",1)
          CALL DIALOG.setActionActive("previous",1)
       END IF
    ON ACTION next          
           CALL fetch_rel_cust(1)
      ON ACTION previous
           CALL fetch_rel_cust(-1)
      ON ACTION quit
           EXIT MENU
      ON ACTION close
           EXIT MENU
   END MENU

   CLOSE WINDOW w1
   CALL cleanup()

   DISCONNECT CURRENT

 END MAIN

   
 
