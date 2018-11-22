Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://tpgj5f4zj2.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Get Avenger by Id

Given path 'avengers','aaaa-bbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark' }