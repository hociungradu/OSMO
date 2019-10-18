*** Settings ***
Documentation    Suite description
Library         AppiumLibrary
Library         String
Library         Collections
*** Variables ***

@{osmolist} =   Create List   20020     20021	   20022
@{4klist} =   Create List   20013

*** Test Cases ***
Diverse
    Calling From Dialpad    +4026110220013



*** Keywords ***

Calling From Dialpad
    [Arguments]         ${dialdigits}
    ${str-digits}       Convert To String   (${dialdigits})
    ${get-last-5}       Get Substring        ${str-digits}    -6  -1                                #     Extract last 5 digits from dialdigits
    ${4k-match}         Should Contain Match    ${4klist}     ${get-last-5}
    Run Keyword If      '${4k-match}'=='True'     Log     "Displayed PERSI Name is OK"
    #${Type-Digits}      Evaluate            type(${dialdigits})
    Log                 ${get-last-5}