*** Settings ***
Library     XML
Library     os
Library     Collections
Library     RequestsLibrary

*** Variables ***
${BASE_URL}     http://www.7timer.info
${ENDPOINT}     /bin/api.pl?lon=113.17&lat=23.09&product=civil&output=xml

*** Test Cases ***
XML Response Test
    Create Session      xmlSession    ${BASE_URL}
    ${response}=        GET On Session      xmlSession      ${ENDPOINT}
    ${xml_string}=      Convert To String    ${response.content}
    ${xml_obj}=         Parse Xml           ${xml_string}

    # Check single element value
    Element Text Should Be    ${xml_obj}        1    .//data[1]/cloudcover
    
    # Check multiple values
    ${child_Elements}=        Get Child Elements    ${xml_obj}      .//data[1]
    Should Not Be Empty    ${child_Elements}
    ${cloudCover}=  Get Element Text    ${child_Elements[0]}
    ${temp2m}=  Get Element Text    ${child_Elements[4]}
    ${rh2m}=  Get Element Text    ${child_Elements[5]}

    Should Be Equal    ${cloudCover}    1
    Should Be Equal    ${temp2m}    35
    Should Be Equal    ${rh2m}    35%