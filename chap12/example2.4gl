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

MAIN
 DEFINE mywin ui.Window,
        f1    ui.Form
 CALL ui.interface.loadStyles("customstyles") 
 OPEN WINDOW w1 WITH FORM "testform"
 LET mywin = ui.Window.getCurrent()
 CALL mywin.setText("test")
 LET f1 = mywin.getForm()
 MENU
   ON ACTION changes
     CALL f1.setElementText("lb1", "goodbye")
     CALL f1.setElementText("quit", "leave")
     CALL f1.setElementImage("quit", "exit.png")
     CALL f1.setElementStyle("lb1", "mystyle")
   ON ACTION quit
     EXIT MENU
 END MENU
END MAIN
