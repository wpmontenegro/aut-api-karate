@REQRES
Feature: User Management Example

  Background:
    Given url baseUrl
    * configure headers = { 'x-api-key': '#(apiKey)' }

  @GET @PATH_PARAMS
  Scenario Outline: Get information from an individual user with response success
    Given path 'api/users/<id>'
    When method GET
    * karate.embed(response, 'Plain text')
    Then status 200
    * match $ == read("classpath:schemas/getSingleUserSchema.json")
    * def expected = {id: <id>, email: '<email>', first_name: '<first_name>',last_name: '<last_name>', avatar: '<avatar>'}
    * match $.data == expected
    Examples:
      | id | email                  | first_name | last_name | avatar                                  |
      | 1  | george.bluth@reqres.in | George     | Bluth     | https://reqres.in/img/faces/1-image.jpg |

  @GET @QUERY_PARAMS
  Scenario Outline: Get information from users by page with response success
    Given path 'api/users'
    And param page = <page>
    When method GET
    * karate.embed(response, 'Plain text')
    Then status 200
    * match $ == read("classpath:schemas/getUsersSchema.json")
    * table expected
      | page   | per_page   | total   | total_pages   |
      | <page> | <per_page> | <total> | <total_pages> |
    * match $ contains expected[0]
    * match each $.data contains {id: '#number'}
    Examples:
      | page | per_page | total | total_pages |
      | 2    | 6        | 12    | 2           |

  @POST
  Scenario Outline: Create user with response success
    Given path 'api/users'
    * def body = read("classpath:templates/postUserBody.json")
    * set body.name = "<name>"
    * set body.job = "<job>"
    * print body
    And request body
    When method POST
    * karate.embed(response, 'Plain text')
    Then status 201
    * match $ == read("classpath:schemas/postUserSchema.json")
    * match $ contains {name: <name>, job: '<job>'}
    Examples:
      | name     | job    |
      | morpheus | leader |

  @PUT
  Scenario Outline: Update user information with response success
    Given path 'api/users/<id>'
    * def body = read("classpath:templates/postUserBody.json")
    * set body.name = "<name>"
    * set body.job = "<job>"
    * print body
    And request body
    When method PUT
    * karate.embed(response, 'Plain text')
    Then status 200
    * match $ == read("classpath:schemas/putUserSchema.json")
    * match $ contains {name: <name>, job: '<job>'}
    Examples:
      | id | name     | job           |
      | 2  | morpheus | zion resident |

  @DELETE
  Scenario Outline: Delete user with response success
    Given path 'api/users/<id>'
    When method DELETE
    * karate.embed(response, 'Plain text')
    Then status 204
    * match response == ''
    Examples:
      | id |
      | 2  |

  @GET @HEADER_TOKEN
  Scenario Outline: Get information from an individual user with response success
    Given path 'api/users/<id>'
    * def login = call read("loginExample.feature")
    * configure headers = { Authorization: '#(login.token)' }
    When method GET
    * karate.embed(response, 'Plain text')
    Then status 200
    * match $ == read("classpath:schemas/getSingleUserSchema.json")
    Examples:
      | id |
      | 1  |