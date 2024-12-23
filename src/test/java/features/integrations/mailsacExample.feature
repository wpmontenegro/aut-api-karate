@MAILSAC @ignore
Feature: Api Mailsac Example

  Background:
    Given url mailsacUrl

  @MESSAGE
  Scenario: Get message with Mailsac
    Given path 'addresses/' + email + '/messages'
    * configure headers = { "Mailsac-Key": '#(apiKey)' }
    When method GET
    * def name = $.[0].savedBy
    * def message = $.[0].subject