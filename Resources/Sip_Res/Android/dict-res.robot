*** Settings ***
Documentation    Suite description

*** Variables ***
&{userdict}                 user1=20020	    user2=20021		user3=20022   user4=20023 	name1=OSMO 20020   name2=OSMO 20021		name3=OSMO 20022	name4=OSMO 20023


*** Keywords ***
Listare

    ${DIALDIGITS}   Set Variable    55555
    ${PERSI}    Set Variable     OSMO ${DIALDIGITS}
    Log To Console      ${DIALDIGITS}, ${PERSI}

Loop Through Dict
    #&{mydict}    Create Dictionary    a=1    b=2
    :FOR    ${key}    IN    @{userdict.keys()}
    \    Log To Console   ${key} = ${userdict["${key}"]}

Print Dictionary
    &{mydict2}    Create Dictionary     x=5    y=8
    Log To Console      ${mydict2}
    :FOR    ${cheie}    IN    @{mydict2.keys()}
    \    Log To Console   The current key is: ${cheie}
    # there are at least to ways to get the value for that key
    # "Extended variable syntax", e.g. direct access:
    \    Log     The value is: ${mydict2['${cheie}']}
    # or using a keyword from the Collections library:
    \    ${value}=    Get From Dictionary    ${mydict2}    ${key}
    \    Log     The value through Collections is: ${value}