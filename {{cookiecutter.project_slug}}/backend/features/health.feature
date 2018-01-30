# Created by yann.piquet at 30/11/2017
Feature: Health check
  As ops
  I want to check if the service is running

  Scenario: Health check
    Given i am not logged in
    When i prepare a request to /api/1.0/health/
      And i send the request using GET
    Then the return code is 200