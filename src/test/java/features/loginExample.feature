@REQRES @ignore
Feature: Token Management Example

  Background:
    Given url baseUrl

  @LOGIN
  Scenario: Login user with response success
    Given path '/api/login'
    * def body = read("classpath:templates/loginUserBody.json")
    And request body
    When method POST
    * karate.embed(response, 'Plain text')
    Then status 200
    * def token = $.token
