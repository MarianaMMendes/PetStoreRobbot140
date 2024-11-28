*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/user

${id}     624818701
${username}    Snoopy01
${firstName}    Mariana
${lastName}    Mendes
${email}    mari.1991@hotmail.com
${password}    123456
${phone}    33991558187
${userStatus}     0

*** Test Cases ***

Post user

    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    
    ...    lastName=${lastName}   email=${email}    password=${password}    phone=${phone}    
    ...    userStatus=${userStatus}

    ${response}    POST    url=${url}    json=${body}

    ${response_body}    Set Variable    ${response.json()}

    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}    
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id} 


Get user
    ${response}    GET    ${{$url + '/' + $username}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200

    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[username]    ${username}
    Should Be Equal    ${response_body}[firstName]    ${firstName}
    Should Be Equal    ${response_body}[lastName]    ${lastName}   
    Should Be Equal    ${response_body}[email]    ${email} 
    Should Be Equal    ${response_body}[password]    ${password} 
    Should Be Equal    ${response_body}[phone]    ${phone}
    Should Be Equal    ${response_body}[userStatus]    ${{int($userStatus)}}  

Put user
    ${body}    Evaluate     json.loads(open('./fixtures/json/user1.json').read())
    
    ${response}    PUT    ${{$url + '/' + $username}}    json=${body}

    ${response_ body}    Set Variable    ${response.json()}

    Log To Console    ${response_ body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}    
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id} 

Delete user
    
    ${response}    DELETE    ${{$url + '/' + $username}}

    ${response_body}    Set Variable    ${response.json()}

    Log To Console    ${response_body}

    Status Should Be    200

    Should Be Equal    ${response_body}[code]    ${{int(200)}}    
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${username}

            