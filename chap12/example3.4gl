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
MAIN
 DEFINE win ui.Window,
        fm ui.Form,
        mycust record like customer.*
 CONNECT TO "custdemo"
 OPEN WINDOW w1 WITH FORM "hidecust"
 SELECT * INTO mycust.* FROM customer 
      WHERE store_num = 101
 DISPLAY BY NAME mycust.*
 LET win = ui.Window.getCurrent()
 LET fm = win.getForm()
 MENU
    ON ACTION HIDE
      CALL fm.setFieldHidden("contact_name",1)
      CALL fm.setFieldHidden("addr2", 1)
      -- hide the label for contact name 
      CALL fm.setElementHidden("lbl", 1)
    ON ACTION QUIT
      EXIT MENU
  END MENU
END MAIN
