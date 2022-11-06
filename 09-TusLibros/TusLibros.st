09-TusLibros/TusLibros.st!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreInterfaceTest category: 'TusLibros'!
TestCase subclass: #StoreInterfaceTest
	instanceVariableNames: 'interface testObjectsFactory debitBehavior timeShift'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pdb 11/3/2022 20:43:58'!
test01ValidIdAndPasswordCreatesCartSuccessfully

	| cartId |
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	self assert: (interface listCart: cartId) isEmpty! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'pdb 11/3/2022 21:08:38'!
test02InvalidIdAndPasswordThrowsError

	self should: [interface createCartWithId: self invalidClientId andPassword: self invalidClientPassword.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface incorrectAuthenticationErrorMessage.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 17:25:46'!
test03AddToCartAddsItemSuccesfully

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
	self assert: (interface listCart: cartId) equals: (Dictionary new add: testObjectsFactory itemSellByTheStore -> 4; yourself).! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 18:55:18'!
test04TryingToListInvalidCartIdThrowsError

	self should: [interface listCart: testObjectsFactory invalidCartId.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface invalidCartIdErrorMessage.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/6/2022 18:34:20'!
test05CheckoutCartReturnsTransactionId

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	

	
	self assert: (interface checkOutCart: cartId 
		withCcn: testObjectsFactory validCcn 
		withCced: testObjectsFactory validCced 
		withCco: testObjectsFactory validCco) 
	equals: 1.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 18:20:28'!
test06CheckoutWithInvalidCcnThrowsError

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
	self should: [interface checkOutCart: cartId 
		withCcn: testObjectsFactory invalidCcn 
		withCced: testObjectsFactory validCced 
		withCco: testObjectsFactory validCco.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface invalidCcnErrorMessage.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 18:54:13'!
test07CheckoutWithInvalidCartIdThrowsError

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
		debitBehavior := [ :anAmount :aCreditCard | ].
	
	self should: [interface checkOutCart: testObjectsFactory invalidCartId
		withCcn: testObjectsFactory validCcn 
		withCced: testObjectsFactory validCced 
		withCco: testObjectsFactory validCco.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface invalidCartIdErrorMessage.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 19:04:54'!
test08CheckoutWithInvalidCcedThrowsError

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	self should: [interface checkOutCart: cartId
		withCcn: testObjectsFactory validCcn 
		withCced: testObjectsFactory invalidCced 
		withCco: testObjectsFactory validCco.] raise: Error - MessageNotUnderstood withMessageText: Cashier canNotChargeAnExpiredCreditCardErrorMessage.! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/4/2022 19:09:00'!
test09CheckoutWithInvalidCcoThrowsError

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
		debitBehavior := [ :anAmount :aCreditCard | ].
	
	self should: [interface checkOutCart: cartId
		withCcn: testObjectsFactory validCcn 
		withCced: testObjectsFactory validCced 
		withCco: testObjectsFactory invalidCco.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface invalidCardCcoToLongErrorMessage .! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/6/2022 18:11:12'!
test10AddToCartInvalidAfter31Minutes

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	
	
	self advance31Mins.

	self should: [interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface cartLifetimeTimeoutErrorMessage .! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/6/2022 18:10:43'!
test11ListCartInvalidAfter31Minutes

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
	self advance31Mins.

	self should: [interface listCart: cartId.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface cartLifetimeTimeoutErrorMessage .! !

!StoreInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ms 11/6/2022 18:15:47'!
test12CheckoutCartInvalidAfter31Minutes

	| cartId |
	
	cartId := interface createCartWithId: self validClientId andPassword: self validClientPassword.
	interface addToCart: cartId book: testObjectsFactory itemSellByTheStore withQuantity: 4.
	
	self advance31Mins.

	self should: [interface checkOutCart: cartId 
		withCcn: testObjectsFactory validCcn 
		withCced: testObjectsFactory validCced 
		withCco: testObjectsFactory validCco.] raise: Error - MessageNotUnderstood withMessageText: StoreInterface cartLifetimeTimeoutErrorMessage .! !


!StoreInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'ms 11/6/2022 17:37:52'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.
	interface := StoreInterface withMP: self clientAuthenticator: self andCatalog: testObjectsFactory defaultCatalog andClockService: self.
	debitBehavior := [ :anAmount :aCreditCard | ].
	timeShift := Duration zero.! !


!StoreInterfaceTest methodsFor: 'support' stamp: 'ms 11/6/2022 18:03:39'!
advance30Mins
	timeShift  := Duration minutes: 31! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'ms 11/6/2022 18:03:42'!
advance31Mins
	timeShift  := Duration minutes: 31! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 20:56:37'!
authenticateClientId: aClientId andPassword: aPassword 
	^aClientId = self validClientId  and: [aPassword = self validClientPassword ]! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 20:44:55'!
createCatalog
	self shouldBeImplemented.! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'ms 11/4/2022 17:59:05'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 21:09:46'!
invalidClientId
	^'cuca'! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 21:10:04'!
invalidClientPassword
	^'monga'.! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'ms 11/6/2022 17:51:03'!
now
	^DateAndTime now + timeShift.! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 20:42:27'!
validClientId
	^'catramado'! !

!StoreInterfaceTest methodsFor: 'support' stamp: 'pdb 11/3/2022 20:41:00'!
validClientPassword
	
	^'culiiiii'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'pdb 11/3/2022 21:03:02'!
items

	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'id createdAt cart clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'ms 11/6/2022 18:21:15'!
initializeWithCart: aCart at: aTimestamp forClient: aClientId
	id := Random new next.
	cart := aCart.
	createdAt := aTimestamp.
	clientId :=aClientId! !


!CartSession methodsFor: 'accessing' stamp: 'ms 11/6/2022 17:43:58'!
cart
	^cart! !

!CartSession methodsFor: 'accessing' stamp: 'ms 11/6/2022 17:43:22'!
cartId
	^id ! !

!CartSession methodsFor: 'accessing' stamp: 'ms 11/6/2022 18:30:51'!
clientId
	^clientId! !

!CartSession methodsFor: 'accessing' stamp: 'ms 11/6/2022 17:51:33'!
createdAt
	^createdAt copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'ms 11/6/2022 18:21:41'!
withCart: aCart at: aTimestamp forClient: aClientId
	^self new initializeWithCart: aCart at: aTimestamp forClient: aClientId! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'ms 11/6/2022 18:05:16'!
assertIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration ccn cco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'ms 11/4/2022 18:27:17'!
initializeExpiringOn: aMonth withCcn: aCcn andCco: aCco   
	
	expiration := aMonth.
	ccn := aCcn.
	cco := aCco! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'ms 11/4/2022 18:34:10'!
assertValidCcn: aCcn
	((aCcn size = 16) and: [(aCcn allSatisfy: [:aChar | aChar isDigit])]) ifFalse: [self error: self invalidCcnErrorMessage]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'ms 11/4/2022 18:28:41'!
expiringOn: aMonth withCcn: aCcn andCco: aCco   

	self assertValidCcn: aCcn.
	
	^self new initializeExpiringOn: aMonth withCcn: aCcn andCco: aCco! !


!CreditCard class methodsFor: 'error messages' stamp: 'ms 11/4/2022 18:34:51'!
invalidCcnErrorMessage
	^'Invalid credit card number'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreInterface category: 'TusLibros'!
Object subclass: #StoreInterface
	instanceVariableNames: 'merchantProcessor clientAuthenticator carts salesBook catalog cartSessions idCounter clockService clientsTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterface methodsFor: 'initialization' stamp: 'ms 11/6/2022 18:31:38'!
initializeWithMP: aMerchantProcessor clientAuthenticator: aClientAuthenticator andCatalog: aCatalog andClockService: aClockService  
	merchantProcessor := aMerchantProcessor.
	clientAuthenticator := aClientAuthenticator.
	clockService := aClockService.
	catalog := aCatalog.
	cartSessions := Dictionary new.
	salesBook := OrderedCollection new.
	clientsTransactions := Dictionary new.! !


!StoreInterface methodsFor: 'interface' stamp: 'ms 11/6/2022 18:14:03'!
addToCart: aCartId book: aBook withQuantity: aQuantity 
	|cartSession|
	cartSession := cartSessions at: aCartId.
	self assertTimeout: cartSession.
	cartSession cart add: aQuantity of: aBook.! !

!StoreInterface methodsFor: 'interface' stamp: 'ms 11/6/2022 18:33:08'!
checkOutCart: aCartId withCcn: aCcn withCced: aCced withCco: aCco 
	
	| creditCard cashier cartSession |
	
	self assertValidCco: aCco.
	
	cartSession := cartSessions at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorMessage ].
	self assertTimeout: cartSession.
	creditCard := CreditCard expiringOn: aCced withCcn: aCcn andCco: aCco.
	cashier := Cashier toCheckout: cartSession cart charging: creditCard throught: merchantProcessor on: DateAndTime now registeringOn: salesBook .
	
	cashier checkOut.
	
	(clientsTransactions at: cartSession clientId 
	ifAbsent: [clientsTransactions at: cartSession clientId put: OrderedCollection new]) add: (Random new next) -> salesBook last.
	^(clientsTransactions at: cartSession clientId ) last key
	! !

!StoreInterface methodsFor: 'interface' stamp: 'ms 11/6/2022 18:22:03'!
createCartWithId: aClientId andPassword: aPassword 
	|cartSession|
	self assertCorrectClientId: aClientId andPassword: aPassword.
	cartSession := CartSession withCart: (Cart acceptingItemsOf: catalog) at: clockService now forClient: aClientId. 
	
	cartSessions add: ((cartSession cartId)->cartSession).
	^cartSession cartId.! !

!StoreInterface methodsFor: 'interface' stamp: 'ms 11/6/2022 18:03:18'!
listCart: aCartId 
	
	| cartSession |
	
	cartSession := cartSessions at: aCartId ifAbsent: [self error: self class invalidCartIdErrorMessage ].
	

	self assertTimeout: cartSession.
	
	^cartSession cart items 
		inject: (Dictionary new)
		into: [ :aDict :item | 
			aDict at: item put: (aDict at: item ifAbsent: [0]) + 1. aDict
		].! !


!StoreInterface methodsFor: 'authentication' stamp: 'pdb 11/3/2022 20:57:16'!
assertCorrectClientId: aString andPassword: aString2 
	(clientAuthenticator authenticateClientId: aString andPassword: aString2) ifFalse: [self error: self class incorrectAuthenticationErrorMessage].! !


!StoreInterface methodsFor: 'testing' stamp: 'ms 11/4/2022 19:07:53'!
assertValidCco: aCco 
	
	(aCco size > 30) ifTrue: [self error: self class invalidCardCcoToLongErrorMessage]! !


!StoreInterface methodsFor: 'assertions' stamp: 'ms 11/6/2022 17:57:36'!
assertTimeout: aCartSession 

	((aCartSession createdAt + (Duration minutes: 30)) < clockService now) ifTrue: [self error: self class cartLifetimeTimeoutErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreInterface class' category: 'TusLibros'!
StoreInterface class
	instanceVariableNames: ''!

!StoreInterface class methodsFor: 'instance creation' stamp: 'ms 11/6/2022 17:21:16'!
withMP: aMerchantProcessor clientAuthenticator: aClientAuthenticator andCatalog: aCatalog andClockService: aClockService  

	^self new initializeWithMP: aMerchantProcessor 
			clientAuthenticator: aClientAuthenticator 
			andCatalog: aCatalog 
			andClockService: aClockService ! !


!StoreInterface class methodsFor: 'error description' stamp: 'ms 11/6/2022 17:45:22'!
cartLifetimeTimeoutErrorMessage
	^'No puede usar un carrito despues de 30 minutos de su creacion'! !

!StoreInterface class methodsFor: 'error description' stamp: 'pdb 11/3/2022 21:09:21'!
incorrectAuthenticationErrorMessage
	^'Invalid id or password'.! !

!StoreInterface class methodsFor: 'error description' stamp: 'ms 11/4/2022 19:08:16'!
invalidCardCcoToLongErrorMessage
	
	^'Card CCO is to long'! !

!StoreInterface class methodsFor: 'error description' stamp: 'ms 11/4/2022 17:34:48'!
invalidCartIdErrorMessage
	^'Invalid Cart Id'! !

!StoreInterface class methodsFor: 'error description' stamp: 'ms 11/4/2022 18:19:48'!
invalidCcnErrorMessage
	^'Invalid credit card number'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 19:00:49'!
expiredCreditCard
	
	^CreditCard expiringOn: self invalidCced withCcn: self validCcn andCco: self validCco! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 18:54:45'!
invalidCartId
	^-1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 19:01:53'!
invalidCced
	^(Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 18:21:27'!
invalidCcn
	^'abc'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 19:05:35'!
invalidCco
	^'abc;slkjdflaskjfglakjfamsdnfkasnflkjgl;ksjdlf;kgjls;dfkjgl;sdkjfgl;skdjfgl;kj'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 19:02:58'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self validCced withCcn: self validCcn andCco: self validCco! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 18:21:59'!
validCced
	^(Month month: self today monthIndex year: self today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 18:55:39'!
validCcn
	^'4567891098765432'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 11/4/2022 18:22:14'!
validCco
	^'Martin Saied'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
