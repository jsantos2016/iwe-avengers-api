Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://tpgj5f4zj2.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Should return invalid access

Given path 'avengers', 'any-id'
When method get
Then status 401

Scenario: Should return not found Avenger

Given path 'avengers','not-found-id'
When method get
Then status 404

Scenario: Create Avenger

Given path 'avengers'
And request {name: 'Iron Man - HulkBuster', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man - HulkBuster', secretIdentity: 'Tony Stark' }

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match response == savedAvenger

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

#Given path 'avengers','aaaa-bbbb-cccc-dddd'
#When method delete
#Then status 204

Given path 'avengers'
And request {name: 'Ant Man', secretIdentity: 'Scott Lang'}
When method post
Then status 201
And match response == {id: '#string', name: 'Ant Man', secretIdentity: 'Scott Lang' }

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
When method get
Then status 404

Scenario: Update Avenger

#Given path 'avengers','aaaa-bbbb-cccc-dddd'
#And request {name: 'Iron Man - Hulkbuster', secretIdentity: 'Tony Stark'}
#When method put
#Then status 200
#And match $ == {id: '#string', name: 'Iron Man - Hulkbuster', secretIdentity: 'Tony Stark' }

Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark' }

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And request {name: 'Iron Man (HulkBuster)', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match $ == {id: '#string', name: 'Iron Man (HulkBuster)', secretIdentity: 'Tony Stark' }

Scenario: Must return 400 for invalid update payload

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {secretIdentity: 'Tony Stark'}
When method put
Then status 400

Scenario: Update Avenger return 404

Given path 'avengers','not-found-id'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 404
