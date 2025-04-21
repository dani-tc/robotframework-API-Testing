*** Settings ***
Library     JSONLibrary
Library     os
Library     Collections
Library     RequestsLibrary

*** Variables ***
${baseURL}      https://restcountries.com
@{EXPECTED_BORDERS}    BGD    BTN    MMR    CHN    NPL    PAK

*** Test Cases ***
Get Country Info
    Create Session    countries     ${baseURL}
    ${response}=      GET On Session   countries    /v3.1/alpha/IN

    # Validate single data
    ${countryName}=   Get Value From Json    ${response.json()}    $[0].name.common
    Log To Console    ${countryName[0]}
    Should Be Equal    ${countryName[0]}     India

    # Single data validation in array
    ${borderName}=   Get Value From Json    ${response.json()}    $[0].borders[0]
    Log To Console    ${borderName[0]}
    Should Be Equal    ${borderName[0]}     BGD

    # Multiple data validation in array
    ${borderName}=   Get Value From Json    ${response.json()}    $[0].borders
    Log To Console    ${borderName[0]}
    Should Contain Any    ${borderName[0]}      PAK     BGD     CHN
    Should Not Contain Any    ${borderName[0]}      ABC     GHJ

    # Using For loop
    Log To Console    Now using LISTS

    FOR    ${code}    IN    @{EXPECTED_BORDERS}
        Should Contain    @{borderName}    ${code}
    END
