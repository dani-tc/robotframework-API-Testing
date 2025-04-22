*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://maps.googleapis.com
${ENDPOINT}       /maps/api/place/details/json
${PLACE_ID}       ChIJj61dQgK6j4AR4GeTYWZsKWw
${API_KEY}        Api  # Replace with your actual API key
${EXPECTED_NAME}  Googleplex

*** Test Cases ***
Verify Place Details By ID
    [Documentation]    Get place details and validate the place name

    Create Session    placesSession    ${BASE_URL}
    ${params}=    Create Dictionary
    ...    place_id=${PLACE_ID}
    ...    fields=name
    ...    key=${API_KEY}

    ${response}=    GET On Session    placesSession    ${ENDPOINT}    params=${params}
    Should Be Equal As Strings    ${response.status_code}    200

    ${json}=    Evaluate    ${response.json()}
    ${name}=    Get From Dictionary    ${json['result']}    name
    Log To Console    Place Name: ${name}
    Should Contain    ${name}    ${EXPECTED_NAME}