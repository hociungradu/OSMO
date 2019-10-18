*** Settings ***
Documentation    Basic Variables and login function
Library         AppiumLibrary
Library         String

*** Variables ***
${APP-PACKAGE}                      com.unify.osmo
${APP-MAIN-ACTIVITY}                com.sen.osmo.ui.Disclaimer

${APPIUM-URL-DEVICE1}               http://127.0.0.1:4723/wd/hub
${APPIUM-URL-DEVICE2}               http://127.0.0.1:4725/wd/hub

${UUID-DEVICE1}                     32006b29475b1699
${UUID-DEVICE2}                     5200302dee9b5425

#*** Users details

${OSMO-USER1-NAME}                  +4026110220020
${USER1-PERSI-NAME}                 OSMO 20020
${OSMO-USER2-NAME}                  +4026110220021
${USER2-PERSI-NAME}                 OSMO 20021
${PASSWORD}                         OSMO3210
${CELLNUMBER1}                      +402665598200
${CELLNUMBER2}                      +402665598201
#*** Server settings for Voice Only mode
${SERVER}                           82.79.17.87:5061


#*** Disclaimer Page
${AGREE-ULA-BUTTON}                 id=com.unify.osmo:id/eulaWebView

#*** User Page
${USER-SIGNIN-SWITCH}               id=com.unify.osmo:id/switch1
${USER-ACCOUNT-FIELD}               //android.widget.TextView[@text="Account"]

#*** Account Page
${ACCOUNT-SUBSCRIBER-FIELD}         //android.widget.TextView[@text="Subscriber"]
${SUBSCRIBER-EDIT-FIELD}            //android.widget.EditText[@resource-id="android:id/edit"]
${EDIT-OK-BUTTON}                   //android.widget.Button[@text="OK"]
${ACCOUNT-PASSWORD-FIELD}           //android.widget.TextView[@text="Password"]
${PASSWORD-EDIT-FIELD}              //android.widget.EditText[@resource-id="android:id/edit"]
${ACCOUNT-REMEMBER-ON-SWITCH}       //android:id/switch_widget[@text="On"]
${ACCOUNT-REMEMBER-OFF-SWITCH}      //android:id/switch_widget[@text="Off"]
${ACCOUNT-CELLNUMBER-FIELD}         //android.widget.TextView[@text="Cell Number"]
${CELLNUMBER-EDIT-FIELD}            //android.widget.EditText[@resource-id="android:id/edit"]
${ACCOUNT-SERVER-FIELD}             //android.widget.TextView[@text="Server Address"]
${SERVER-EDIT-FIELD}                //android.widget.EditText[@resource-id="android:id/edit"]
${ACCOUNT-SAVE-BUTTON}              //android.widget.Button[@text="SAVE"]
${ACCOUNT-CANCEL-BUTTON}            //android.widget.Button[@text="CANCEL"]

${VISIBLE}                          Run Keyword And Return Status      Wait Until Element Is Visible     ${ACCOUNT-SAVE-BUTTON}     1s

*** Keywords ***
Open Osmo Application
    [Arguments]     ${APPIUM-URL}   ${DEVICE}   ${PORT}
    Open Application    ${APPIUM-URL}  newCommandTimeout=0   platformName=Android  skipDeviceInitialization=true  deviceName=${DEVICE}   udid=${DEVICE}     appPackage=${APP-PACKAGE}  appActivity=${APP-MAIN-ACTIVITY}  systemPort=${PORT}   noReset=true   automationName=UiAutomator2
Open Osmo Application On First Device
    Open Osmo Application       ${APPIUM-URL-DEVICE1}   ${UUID-DEVICE1}     8201
Open Osmo Application On Second Device
    Open Osmo Application       ${APPIUM-URL-DEVICE2}   ${UUID-DEVICE2}     8202

Login With User
    [Arguments]     ${subscriber}    ${userpassword}   ${cellnumber}      ${server}
    Wait Until Element Is Visible       ${USER-ACCOUNT-FIELD}
    Click Element                       ${USER-ACCOUNT-FIELD}
    Wait Until Element Is Visible       ${ACCOUNT-SUBSCRIBER-FIELD}
    Click Element                       ${ACCOUNT-SUBSCRIBER-FIELD}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Clear Text                          ${SUBSCRIBER-EDIT-FIELD}
    Input Text                          ${SUBSCRIBER-EDIT-FIELD}    ${subscriber}
    Click Element                       ${EDIT-OK-BUTTON}
    Wait Until Element Is Visible       ${ACCOUNT-PASSWORD-FIELD}
    Click Element                       ${ACCOUNT-PASSWORD-FIELD}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Input Text                          ${PASSWORD-EDIT-FIELD}     ${userpassword}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Click Element                       ${EDIT-OK-BUTTON}
    Wait Until Element Is Visible       ${ACCOUNT-CELLNUMBER-FIELD}
    Click Element                       ${ACCOUNT-CELLNUMBER-FIELD}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Clear Text                          ${CELLNUMBER-EDIT-FIELD}
    Input Text                          ${CELLNUMBER-EDIT-FIELD}     ${cellnumber}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Click Element                       ${EDIT-OK-BUTTON}
    Wait Until Element Is Visible       ${ACCOUNT-SERVER-FIELD}
    Click Element                       ${ACCOUNT-SERVER-FIELD}
    Wait Until Element Is Visible       ${EDIT-OK-BUTTON}
    Clear Text                          ${SERVER-EDIT-FIELD}
    Input Text                          ${SERVER-EDIT-FIELD}     ${server}
    Click Element                       ${EDIT-OK-BUTTON}
    Run Keyword If                      '${VISIBLE}'=='True'        Click Element     ${ACCOUNT-SAVE-BUTTON}
    ...     ELSE                        Go Back


Login With First User
    Login With User                     ${OSMO-USER1-NAME}        ${PASSWORD}       ${CELLNUMBER1}       ${SERVER}

Login With Second User
    Login With User                     ${OSMO-USER2-NAME}        ${PASSWORD}       ${CELLNUMBER2}       ${SERVER}