*** Settings ***
Documentation    Basic Variables and login function
Library         AppiumLibrary
Library         String

*** Variables ***
${APP-PACKAGE}                          com.unify.osmo
${APP-MAIN-ACTIVITY}                    com.sen.osmo.ui.Disclaimer
${APPIUM-URL-DEVICE1}                   http://127.0.0.1:4723/wd/hub
${APPIUM-URL-DEVICE2}                   http://127.0.0.1:4725/wd/hub

${UUID-DEVICE1}                         32006b29475b1699
${UUID-DEVICE2}                         5200302dee9b5425

#*** Users details
${COMBO-USER1-NAME}                     20020@system
${USER1-PERSI-NAME}                     OSMO 20020
${COMBO-USER2-NAME}                     20021@system
${USER2-PERSI-NAME}                     OSMO 20021
${PASSWORDCOMB}                         Asd123!.
${CELLNUMBER1}                          +402665598200
${CELLNUMBER2}                          +402665598201
${SERVERCOMB}                           https://82.79.17.72:8443









*** Keywords ***
First keyword
    Do something

Second keyword
    Do more
