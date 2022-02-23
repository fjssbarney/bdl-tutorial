# FOURJS_START_COPYRIGHT(U,2016)
# Property of Four Js*
# (c) Copyright Four Js 2016, 2021. All Rights Reserved.
# * Trademark of Four Js Development Tools Europe Ltd
#   in the United States and elsewhere
# 
# Four Js and its suppliers do not warrant or guarantee that these samples are
# accurate and suitable for your purposes.
# Their inclusion is purely for information purposes only.
# FOURJS_END_COPYRIGHT

SCHEMA custdemo
DEFINE cust RECORD
    store_num LIKE customer.store_num,
    store_name LIKE customer.store_name,
    state LIKE customer.state
  END RECORD
  
MAIN
  DEFINE cb ui.ComboBox
  CONNECT TO "custdemo"

  CLOSE WINDOW SCREEN
  OPEN WINDOW w1 WITH FORM "testcb"
  LET cb = ui.ComboBox.forName("customer.state")
  IF cb IS NOT NULL THEN
   CALL loadcb(cb)
  END IF
  INPUT BY NAME cust.*
END MAIN

FUNCTION loadcb(cb)
  DEFINE cb ui.ComboBox,
         cb_state_code LIKE state.state_code,
         cb_state_name LIKE state.state_name

  CALL cb.clear()
  DECLARE mycurs CURSOR FOR SELECT state_code, state_name FROM state
  FOREACH mycurs INTO cb_state_code, cb_state_name
    -- provide name and text for the ComboBox item
    CALL cb.addItem(cb_state_code,cb_state_name)
  END FOREACH
END FUNCTION
  
