*** Settings ***
Library     JSONLibrary
Library     os
Library     Collections

*** Variables ***


*** Test Cases ***
Test Case 1
    ${json_obj}=   Load Json From File    C:/Users/danitc/PycharmProjects/RobotFrameworkAPITesting/Data/jsondata.json
    ${city_value}=   Get Value From Json    ${json_obj}    $.address.city
    Log To Console    ${city_value[0]}
    Should Be Equal    ${city_value[0]}    Nara

    ${number_value}=   Get Value From Json    ${json_obj}    $.phoneNumbers[1].number
    Log To Console     ${number_value[0]}
    Should Be Equal    ${number_value[0]}    0123-4567-8910
