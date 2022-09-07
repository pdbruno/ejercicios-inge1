!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/5/2022 21:29:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] executesInLessThan: 50 * millisecond
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/5/2022 21:30:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney] executesInLessThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/5/2022 21:45:47'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self 
		assertThat: [ customerBook addCustomerNamed: ''] 
		failsWith: Error 
		checkingThatInTheEnd: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/5/2022 21:47:07'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
	assertThat: [ customerBook removeCustomerNamed: 'Paul McCartney' ] 
	failsWith: NotFound 
	checkingThatInTheEnd: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)  ]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/6/2022 17:03:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self assertThatAfterCustomerAditionAndSuspentionAndModification: [:aCustomerBook :onlyCustomer | ] numberOfActiveCustomersEqual: 0 AndNumberOfSuspendedCustomersEqual: 1 AndNumberOfCustomersEqual: 1 AndCustomerShouldRemain: true
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/6/2022 17:01:13'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self assertThatAfterCustomerAditionAndSuspentionAndModification: [:aCustomerBook :onlyCustomer | aCustomerBook removeCustomerNamed: onlyCustomer] numberOfActiveCustomersEqual: 0 AndNumberOfSuspendedCustomersEqual: 0 AndNumberOfCustomersEqual: 0 AndCustomerShouldRemain: false


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/6/2022 16:35:48'!
test07CanNotSuspendAnInvalidCustomer
	
	self assertCantSuspendCustomer: 'George Harrison' onBookWithCustomerNamed: 'John Lennon' afterBeingModifiedWith: [:aCustomerBook |]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pdb 9/6/2022 16:36:59'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
	
	johnLennon := 'John Lennon'.
	
	self assertCantSuspendCustomer: johnLennon onBookWithCustomerNamed: johnLennon afterBeingModifiedWith: [:aCustomerBook | aCustomerBook suspendCustomerNamed: johnLennon]
! !


!CustomerBookTest methodsFor: 'timeMeasurement' stamp: 'pdb 9/5/2022 21:28:02'!
assertThat: aBlock executesInLessThan: aDuration
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aDuration! !


!CustomerBookTest methodsFor: 'failureAssertion' stamp: 'pdb 9/6/2022 16:30:40'!
assertCantSuspendCustomer: aCustomerToSuspend onBookWithCustomerNamed: anInitialCustomer afterBeingModifiedWith: aBlockThatModifiesBook

	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: anInitialCustomer.
	aBlockThatModifiesBook value: customerBook.
	
	self 
		assertThat: [ customerBook suspendCustomerNamed: aCustomerToSuspend] 
		failsWith: CantSuspend 
		checkingThatInTheEnd: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: anInitialCustomer) ]! !

!CustomerBookTest methodsFor: 'failureAssertion' stamp: 'pdb 9/5/2022 21:44:30'!
assertThat: aBlockThatFails failsWith: anErrorType checkingThatInTheEnd: finalAssertions
	[ aBlockThatFails value.
	self fail ]
		on: anErrorType 
		do: [ :anError | finalAssertions value: anError ]! !


!CustomerBookTest methodsFor: 'consistentBehaviorAssertions' stamp: 'pdb 9/6/2022 16:56:30'!
assertThatAfterCustomerAditionAndSuspentionAndModification: aBlockThatModifiesACustomerBook numberOfActiveCustomersEqual: numberOfActiveCustomers AndNumberOfSuspendedCustomersEqual: numberOfSuspendedCustomers AndNumberOfCustomersEqual: numberOfCustomers AndCustomerShouldRemain: shouldRemain

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.	
		
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	aBlockThatModifiesACustomerBook value: customerBook value: paulMcCartney.
	
	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.
	shouldRemain 
		ifTrue: [self assert: (customerBook includesCustomerNamed: paulMcCartney)]
		ifFalse:[self deny: (customerBook includesCustomerNamed: paulMcCartney)]
	

! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'pdb 9/6/2022 17:53:17'!
customerIsActive: aName

	^active includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'pdb 9/6/2022 17:53:34'!
customerIsSuspended: aName

	^suspended includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'pdb 9/6/2022 17:54:11'!
includesCustomerNamed: aName

	^(self customerIsActive: aName) or: [ self customerIsSuspended: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 22:57:32'!
addCustomer: aName toClass: aCustomerClass 

	aCustomerClass add: aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 22:58:52'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	self addCustomer: aName toClass: active ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 17:17:04'!
numberOfCustomers
	
	^self numberOfActiveCustomers  + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 22:51:37'!
removeCustomerNamed: aName 

	^self removeCustomerNamed: aName fromClass: active ifAbsent: 
	[^self removeCustomerNamed: aName fromClass: suspended ifAbsent: [^ NotFound signal]]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 22:50:24'!
removeCustomerNamed: aName fromClass: aCustomerClass ifAbsent: aBlock

	^aCustomerClass remove: aName ifAbsent: aBlock
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'pdb 9/6/2022 23:03:15'!
suspendCustomerNamed: aName 
	
	(self customerIsActive: aName) ifFalse: [^CantSuspend signal].
	
	self removeCustomerNamed: aName fromClass: active ifAbsent: [].
	
	self addCustomer: aName toClass: suspended 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
