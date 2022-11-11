!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/10/2022 21:34:43'!
test01ImportCustomerPersistCorrectDataIntoSession

	| results validCustomer validAddress |
	self importCustomers: (self validData).
	
	results := session selectAllOfType: Customer.
	validCustomer := results detect: [ :aCustomer | aCustomer firstNameEquals: 'Pepe' ] ifNone: [ self fail ].
	validAddress := validCustomer addressAt: 'San Martin' ifNone: [self fail].
	
	self assert: 2 equals: results size.
	
	self assertCustomer: validCustomer 
	withFirstName: 'Pepe' 
	lastName: 'Sanchez' 
	identificationType: 'D'  
	identificationNumber: '22333444' 
	andNumberOfAddresses: 2.
	
	self assertAddress: validAddress 
	withStreetName: 'San Martin' 
	streetNumber: 3322 
	zipCode: 1636 
	province: 'BsAs' 
	town: 'Olivos'.
	
! !


!ImportTest methodsFor: 'assertions' stamp: 'pdb 11/10/2022 21:31:24'!
assertAddress: validAddress withStreetName: aStreetName streetNumber: aStreetNumber zipCode: aZipCode province: aProvince town: aTown     

	self assert: (validAddress streetNameEquals: aStreetName).	
	self assert: (validAddress streetNumberEquals: aStreetNumber).
	self assert: (validAddress zipCodeEquals: aZipCode).
	self assert: (validAddress provinceEquals: aProvince).
	self assert: (validAddress townEquals: aTown).! !

!ImportTest methodsFor: 'assertions' stamp: 'pdb 11/10/2022 21:33:53'!
assertCustomer: validCustomer withFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber andNumberOfAddresses: aNumberOfAddresses

	self assert: (validCustomer firstNameEquals: aFirstName).
	self assert: (validCustomer lastNameEquals: aLastName).
	self assert: ( validCustomer identificationTypeEquals:anIdentificationType).
	self assert: (  validCustomer identificationNumberEquals: anIdentificationNumber).
	self assert: aNumberOfAddresses equals: validCustomer numberOfAddresses! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'pdb 11/10/2022 18:26:23'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'pdb 11/10/2022 18:26:50'!
tearDown

	^ session close! !


!ImportTest methodsFor: 'support' stamp: 'pdb 11/10/2022 18:43:28'!
importCustomers: aStream
	(ImportCustomers from: aStream into: session) value.
	
	! !

!ImportTest methodsFor: 'support' stamp: 'pdb 11/10/2022 18:36:25'!
validData

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !

!Address methodsFor: 'province' stamp: 'pdb 11/10/2022 21:17:40'!
provinceEquals: aProvince

	^province = aProvince! !


!Address methodsFor: 'street' stamp: 'pdb 11/10/2022 19:00:15'!
isAt: aStreetName

	^streetName = aStreetName 
	
	! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'pdb 11/10/2022 21:18:00'!
streetNameEquals: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !

!Address methodsFor: 'street' stamp: 'pdb 11/10/2022 21:18:12'!
streetNumberEquals: aStreetNumber

	^streetNumber = aStreetNumber ! !


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !

!Address methodsFor: 'town' stamp: 'pdb 11/10/2022 21:18:30'!
townEquals: aTown

	^town = aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !

!Address methodsFor: 'zip code' stamp: 'pdb 11/10/2022 21:18:39'!
zipCodeEquals: aZipCode

	^zipCode = aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'pdb 11/10/2022 18:53:33'!
addressAt: anAddressName ifNone: aNoneBlock

	^addresses detect: [ :anAddress | anAddress isAt: anAddressName] ifNone: aNoneBlock.! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'pdb 11/10/2022 18:55:23'!
numberOfAddresses
	^addresses size.! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'pdb 11/10/2022 21:21:14'!
firstNameEquals: aName

	^firstName = aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !

!Customer methodsFor: 'name' stamp: 'pdb 11/10/2022 21:21:22'!
lastNameEquals: aLastName

	^lastName = aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'pdb 11/10/2022 21:21:32'!
identificationNumberEquals: anIdentificationNumber

	^identificationNumber = anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !

!Customer methodsFor: 'identification' stamp: 'pdb 11/10/2022 21:21:40'!
identificationTypeEquals: anIdentificationType

	^identificationType = anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #ImportCustomers category: 'CustomerImporter'!
Object subclass: #ImportCustomers
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomers methodsFor: 'initialization' stamp: 'pdb 11/10/2022 18:38:50'!
initializeFrom: anAStream into: aSession
	session := aSession.
	stream := anAStream.! !


!ImportCustomers methodsFor: 'evaluating' stamp: 'pdb 11/10/2022 19:05:27'!
value

	| newCustomer line |
	line := stream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := stream nextLine. ].
	session commit.
stream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomers class' category: 'CustomerImporter'!
ImportCustomers class
	instanceVariableNames: ''!

!ImportCustomers class methodsFor: 'instance creation' stamp: 'pdb 11/10/2022 18:38:49'!
from: anAStream into: aSession
	^self new initializeFrom: anAStream into: aSession! !
