!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 18:15:30'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOccurrences: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 18:17:53'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemNotSellByTheStore withOccurrences:  2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 18:17:09'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOccurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'pdb 10/31/2022 18:52:53'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'pdb 10/31/2022 18:45:56'!
defaultCatalog
	
	^TusLibrosCatalog with: (Dictionary new add: self itemSellByTheStore -> 10; yourself )  ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'mockMP'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 22:12:27'!
createCard
	
	^CreditCard withNumber: '00000000000000' andExpirationDate: Date tomorrow forOwner: 'lala'! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 22:16:20'!
createCardFor: aDate 
	^CreditCard withNumber: '00000000000000' andExpirationDate: aDate forOwner: 'lala'

	! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 18:52:32'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 21:37:39'!
createCashier: aCart
	
	^Cashier withCatalog: self defaultCatalog forCart: aCart withMerchantProcessor: mockMP.! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 18:48:21'!
defaultCatalog
	^ TusLibrosCatalog with: self defaultPriceList ! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 19:45:07'!
defaultPriceList
	^ Dictionary new add: 'item1'->4; add: 'item2'->3; add: 'item3'->1; yourself.	! !

!CashierTest methodsFor: 'support' stamp: 'pdb 10/31/2022 18:26:25'!
itemsSoldByTheStore
	^ self defaultPriceList keys! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'pdb 10/31/2022 21:52:02'!
setUp
	mockMP := MockMerchantProcessor new.! !


!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 19:30:56'!
test01CanNotCheckoutEmptyCart
	
	| cart |
	
	cart := self createCart.

	self should: [self createCashier: cart]  raise: Error - MessageNotUnderstood withMessageText: Cashier cannotInitializeWithEmptyCartErrorMessage 
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 19:32:41'!
test02CheckoutCartWithOneItemReturnsTotal

	| cart cashier card product |
	cart := self createCart.
	product := self defaultCatalog items at: 1.
	cart add: product.
	cashier := self createCashier: cart.
	card := self createCard.
	self assert: (self defaultCatalog priceOf: product) equals: (cashier checkoutWithCard: card).
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 19:45:27'!
test03CheckoutCartWithManyItemsReturnsTotal

	| cart cashier card product1 product2|
	cart := self createCart.
	product1 := self defaultCatalog items at: 1.
	product2 := self defaultCatalog items at: 2.
	cart add: product1; add: product2.
	cashier := self createCashier: cart.
	card := self createCard.
	self assert: ((self defaultCatalog priceOf: product1) + (self defaultCatalog priceOf: product2)) equals: (cashier checkoutWithCard: card).
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 22:23:58'!
test04CheckoutCartWithExpiredCardThrowsException

	| cart cashier product1 product2|
	cart := self createCart.
	product1 := self defaultCatalog items at: 1.
	product2 := self defaultCatalog items at: 2.
	cart add: product1; add: product2.
	cashier := self createCashier: cart.
	
	self 
	should: [ cashier checkoutWithCard: MockMerchantProcessor expiredCard ] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier creditCardExpiredErrorMessage. 
						   self deny: mockMP invalidCall ].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 21:51:32'!
test05CheckoutCartWithStolenCardThrowsException

	| cart cashier product1 product2|
	cart := self createCart.
	product1 := self defaultCatalog items at: 1.
	product2 := self defaultCatalog items at: 2.
	cart add: product1; add: product2.
	cashier := self createCashier: cart.
	
	self should: [ cashier checkoutWithCard: MockMerchantProcessor stolenCard ] raise: Error - MessageNotUnderstood withMessageText: MerchantProcessor stolenCardErrorMessage .
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 22:18:40'!
test06CheckoutCartWithFundlessCardThrowsException

	| cart cashier product1 product2|
	cart := self createCart.
	product1 := self defaultCatalog items at: 1.
	product2 := self defaultCatalog items at: 2.
	cart add: product1; add: product2.
	cashier := self createCashier: cart.
	
	self should: [ cashier checkoutWithCard: MockMerchantProcessor noFundsCard ] raise: Error - MessageNotUnderstood 	withMessageText: MerchantProcessor insufficientFundsErrorMessage 	.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pdb 10/31/2022 22:21:44'!
test07CheckoutCartWithExpiredCardDoesNotReachMP

	| cart cashier product1 product2|
	cart := self createCart.
	product1 := self defaultCatalog items at: 1.
	product2 := self defaultCatalog items at: 2.
	cart add: product1; add: product2.
	cashier := self createCashier: cart.
	
	self should: [ cashier checkoutWithCard: MockMerchantProcessor expiredCard ] raise: Error - MessageNotUnderstood 		withExceptionDo: [:anError | ].
	
	! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'pdb 10/31/2022 18:12:59'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'pdb 10/31/2022 19:34:15'!
items

	^items! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'pdb 10/31/2022 18:17:32'!
add: anItem

	^ self add: anItem withOccurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'pdb 10/31/2022 18:13:58'!
add:  anItem withOccurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart catalog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'pdb 10/31/2022 21:21:18'!
initializeWithCatalog: aCatalog forCart: aCart withMerchantProcessor: aMerchantProcessor
	catalog := aCatalog.
	cart := aCart.
	merchantProcessor := aMerchantProcessor ! !


!Cashier methodsFor: 'checkout' stamp: 'pdb 10/31/2022 21:11:50'!
assertCardIsNotCurrentlyExpired: aCard
	
	(aCard isExpiredOn: Date today) ifTrue: [^self error: self class creditCardExpiredErrorMessage ]! !

