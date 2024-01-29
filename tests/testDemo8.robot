*** Settings ***
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}=    https://www.rahulshettyacademy.com/
${book_id}
${book_name}=    RobotFramework

*** Test Cases ***
# & is used when we create a dictionary
Play around Dictionary
    [Tags]    API
    &{data}=    Create Dictionary    name=rahul_shetty    course=robot_framework    website=rahulshettyacademy.com
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name
    Log    ${data}[name]
    ${course_name}=    Get From Dictionary    ${data}    course
    Log    ${course_name}

Add book into the database
    [Tags]    API
    # To make it unique either update isbn or asisle everytime
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=987655    aisle=321097    author=rahulshetty
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID 
    ${book_id}=    Get From Dictionary    ${response.json()}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200    ${response}

Get the book details which you added
    [Tags]    API
    ${get_response}=    Get    ${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]
    # We are providing a index since we got the result in list of dictionary

Delete the book from database
    [Tags]    API
    &{delete_req}=    Create Dictionary    ID=${book_id}
    ${delete_response}=    Post    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_response.json()}
    Should Be Equal As Strings    book is successfully deleted    ${delete_response.json()}[msg]


    

    
    
    

    

    
        



    
    
    



    