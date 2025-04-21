*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://httpbin.org
${ENDPOINT}     /cookies/set?name=value

*** Test Cases ***
Test Headers
    Create Session    headerSession    ${BASE_URL}
    ${response}=        GET On Session    headerSession    ${ENDPOINT}
    Log To Console    ${response.headers}

    ${contentTypeValue}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${contentTypeValue}    application/json

    ${serverValue}=    Get From Dictionary    ${response.headers}    Server
    Should Be Equal    ${serverValue}    gunicorn/19.9.0

Test Cookies
    Create Session    headerSession    ${BASE_URL}
    ${response}=        GET On Session    headerSession    ${ENDPOINT}
    Log To Console    ${response.cookies}
