*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/store/order

${id}     102
${petID}    173218101
${quantity}    2
${shipDate}    2024-11-27T17:38:01.934+0000
${status}    placed
${complete}    true

*** Test Cases ***
Post pedido
    ${body}    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}    shipDate=${shipDate}    status=${status}    complete=${complete}

    ${response}    POST    url=${url}   json=${body}
    ${response_body}    Set Variable    ${response.json()}    
    Log To Console    ${response_body}
    
    Status Should Be    200
   
   Should Be Equal    ${response_body}[id]    ${{int($id)}}
   Should Be Equal    ${response_body}[petId]    ${{int($petID)}}
   Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
   Should Be Equal    ${response_body}[shipDate]    ${shipDate}
   Should Be Equal    ${response_body}[status]    ${status}

Get pedido  
    ${response}    GET    ${{$url + '/' + $id}}
    
    ${response_body}    Set Variable    ${response.json()}

    Log To Console    ${response_body}

    Status Should Be    200

    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[petId]    ${{int($petID)}}
    Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
    Should Be Equal    ${response_body}[shipDate]    ${shipDate}
    Should Be Equal    ${response_body}[status]    ${status}

Delete pedido
    # Executa
    ${response}    DELETE    ${{$url + '/' + $id}}

    # Valida
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}} 
    Should Be Equal    ${response_body}[type]       unknown 
    Should Be Equal    ${response_body}[message]    ${id} 


