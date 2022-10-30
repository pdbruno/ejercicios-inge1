!classDefinition: #CartTest category: 'EjercicioTusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'book emptyCatalog filledCatalog cartWithEmptyCatalog cartWithFilledCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioTusLibros'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'pdb 10/30/2022 17:02:57'!
setUp
	book := Book new.
	emptyCatalog := BookCatalog with: OrderedCollection new.
	filledCatalog := BookCatalog with: (OrderedCollection with: book).
	cartWithEmptyCatalog:= Cart withCatalog: emptyCatalog.
	cartWithFilledCatalog:= Cart withCatalog: filledCatalog.! !


!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:02:40'!
test01NewCartIsEmpty

	self assert: cartWithEmptyCatalog isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:04:05'!
test02AddingABookToNewCartLeavesItNonEmpty

	cartWithFilledCatalog add: book.
	self deny: cartWithFilledCatalog isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:07:07'!
test03CanNotAddBookOutsideCatalogToCart
	
	self should: [cartWithEmptyCatalog add: book] raise: Error description: Cart invalidBookErrorMessage.
! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:07:54'!
test04AddingABookAndRemovingItLeavsCartEmpty
	
	cartWithFilledCatalog add: book.
	self deny: cartWithFilledCatalog isEmpty.
	cartWithFilledCatalog remove: book.
	self assert: cartWithFilledCatalog isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:08:18'!
test05CartCanHaveSameBookMultipleTimes
	
	cartWithFilledCatalog add: book.
	cartWithFilledCatalog add: book.

	self assert: (cartWithFilledCatalog ocurrencesOf: book) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:08:58'!
test06CanNotRemoveBookIfNotInCart
	
	self should: [ cartWithFilledCatalog remove: book ] raise: Error withMessageText: Cart invalidBookRemoveErrorMessage! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:23:53'!
test07CartCanAddSameBookMultipleTimes
	
	cartWithFilledCatalog add: book times: 2.

	self assert: (cartWithFilledCatalog ocurrencesOf: book) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'pdb 10/30/2022 17:40:56'!
test08CartCanListContents

	|cart book1 book2 book3|
	
	book1 := Book new.
	book2 := Book new.
	book3 := Book new.
	cart := Cart withCatalog: (BookCatalog with: (OrderedCollection with: book1 with: book2 with: book3)).
	cart add: book1.
	cart add: book2.
	cart add: book3.
	cart add: book1.		
	self assert: (cart contents) equals: (OrderedCollection with: book1 with: book2 with: book3 with: book1).! !


!classDefinition: #Book category: 'EjercicioTusLibros'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioTusLibros'!


!classDefinition: #BookCatalog category: 'EjercicioTusLibros'!
Object subclass: #BookCatalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioTusLibros'!

!BookCatalog methodsFor: 'initialization' stamp: 'pdb 10/27/2022 21:12:28'!
initializeWith: aListOfBooks

	books := aListOfBooks .

! !


!BookCatalog methodsFor: 'testing' stamp: 'pdb 10/27/2022 21:14:25'!
has: aBook 
	
	^books includes: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookCatalog class' category: 'EjercicioTusLibros'!
BookCatalog class
	instanceVariableNames: ''!

!BookCatalog class methodsFor: 'instance creation' stamp: 'pdb 10/27/2022 21:04:52'!
with: anOrderedCollection 
	
	^self new initializeWith: anOrderedCollection ! !


!classDefinition: #Cart category: 'EjercicioTusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'bookCatalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioTusLibros'!

!Cart methodsFor: 'testing' stamp: 'pdb 10/27/2022 21:10:43'!
assertBookInCatalog: aBook 
	
	(bookCatalog has: aBook) ifFalse: [self error: self class invalidBookErrorMessage]! !

!Cart methodsFor: 'testing' stamp: 'pdb 10/27/2022 21:21:01'!
isEmpty
	^items isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'pdb 10/27/2022 21:21:40'!
initializeWithCatalog: aBookCatalog 

	bookCatalog := aBookCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'updating' stamp: 'pdb 10/27/2022 21:22:14'!
add: aBook 
	
	self assertBookInCatalog: aBook.

	items add: aBook.! !

!Cart methodsFor: 'updating' stamp: 'pdb 10/30/2022 17:27:10'!
add: aBook times: aNumberOfTimes 
	aNumberOfTimes timesRepeat: [self add: aBook ].! !

!Cart methodsFor: 'updating' stamp: 'pdb 10/27/2022 21:53:33'!
remove: aBook 
	(items includes: aBook) ifFalse: [self error: self class invalidBookRemoveErrorMessage ].
	items remove: aBook.! !


!Cart methodsFor: 'accessing' stamp: 'pdb 10/30/2022 17:42:22'!
contents
	^items copy! !

!Cart methodsFor: 'accessing' stamp: 'pdb 10/27/2022 21:29:15'!
ocurrencesOf: aBook 
	
	^items occurrencesOf: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'EjercicioTusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'pdb 10/27/2022 21:06:23'!
withCatalog: aBookCatalog 

	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error description' stamp: 'pdb 10/27/2022 21:07:44'!
invalidBookErrorMessage
	^'Can not add a book from outside the catalog'.! !

!Cart class methodsFor: 'error description' stamp: 'pdb 10/27/2022 21:31:12'!
invalidBookRemoveErrorMessage
	
	^'Can not remove book if not in the cart'.! !
