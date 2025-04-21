*** Settings ***
Library     XML
Library     os
Library     Collections


*** Test Cases ***
Get XML File Response
    ${XML_OBJ}=     Parse Xml    C:/Users/danitc/PycharmProjects/RobotFrameworkAPITesting/Data/xmldata.xml

    # Validations
    ${user_name}=   Get Element Text    ${XML_OBJ}      .//user[1]/name
    Should Be Equal    ${user_name}    John Doe

    ${user_name}=    Get Element    ${XML_OBJ}          .//user[1]/name
    Should Be Equal    ${user_name.text}    John Doe

    Element Text Should Be    ${XML_OBJ}    John Doe    .//user[1]/name

    # Check number of elements
    ${user_count}=   Get Element Count    ${XML_OBJ}     .//user
    Should Be Equal As Integers   ${user_count}    2

    # Check values of child elements
    ${child_elements}=    Get Child Elements    ${XML_OBJ}    .//user[1]
    Should Not Be Empty    ${child_elements}
    ${id}=      Get Element Text    ${child_elements[0]}
    ${name}=      Get Element Text    ${child_elements[1]}
    ${email}=      Get Element Text    ${child_elements[2]}
    ${active}=      Get Element Text    ${child_elements[3]}
    
    Should Be Equal    ${id}    101
    Should Be Equal    ${name}    John Doe
    Should Be Equal    ${email}    john.doe@example.com
    Should Be Equal    ${active}    true
