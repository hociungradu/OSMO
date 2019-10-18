*** Settings ***
Library     AppiumLibrary
Library     String
Library 	RobotAppEyes

*** Variables ***
@{osmolist} =   Create List   20020     20021	   20022
@{4klist} =   Create List   20013

${CHECKIN}                  Run Keyword And Return Status      Wait Until Element Is Visible     ${SIGNIN-SIGNOFF-BUTTON}    1s
${CCW-DIALING}              Run Keyword And Return Status      Element Should Contain Text     ${CCW-DIALING-FIELD}    Dialing
#${REL-VISIBLE}              Run Keyword And Return Status       Wait Until Page Contains Element        ${CCW-ENDCALL-BUTTON}   2s
#${REL-VISIBLE}      True

${SIGNIN-SIGN-BUTTON}               //android.widget.Switch[@resource-id="com.unify.osmo:id/switch1"]
${SIGNIN-SIGNOFF-BUTTON}            //android.widget.Switch[@text="OFF"]

#***        Main upper tab
${SIGNIN-JOURNAL-TAB}               //android.widget.ImageView[@content-desc="Journal"]
${SIGNIN-CONTACTS-TAB}              //android.widget.ImageView[@content-desc="Contacts"]
${SIGNIN-DIAL-TAB}                  //android.widget.ImageView[@content-desc="Dialpad"]
${SIGNIN-USER-TAB}                  //android.widget.ImageView[@content-desc="User"]
${SIGNIN-SETTINGS-TAB}              //android.widget.ImageView[@content-desc="Settings"]

#***       Dialpad Page

${DIALPAD-DIALDIGITS-FIELD}         //android.widget.EditText[@resource-id="com.unify.osmo:id/dialdigits"]      # Campul pt introducere digits
${DIALPAD-DIAL-BUTTON}              //android.widget.ImageButton[@resource-id="com.unify.osmo:id/callButton"]       # Butonul de apel

#***        Journal Page
${JOURNAL-MORE-MENIU}                   //android.widget.ImageView[@content-desc="More options"]
${JOURNAL-MORE-DELETE-ALL-FIELD}        //android.widget.TextView[@text="Delete all journal records"]
${JOURNAL-DELETEALL-WARNING-FIELD}      //android.widget.TextView[@resource-id="android:id/message"]
${JOURNAL-YES-ALL-BUTTON}               //android.widget.Button[@resource-id="android:id/button1"]
${JOURNAL-ENTRY-FIELD}                  //android.widget.RelativeLayout[@resource-id="com.unify.osmo:id/LinearLayout01"]


#***       Outgoing CCW page when calls are involved

${CCW-DIALING-FIELD}                //android.widget.TextView[@text="Dialing"]
${CCW-PERSI-FIELD}                  //android.widget.TextView[@resource-id="com.unify.osmo:id/name"]
${CCW-NUMBER-FIELD}                 //android.widget.TextView[@resource-id="com.unify.osmo:id/phoneNumber"]

${CCW-MUTE-BUTTON}                  //android.widget.ToggleButton[@text="Mute"]
${CCW-SPEAKER-BUTTON}               //android.widget.ToggleButton[@text="Speaker"]
${CCW-MOVE-BUTTON}                  //android.widget.Button[@text="Move"]
${CCW-KEYPAD-BUTTON}                //android.widget.Button[@text="KEYPAD"]
${CCW-MORE-BUTTON}                  //android.widget.Button[@text="More"]
${CCW-ENDCALL-BUTTON}               //android.widget.Button[@resource-id="com.unify.osmo:id/EndCallBtn"]

#***       Incoming CCW page when user is called
${INCOMING-STATUS-FIELD}                //android.widget.TextView[@text="Incoming call"]

${INCOMING-DESK-BUTTON}                 //android.widget.Button[@resource-id="com.unify.osmo:id/sendToDeskBtn"]
${INCOMING-CELL-BUTTON}                 //android.widget.Button[@resource-id="com.unify.osmo:id/sendToCellBtn"]
${INCOMING-VOICEMAIL-BUTTON}            //android.widget.Button[@resource-id="com.unify.osmo:id/ToVoicemailBtn"]

${INCOMING-ANSWER-BUTTON}               //android.widget.Button[@resource-id="com.unify.osmo:id/AnswerBtn"]
${INCOMING-DECLINE-BUTTON}              //android.widget.Button[@resource-id="com.unify.osmo:id/DeclineBtn"]

#***       Call In Progress Page
${INPROGRESS-STATUS-FIELD}              //android.widget.TextView[@text="Call in progress"]

${INPROGRESS-MUTE-BUTTON}               //android.widget.Button[@resource-id="com.unify.osmo:id/MuteBtn"]
${INPROGRESS-SPEAKER-BUTTON}            //android.widget.Button[@resource-id="com.unify.osmo:id/SpeakerBtn"]
${INPROGRESS-SPEAKER-BUTTON}            //android.widget.Button[@resource-id="com.unify.osmo:id/MoveBtn"]
${INPROGRESS-KEYPAD-BUTTON}             //android.widget.Button[@resource-id="com.unify.osmo:id/DialpadBtn"]
${INPROGRESS-MORE-BUTTON}               //android.widget.Button[@resource-id="com.unify.osmo:id/MoreBtn"]

