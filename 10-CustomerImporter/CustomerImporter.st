!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 19:42:11'!
test01ImportSuccessful

	CustomerImporter valueFrom: self validImportData into: session.

	self assertAmountOfCustomersImportedEquals: 2.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 18:48:37'!
test02LineThatIsNotCustomerNorAddressFails

	self should: [CustomerImporter valueFrom: self invalidImportDataWithInvalidLine into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | self assert: anException messageText equals: CustomerImporter invalidLineTypeErrorMessage. self assertAmountOfCustomersImportedEquals: 0]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 18:58:02'!
test03FileWithOnlyNewLineFails

	self should: [CustomerImporter valueFrom: self invalidImportDataWithOnlyNewLineFails into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: CSVImporter emptyLineErrorMessage. 
			self assertAmountOfCustomersImportedEquals: 0]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 19:09:12'!
test04FileStartingWithAddressFails

	self should: [CustomerImporter valueFrom: self invalidImportDataStartingWithAddress into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: AbstractCustomer cannotAddAddressToNullCustomerErrorMessage . 
			self assertAmountOfCustomersImportedEquals: 0]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 19:21:35'!
test05FileMissingFieldsInCustomerRecordFails

	self should: [CustomerImporter valueFrom: self invalidImportMissingFieldsInCustomerRecord into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: CustomerImporter badCustomerRecordErrorMessage . 
			self assertAmountOfCustomersImportedEquals: 0]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 19:33:37'!
test06FileMissingFieldsInAddressRecordFails

	self should: [CustomerImporter valueFrom: self invalidImportMissingFieldsInAddressRecord into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: CustomerImporter badAddressRecordErrorMessage . 
			self assertAmountOfCustomersImportedEquals: 1]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 20:06:46'!
test07FileExcedingFieldsInAddressRecordFails

	self should: [CustomerImporter valueFrom: self invalidImportExcedingFieldsInAddressRecord into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: CustomerImporter badAddressRecordErrorMessage . 
			self assertAmountOfCustomersImportedEquals: 1]

	
! !

!ImportTest methodsFor: 'tests' stamp: 'pdb 11/14/2022 20:07:52'!
test08FileExcedingFieldsInCustomerRecordFails

	self should: [CustomerImporter valueFrom: self invalidImportExcedingFieldsInCustomerRecord into: session.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anException | 
			self assert: anException messageText equals: CustomerImporter badCustomerRecordErrorMessage . 
			self assertAmountOfCustomersImportedEquals: 0]

	
! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'pdb 11/14/2022 18:36:51'!
assertAmountOfCustomersImportedEquals: anAmountOfCustomers

	^ self assert: anAmountOfCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 19:00:51'!
invalidImportDataStartingWithAddress

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 18:39:42'!
invalidImportDataWithInvalidLine
		^ ReadStream on:
'X,Pepe,Sanchez,D,22333444'



! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 18:51:54'!
invalidImportDataWithOnlyNewLineFails
	^ReadStream on: (String with: Character newLineCharacter )! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 20:08:57'!
invalidImportExcedingFieldsInAddressRecord
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San, Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 20:09:25'!
invalidImportExcedingFieldsInCustomerRecord
		^ ReadStream on:
'C,Pepe, Pepardo,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 19:33:25'!
invalidImportMissingFieldsInAddressRecord
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,
C,Pepe,Bruno,D,223444'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 19:22:56'!
invalidImportMissingFieldsInCustomerRecord
	^ReadStream on: 'C,'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 19:42:01'!
invalidImportWithAdjacentCommas
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pdb 11/14/2022 19:38:29'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #AbstractCustomer category: 'CustomerImporter'!
Object subclass: #AbstractCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AbstractCustomer class' category: 'CustomerImporter'!
AbstractCustomer class
	instanceVariableNames: ''!

!AbstractCustomer class methodsFor: 'error descriptions' stamp: 'pdb 11/14/2022 19:08:52'!
cannotAddAddressToNullCustomerErrorMessage
	^'Cannot add address to a null customer'! !


!classDefinition: #Customer category: 'CustomerImporter'!
AbstractCustomer subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #NullCustomer category: 'CustomerImporter'!
AbstractCustomer subclass: #NullCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!NullCustomer methodsFor: 'as yet unclassified' stamp: 'pdb 11/14/2022 19:07:17'!
addAddress: anAddress
	
	self error: super class cannotAddAddressToNullCustomerErrorMessage! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'session readStream line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:58:39'!
createRecord
	line isEmpty ifTrue: [self error: self class emptyLineErrorMessage ].
	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:20:46'!
hasNextLine

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:21:43'!
value

	[ self hasNextLine ] whileTrue: [
		self createRecord.
		self importRecord.
 	].

	! !


!CSVImporter methodsFor: 'nil' stamp: 'pdb 11/14/2022 18:22:32'!
importRecord
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'error description' stamp: 'pdb 11/14/2022 18:58:17'!
emptyLineErrorMessage
	^'Found empty line'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'pdb 11/14/2022 19:07:54'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.
	newCustomer := NullCustomer new.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 19:31:02'!
importAddress
	(record size = 6) ifFalse: [self error: self class badAddressRecordErrorMessage ].
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 19:26:39'!
importCustomer
	(record size = 5) ifFalse: [self error: self class badCustomerRecordErrorMessage ].
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:49:10'!
importRecord

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	
	self error: self class invalidLineTypeErrorMessage.
	
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:19:45'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'pdb 11/14/2022 18:20:03'!
isCustomerRecord
	^ record first = 'C'
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'pdb 11/14/2022 19:17:50'!
badAddressRecordErrorMessage
	
	^'Address line has wrong format'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'pdb 11/14/2022 19:17:38'!
badCustomerRecordErrorMessage
	
	^'Customer line has wrong format'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'pdb 11/14/2022 18:49:10'!
invalidLineTypeErrorMessage
	
	^'Formato de linea incorrecto'! !


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
