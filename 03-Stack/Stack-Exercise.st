!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'sentence finder initialization' stamp: 'ms 9/18/2022 17:09:37'!
inSentences: anArray findPrefix: aPrefix

	anArray do: [ :phrase | stack push: phrase].
	
	finder := SentenceFinderByPrefix withStack: stack.
	
	^finder find: aPrefix
	
	
	
	


	


	



	

	
	



! !


!SentenceFinderByPrefixTest methodsFor: 'failure assertion' stamp: 'pdb 9/19/2022 14:34:56'!
assertThat: aBlockThatFails failsWith: anErrorType checkingThatInTheEnd: finalAssertions
	[ aBlockThatFails value.
	self fail ]
		on: anErrorType 
		do: [ :anError | finalAssertions value: anError ]! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:09:34'!
setUp
	
	stack := OOStack new.


	


	



	

	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 16:56:47'!
test01ShouldReturnOrderedCollection
	
	self assert: ((self inSentences: #('Hola') findPrefix: 'Hola') class = OrderedCollection)
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 16:57:22'!
test02FindReturnsEmptyWhenNoMatch
	
	self assert: ((self inSentences: #('Hola') findPrefix: 'Chau') isEmpty)
	

	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:07:56'!
test03FindReturnsCorrectWithExactMatch

	self assert: ((self inSentences: #('Hola') findPrefix: 'Hola') size = 1)

	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:08:25'!
test04FindReturnsMultipleMatches

	| matches |
	
	matches := self inSentences: #('Hola como estas' 'Hola mucho gusto' 'Holanda' 'Patricio Bruno') findPrefix: 'Hol'.
	self assert: matches size = 3.
	self assert: (matches at: 1) = 'Holanda'.
	self assert: (matches at: 2) = 'Hola mucho gusto'.
	self assert: (matches at: 3) = 'Hola como estas'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:03:13'!
test05FindReturnsCorrectWithPartialMatch

	| matches |
	
	matches := self inSentences: #('Hola como estas') findPrefix: 'Hol'.
	self assert: matches size = 1.
	self assert: (matches at: 1) = 'Hola como estas'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:04:22'!
test06FindIsCaseSensitive

	| matches |
	
	matches := self inSentences: #('Hola como estas' 'hola mucho gusto' 'holanda' 'Patricio Bruno') findPrefix: 'hol'.
	self assert: matches size = 2.
	self assert: (matches at: 1) = 'holanda'.
	self assert: (matches at: 2) = 'hola mucho gusto'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'pdb 9/19/2022 14:45:23'!
test07FindReturnsTwiceIfFoundTwice

	| matches |

	matches := self inSentences: #('hola mucho gusto' 'hola mucho gusto' 'Patricio Bruno') findPrefix: 'hola'.
	self assert: matches size = 2.
	self assert: (matches at: 1) = 'hola mucho gusto'.
	self assert: (matches at: 2) = 'hola mucho gusto'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'pdb 9/19/2022 14:44:59'!
test08StackShouldBeSameAsBefore

	self inSentences: #('hola mucho susto' 'hola mucho gusto' 'holanda' 'Patricio Bruno') findPrefix: 'hola'.
	self assert: stack pop = 'Patricio Bruno'.
	self assert: stack pop = 'holanda'.
	self assert: stack pop = 'hola mucho gusto'.
	self assert: stack pop = 'hola mucho susto'.
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:07:26'!
test09FindReturnsEmptyIfStackIsEmpty

	| matches |
	
	matches := self inSentences: #() findPrefix: 'Chau'.
	self assert: matches isEmpty
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ms 9/18/2022 17:09:15'!
test10FindReturnsNoMatchIfNoPrefix

	| matches |
	
	matches := self inSentences: #('Patricio Cuco Bruno' 'Martin Cuco Saied') findPrefix: 'Cuco'.
	self assert: matches isEmpty
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'pdb 9/19/2022 14:40:25'!
test11PrefixCannotBeEmpty

		self 
		assertThat: [ self inSentences: #() findPrefix: ''] 
		failsWith: Error 
		checkingThatInTheEnd: [ :anError | 
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ].
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'pdb 9/19/2022 14:40:46'!
test12PrefixCannotHaveWhitespaces

		self 
		assertThat: [ self inSentences: #() findPrefix: ' '] 
		failsWith: Error 
		checkingThatInTheEnd: [ :anError | 
			self assert: anError messageText = SentenceFinderByPrefix prefixHasWhitespaceErrorDescription].
	
	



! !


!classDefinition: #OOContainer category: 'Stack-Exercise'!
Object subclass: #OOContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:19:47'!
addLast: anElement
	self subclassResponsabilty! !

!OOContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:19:37'!
removeLast
	self subclassResponsabilty! !


!OOContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:19:55'!
last
	self subclassResponsabilty! !

!OOContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:29:39'!
size
	self subclassResponsabilty! !


!OOContainer methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:46:59'!
initializeWith: aCollection
	self subclassResponsabilty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOContainer class' category: 'Stack-Exercise'!
OOContainer class
	instanceVariableNames: ''!

!OOContainer class methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:17:02'!
withCollection: aCollection
	
	self subclassResponsibility ! !


!OOContainer class methodsFor: 'testing' stamp: 'ms 9/16/2022 19:24:12'!
isForSize: aSize
	
	self subclassResponsibility ! !


!classDefinition: #OOEmptyContainer category: 'Stack-Exercise'!
OOContainer subclass: #OOEmptyContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:26:54'!
addLast: anElement
	
	| newCollection |
	
	newCollection := OrderedCollection new.
	newCollection addLast: anElement. 

	^OOLoadedContainer withCollection: newCollection.
	! !

!OOEmptyContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:14:26'!
removeLast
	self error: OOStack stackEmptyErrorDescription
	! !


!OOEmptyContainer methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:14:05'!
initializeWith: aCollection
	! !


!OOEmptyContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:14:42'!
last
	self error: OOStack stackEmptyErrorDescription
	! !

!OOEmptyContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:29:52'!
size
	^0
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyContainer class' category: 'Stack-Exercise'!
OOEmptyContainer class
	instanceVariableNames: ''!

!OOEmptyContainer class methodsFor: 'testing' stamp: 'ms 9/16/2022 19:24:32'!
isForSize: aSize

	^aSize = 0
	
	! !


!OOEmptyContainer class methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:35:18'!
withCollection: aCollection

	^self new
	
	! !


!classDefinition: #OOLoadedContainer category: 'Stack-Exercise'!
OOContainer subclass: #OOLoadedContainer
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLoadedContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:26:25'!
addLast: anElement

	^self class withCollection: (collection copyWith: anElement)
	! !

!OOLoadedContainer methodsFor: 'operations' stamp: 'ms 9/16/2022 19:22:32'!
removeLast

	collection removeLast.	
	^(OOContainer subclasses detect: [ :aContainerClass | aContainerClass isForSize: collection size]) 
		withCollection: collection copy
	! !


!OOLoadedContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:38:55'!
last
	
	^collection last! !

!OOLoadedContainer methodsFor: 'accessing' stamp: 'ms 9/16/2022 19:30:12'!
size

	^collection size 
	! !


!OOLoadedContainer methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:19:29'!
initializeWith: aCollection
	
	collection := aCollection! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLoadedContainer class' category: 'Stack-Exercise'!
OOLoadedContainer class
	instanceVariableNames: ''!

!OOLoadedContainer class methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:19:05'!
withCollection: aCollection

	^self new initializeWith: aCollection

	! !


!OOLoadedContainer class methodsFor: 'testing' stamp: 'ms 9/16/2022 19:25:02'!
isForSize: aSize

	^aSize > 0

	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'ms 9/16/2022 19:30:45'!
isEmpty
	
	^collection size = 0! !


!OOStack methodsFor: 'operations' stamp: 'ms 9/16/2022 19:33:17'!
pop
	
	| firstElement |
	
	firstElement := self top.
	collection := collection removeLast.
	^firstElement! !

!OOStack methodsFor: 'operations' stamp: 'ms 9/16/2022 19:33:02'!
push: anElement
	
	collection := collection addLast: anElement! !

!OOStack methodsFor: 'operations' stamp: 'ms 9/15/2022 20:48:56'!
size
	
	^collection size! !

!OOStack methodsFor: 'operations' stamp: 'ms 9/16/2022 19:29:11'!
top
	
	^collection last.! !


!OOStack methodsFor: 'initialization' stamp: 'ms 9/16/2022 19:28:27'!
initialize
	collection := OOEmptyContainer new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'evaluating' stamp: 'pdb 9/19/2022 14:43:24'!
find: aPrefix

	| phrase collection |
	
	aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription].
	(aPrefix indexOf: Character space) = 0 ifFalse: [self error: self class prefixHasWhitespaceErrorDescription].
	
	collection := OrderedCollection new.
	stack isEmpty ifTrue: [^collection].
	
	phrase := stack pop.	
	(phrase is: aPrefix substringAt: 1) ifTrue: [collection addLast: phrase].
	
	collection addAllLast: (self find: aPrefix).
	
	stack push: phrase.
	
	^collection
	


! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'ms 9/18/2022 15:33:07'!
initializeWith: aStack

	stack := aStack


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'pdb 9/19/2022 14:16:28'!
emptyPrefixErrorDescription
	
	^ 'El prefijo no puede ser vac�o'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'pdb 9/19/2022 14:25:58'!
prefixHasWhitespaceErrorDescription
	
	^ 'El prefijo no puede tener espacios en blanco'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'ms 9/18/2022 15:43:19'!
withStack: aStack

	^self new initializeWith: aStack

! !