!Cashier methodsFor: 'checkout' stamp: 'pdb 10/31/2022 21:12:13'!
checkoutWithCard: aCard
	
	| total |
	
	self assertCardIsNotCurrentlyExpired: aCard.
	
	total := self total.
	self debit: total from: aCard.
	
	^total
	
	! !

!Cashier methodsFor: 'checkout' stamp: 'pdb 10/31/2022 21:21:36'!
debit: aQuantity from: aCard 
	merchantProcessor debit: aQuantity from: aCard! !

!Cashier methodsFor: 'checkout' stamp: 'pdb 10/31/2022 19:38:36'!
total
	
	^cart items inject: 0 into: [ :subTotal :anItem | (catalog priceOf: anItem) + subTotal ]
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'pdb 10/31/2022 21:20:39'!
withCatalog: aCatalog forCart: aCart withMerchantProcessor: aMerchantProcessor 

	aCart isEmpty ifTrue: [self error: self cannotInitializeWithEmptyCartErrorMessage].
	^self new initializeWithCatalog: aCatalog forCart: aCart withMerchantProcessor: aMerchantProcessor! !


!Cashier class methodsFor: 'error messages' stamp: 'pdb 10/31/2022 19:26:51'!
cannotInitializeWithEmptyCartErrorMessage
	^ 'No se puede inicializar un cajero con un carrito vacío'! !

!Cashier class methodsFor: 'error messages' stamp: 'pdb 10/31/2022 21:09:25'!
creditCardExpiredErrorMessage
	^'Cannot use an expired credit card.'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate creditCardNumber ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'pdb 10/31/2022 19:58:20'!
expirationDate
	^expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'pdb 10/31/2022 22:15:43'!
number
	^creditCardNumber ! !

!CreditCard methodsFor: 'accessing' stamp: 'pdb 10/31/2022 22:15:56'!
owner
	^creditCardNumber ! !


!CreditCard methodsFor: 'initialization' stamp: 'pdb 10/31/2022 21:03:32'!
initializeWithNumber: aCreditCardNumber andExpirationDate: anExpirationDate forOwner: anOwnerName 

	creditCardNumber := aCreditCardNumber.
	expirationDate := anExpirationDate.
	ownerName := anOwnerName.! !


!CreditCard methodsFor: 'testing' stamp: 'pdb 10/31/2022 22:09:29'!
= aCreditCard 
	
	^(self expirationDate = aCreditCard expirationDate) and:[self number = aCreditCard number] and:[self owner = aCreditCard owner]! !

!CreditCard methodsFor: 'testing' stamp: 'pdb 10/31/2022 21:12:45'!
isExpiredOn: aDate 
	
	^expirationDate  < aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'pdb 10/31/2022 21:35:34'!
withNumber: aCreditCardNumber andExpirationDate: anExpirationDate forOwner: anOwnerName
	"validar el owner name (no vacio post trim) y el credit card number que esperamos que sea un string con longitud 16 y que sean todos digitos"

	^self new initializeWithNumber: aCreditCardNumber andExpirationDate: anExpirationDate forOwner: anOwnerName! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:50:55'!
insufficientFundsErrorMessage
	^'Saldo insuficiente'! !

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:49:54'!
stolenCardErrorMessage
	^'Tarjeta robada'! !


!classDefinition: #MockMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #MockMerchantProcessor
	instanceVariableNames: 'invalidCall'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:53:27'!
debit: anAmount from: aCreditCard
	(aCreditCard = self class stolenCard) ifTrue: [self error: self class stolenCardErrorMessage].
	(aCreditCard = self class noFundsCard) ifTrue: [self error: self class insufficientFundsErrorMessage].
	(aCreditCard isExpiredOn: Date today) ifTrue: [invalidCall  := true].! !

!MockMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:44:36'!
initialize
	invalidCall := false! !

!MockMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:46:06'!
invalidCall
	^invalidCall! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: 'TusLibros'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:42:10'!
expiredCard
	^CreditCard withNumber: '2222222222222222' andExpirationDate: Date yesterday forOwner: 'patooooo'! !

!MockMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:41:39'!
noFundsCard
	^CreditCard withNumber: '2222222222222222' andExpirationDate: Date tomorrow forOwner: 'patooooo'! !

!MockMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 21:40:07'!
stolenCard
	^CreditCard withNumber: '1111111111111111' andExpirationDate: Date tomorrow forOwner: 'patooooo'! !


!classDefinition: #TusLibrosCatalog category: 'TusLibros'!
Object subclass: #TusLibrosCatalog
	instanceVariableNames: 'items renameMe1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCatalog methodsFor: 'initialization' stamp: 'pdb 10/31/2022 18:42:39'!
initializeWith: aDictionaryOfItemsAndPrices 

	items := aDictionaryOfItemsAndPrices.! !


!TusLibrosCatalog methodsFor: 'testing' stamp: 'pdb 10/31/2022 18:52:07'!
includes: anItem
	^items keys includes: anItem! !


!TusLibrosCatalog methodsFor: 'accessing' stamp: 'pdb 10/31/2022 18:43:24'!
items

	^items keys.! !

!TusLibrosCatalog methodsFor: 'accessing' stamp: 'pdb 10/31/2022 19:09:35'!
priceOf: anItem

	^items at: anItem ifAbsent: [self error: 'El producto no se encuentra en el catalogo'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCatalog class' category: 'TusLibros'!
TusLibrosCatalog class
	instanceVariableNames: ''!

!TusLibrosCatalog class methodsFor: 'as yet unclassified' stamp: 'pdb 10/31/2022 18:43:02'!
with: aDictionaryOfItemsAndPrices
	
	^self new initializeWith: aDictionaryOfItemsAndPrices copy.! !
