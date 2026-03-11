@MAILSAC @ignore
Feature: Api Mailsac Example

  Background:
    Given url mailsacUrl

  @MESSAGE
  Scenario: Get message with Mailsac
    Given path 'addresses/' + email + '/messages'
    * configure headers = { "Mailsac-Key": '#(mailsacApiKey)' }
    When method GET
    * def name = $.[0].from[0].name
    * def message = $.[0].subject