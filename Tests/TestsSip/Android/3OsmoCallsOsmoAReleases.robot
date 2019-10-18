*** Settings ***
Library         AppiumLibrary
Resource        ../../../Resources/Sip_Res/Android/sip-res.robot
Resource        ../../../Resources/Sip_Res/Android/sip-calls-res.robot

Test Teardown       Run Keywords    Delete All Journal Records
...                 AND     Close All Applications

*** Test Cases ***

3OsmoCallsOsmoAReleases

    Open Osmo Application on First Device
    Open Osmo Application on Second Device
    Sign In User
    Switch Application      1
    Sign In User

    Calling From Dialpad      20021
    Switch Application      2
    Answering Incoming Call From OSMO
    Switch Application      1
    Release call from OSMO
    Sleep                   1s


