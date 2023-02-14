Feature: Create Token

Scenario: Create Token
    Given url apiURL
    Given path 'users/login'
    And request {"user": {"email":"#(userEmail)","password":"#(userPassword)"}}
    When method POST
    Then status 200
    * def authToken = response.user.token