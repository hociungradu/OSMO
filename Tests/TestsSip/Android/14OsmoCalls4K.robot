*** Settings ***
Library         AppiumLibrary
Resource        ../../../Resources/Sip_Res/Android/sip-res.robot
Resource        ../../../Resources/Sip_Res/Android/sip-calls-res.robot

Test Teardown       Run Keywords    Delete All Journal Records
...                 AND     Close All Applications

*** Test Cases ***

14OsmoCalls4K

    Open Osmo Application On Second Device
    Sign In User

    Calling From Dialpad        20013
    Sleep                       3s
    Release call from OSMO
    Check Journal Records       1

