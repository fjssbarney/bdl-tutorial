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
  CALL ui.Form.setDefaultInitializer("myforminit")
  OPEN WINDOW w1 WITH FORM "testform"
  MENU
    ON ACTION quit
      EXIT MENU
  END MENU
  OPEN WINDOW w2 WITH FORM "testform2"
  MENU
    ON ACTION quit
      EXIT MENU
  END MENU
END MAIN

FUNCTION myforminit(f)
  DEFINE f ui.form
      CALL f.loadTopMenu("mytopmenu")
END FUNCTION
