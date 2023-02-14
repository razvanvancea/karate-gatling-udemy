@debug
Feature: HomePage app

Background: Define URL
    Given url 'https://conduit.productionready.io/api/'

@debug @smoke
Scenario: Get all tags
    Given path 'tags'
    When method GET
    Then status 200
    And match response.tags contains 'welcome'
    And match response.tags !contains 'razvan'
    And match response.tags contains any ['fish', 'dog', 'welcome']
    # And match response.tags !contains any ['fish', 'dog', 'welcome']
    # And match response.tags contains only ['fish']
    And match response.tags contains ['welcome', 'introduction']
    And match response.tags  == "#array"
    And match each response.tags  == "#string"

Scenario: Get first 10 articles
    # Given url 'https://api.realworld.io/api/articles?limit=10&offset=0'
    # Given param limit = 10
    # Given param offset = 0
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles == "#[10]"
    # And match response.articlesCount == 500
    # And match response.articlesCount != 100
    # And match response == {"articles": "#array", "articlesCount": 500}
    # And match response.articles[0].createdAt contains '2020'
    And match response.articles[*].favoritesCount contains 0
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '##string'

Scenario: Get first 10 articles - schema validation
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    # "createdAt":"#? isValidTime(_)",
            # "updatedAt":"#? isValidTime(_)",
    And match each response.articles ==
    """
        {
            "slug":"#string",
            "title":"#string",
            "description":"#string",
            "body":"#string",
            "tagList": '#array',
            "createdAt":"#? timeValidator(_)",
            "updatedAt":"#? timeValidator(_)",
            "favorited":'#boolean',
            "favoritesCount": '#number',
            "author":{
                "username":"#string",
                "bio": '##string',
                "image":"#string",
                "following":'#boolean'
            }
        } 
    """
        