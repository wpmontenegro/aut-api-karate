@THIRD_PARTIES
Feature: User Management with third integration Example

  Background:
    Given url baseUrl

  @POST @CALL_AUTH0
  Scenario Outline: Create user with Auth0 as intermediate
    Given path 'api/users'
    * def auht0 = call read("classpath:features/auth0Example.feature@USER") {email: '<email>'}
    * def body = read("classpath:templates/postUserBody.json")
    * set body.name = auht0.userName
    * set body.job = "<job>"
    * print body
    And request body
    When method POST
    * karate.embed(response, 'Plain text')
    Then status 201
    * def schema = read("classpath:schemas/postUserSchema.json")
    * match $ == schema
    * def expected = {name: '#(auht0.userName)', job: '<job>'}
    * match $ contains expected
    Examples:
      | email                         | job    |
      | williammontenegro4d@gmail.com | leader |
