*** Settings ***
Resource        ../../../Resources/Sip_Res/Android/sip-res.robot
Library         AppiumLibrary
Test Teardown       Run Keywords    Delete All Journal Records
...                 AND     Close All Applications


*** Test Cases ***
1OsmoLogin

    Open Osmo Application on First Device
    Login With First User

    Open Osmo Application on Second Device
    Login With Second User




