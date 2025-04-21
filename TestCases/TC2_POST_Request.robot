*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     BuiltIn
Library    String

*** Variables ***
${base_url}  https://reqres.in

*** Test Cases ***
Add New User
    Create Session    POSTSession2    ${base_url}
    ${body}=       Create Dictionary      email=eve.holt@reqres.in     password=pistol
    ${header}=       Create Dictionary     Content-Type=application/json; charset=utf-8
    ${response}=   POST On Session     POSTSession2      /api/register     json=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    # Validations
    ${statusCode}=    Convert To String   ${response.status_code}
    Should Be Equal    ${statusCode}    200

    ${res_body}=   Convert To String   ${response.content}
    Should Contain    ${res_body}    "id"
    Should Contain    ${res_body}    "token"