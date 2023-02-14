Feature: Articles feature

Background: Set URL
    Given url apiURL
Scenario: DELETE article
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def randomTitle = 'Title-' + now()
    * def newArticleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set newArticleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set newArticleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set newArticleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
    
    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    # And request {"article":{"tagList":[],"title":"#(randomTitle)","description":"about","body":"content"}}
    And request newArticleRequestBody
    When method POST
    Then status 200
    And match response.article.title == newArticleRequestBody.article.title
    * def articleId = response.article.slug
# Delete article
    # Given header Authorization = 'Token ' + token
    Given path 'articles/',articleId
    When method DELETE
    Then status 204
    