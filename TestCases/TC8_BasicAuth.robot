*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${base_url}    https://httpbin.org
${endpoint}    /basic-auth/user/passwd

*** Test Cases ***
Basic Auth Test
    ${auth}=    Create List         user        passwd
    Create Session    basicAuthSession      ${base_url}     auth=${auth}
    ${response}=        GET On Session    basicAuthSession    ${endpoint}
    Log To Console    ${response.content}
    Should Be Equal As Strings   ${response.status_code}    200

    AIzaSyABUzZotwvnz0wKmEnJkTHFV2OYlMl_eOU