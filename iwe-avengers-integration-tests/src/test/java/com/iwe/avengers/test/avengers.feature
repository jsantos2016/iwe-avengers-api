Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://tpgj5f4zj2.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Should return not found Avenger

Given path 'avengers','not-found-id'
When method get
Then status 404

Scenario: Get Avenger by Id

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark' }

Scenario: Create Avenger

Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark' }

Scenario: Must return 400 for invalid creation payload

Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400

Scenario: Delete Avenger return 404

Given path 'avengers','not-found-id'
When method delete
Then status 404

Scenario: Delete Avenger

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method delete
Then status 204

Scenario: Put Avenger

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {name: 'Iron Man - Hulkbuster', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match $ == {id: '#string', name: 'Iron Man - Hulkbuster', secretIdentity: 'Tony Stark' }

Scenario: Put Avenger return 400

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {secretIdentity: 'Tony Stark'}
When method put
Then status 400

Scenario: Put Avenger return 404

Given path 'avengers','not-found-id'
And request {name: 'Iron Man - Hulkbuster', secretIdentity: 'Tony Stark1'}
When method put
Then status 404