${INPROGRESS-ENDCALL-BUTTON}            //android.widget.Button[@resource-id="com.unify.osmo:id/EndCallBtn"]


*** Keywords ***

Sign In User
    #Run Keyword If                     ${CHECKIN}'=='True'        Click Element     ${SIGNIN-SIGNOFF-BUTTON}        #Daca butonul de Sign in pe OFF il trec pe ON
    #...     ELSE                       Capture Page Screenshot     user-logged
    Wait Until Element Is Visible       ${SIGNIN-SIGN-BUTTON}
    Click Element                       ${SIGNIN-SIGN-BUTTON}
    Sleep                               3s

#Sign In First User
   #Login With First User
    #Sign In User
Go To Journal Page
    Wait Until Element Is visible       ${SIGNIN-JOURNAL-TAB}
    Click Element                       ${SIGNIN-JOURNAL-TAB}

Delete All Journal Records                                                  #   Deleting all journal records before every test

    #Run Keyword If                      '${REL-VISIBLE}'=='True'        Click Element     ${CCW-ENDCALL-BUTTON}
    Sleep                               3s
    Capture Page Screenshot
    Go To Journal Page
    Sleep                               1s
    Wait Until Element Is Visible       ${JOURNAL-MORE-MENIU}
    Click Element                       ${JOURNAL-MORE-MENIU}
    Sleep                               1s
    Wait Until Element Is Visible       ${JOURNAL-MORE-DELETE-ALL-FIELD}
    Click Element                       ${JOURNAL-MORE-DELETE-ALL-FIELD}
    Sleep                               1s
    Wait Until Element Is Visible       ${JOURNAL-YES-ALL-BUTTON}
    Click Element                       ${JOURNAL-YES-ALL-BUTTON}

Compare Call Icons
    [Arguments]      ${Reference_Image_Path}    ${Test_Image_Path}    ${Allowed_Threshold}

Check Journal Records
    [arguments]                         ${expected_lines}               #   Cate intrari de jurnal ar trebui sa fie generate in urma testului
    Go To Journal Page
    Xpath Should Match X Times          //android.widget.RelativeLayout[@resource-id="com.unify.osmo:id/LinearLayout01"]     ${expected_lines}     error = "Journal not as expected!"
    Check Eyes Region                   //android.widget.ImageView[@resource-id="com.unify.osmo:id/ImageView01"]   336  336


Check Outgoing CCW
    [Arguments]                 ${dialdigits}
    ${name-var}     AppiumLibrary.Get Element Attribute       //android.widget.TextView[@resource-id="com.unify.osmo:id/name"]    text
    ${str-digits}       Convert To String   (${dialdigits})                                       #     Convert LONG dialed digits to string
    ${get-last-5}       Get Substring        ${str-digits}    -6  -1                                #     Extract last 5 digits from dialdigits
    ${osmo-name}        Catenate    OSMO     ${get-last-5}
    ${persi-name}       Catenate    PERSI   4K     ${get-last-5}
    Capture Page Screenshot
    Element Text Should Be      ${CCW-DIALING-FIELD}      Dialing     message="Displayed Dialing Status is NOT OK"
    Element Text Should Be      ${CCW-NUMBER-FIELD}    ${get-last-5}        message = "Dialed Number is NOT OK'
    Run Keyword If              '${name-var}'=='${persi-name}'      Log    Displayed PERSI Name is OK found ${name-var} should be ${persi-name}
    ...     ELSE IF             '${name-var}'=='${osmo-name}'       Log    Displayed OSMO Name is OK found ${name-var} should be ${osmo-name}
    ...     ELSE                Log     "Displayed Called Name is NOT OK"

Calling From Dialpad
    [Arguments]         ${dialdigits}

    Wait Until Element Is visible       ${SIGNIN-DIAL-TAB}
    Click Element                       ${SIGNIN-DIAL-TAB}
    Sleep                               1s
    Wait Until Element Is visible       ${DIALPAD-DIALDIGITS-FIELD}
    Clear Text                          ${DIALPAD-DIALDIGITS-FIELD}
    Input Text                          ${DIALPAD-DIALDIGITS-FIELD}    ${dialdigits}
    Click Element                       ${DIALPAD-DIAL-BUTTON}
    Sleep                               2s
    Check Outgoing CCW                  ${dialdigits}


Answering Incoming Call From OSMO
    Wait Until Element Is visible       ${INCOMING-ANSWER-BUTTON}
    Click Element                       ${INCOMING-ANSWER-BUTTON}
    Sleep                               2s

Release call from OSMO
    Wait Until Element Is visible       ${INPROGRESS-ENDCALL-BUTTON}
    Click Element                       ${INPROGRESS-ENDCALL-BUTTON}
