*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}   https://reqres.in\
${USER}         2

*** Test Cases ***
Get User Info
    Create Session                testSession    ${BASE_URL}
    ${response}=   GET On Session    testSession    /api/users/${USER}
    #Log To Console                 ${response.status_code}
    #Log To Console                 ${response.content}
    #Log To Console                 ${response.headers}

    #Validations
    ${status_code}=   Convert To String   ${response.status_code}
                      Should Be Equal     ${status_code}    200

    ${body}=          Convert To String   ${response.content}
                      Should Contain      ${body}    Janet

    ${contentTypeValue}=  Get From Dictionary   ${response.headers}     Content-Type
    Should Be Equal    ${contentTypeValue}      application/json; charset=utf-8



