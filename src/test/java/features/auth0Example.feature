@AUTH0 @ignore
Feature: Api Auth0 Example

  Background:
    Given url auth0Url

  @TOKEN
  Scenario: Get token with Auth0
    Given path '/oauth/token'
    * def body = read("classpath:templates/getTokenAuth0.json")
    * set body.client_id = clientId
    * set body.client_secret = clientSecret
    * set body.audience = auth0Url + "/api/v2/"
    * set body.grant_type = "client_credentials"
    * print body
    And request body
    When method POST
    * def authorization = response.token_type + " " + response.access_token

  @USER
  Scenario: Search user with Auth0 as intermediate
    Given path '/api/v2/users-by-email'
    * def login = call read("classpath:features/auth0Example.feature@TOKEN")
    * configure headers = { Authorization: '#(login.authorization)' }
    And param email = email
    When method GET
    * def userName = $.[0].nickname