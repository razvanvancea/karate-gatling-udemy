Feature: SignUp feature

Background: Preconditions
  * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiURL

    Scenario: Sign up test
    # Given def userData = {"email": "#('iamrv'+randomEmail)", "username":"#(randomEmail)"}
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

    # varianta 2 faker in care apelez metoda non statica
    # o evit
    * def jsFunction = 
    """
      function(){
        var DataGenerator = Java.type('helpers.DataGenerator')
        var generator = new DataGenerator()
        return generator.getRandomUsername2()
      }
    """
    * def randomUsername2 = call jsFunction
# sfarsit varianta 2
    Given path 'users'
    And request 
    """
    {"user":
      {"email":"#(randomEmail)",
    "password":"Pswpswpsw.123",
    "username":"#(randomUsername2)"}
    }
    """
    When method POST
    Then status 200
    And match response == 
    """
    {"user":{
      "email":"#(randomEmail)",
      "username":#(randomUsername2),
      "bio":null,
      "image":"#string",
      "token":"#string"
      }
      } 
    """