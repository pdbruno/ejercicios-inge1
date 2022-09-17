
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:01:19'!
test01ShouldReturnOrderedCollection

	| stack finder |
	
	stack := OOStack new.
	stack push: 'Hola'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	
	self assert: ((finder find: 'Hola') class isKindOf: OrderedCollection)
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:02:15'!
test02FindReturnsEmptyWhenNoMatch

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'Hola'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'Chau'.
	
	self assert: matches isEmpty
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:02:35'!
test03FindReturnsCorrectWithExactMatch

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'Hola'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'Hola'.
	
	self assert: matches size = 1
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:06:30'!
test04FindReturnsMultipleMatches

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'Hola como estas'.
	stack push: 'Hola mucho gusto'.
	stack push: 'Holanda'.
	stack push: 'Patricio Bruno'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'Hol'.
	
	self assert: matches size = 3.
	self assert: (matches at: 1) = 'Holanda'.
	self assert: (matches at: 1) = 'Hola mucho gusto'.
	self assert: (matches at: 1) = 'Hola como estas'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:05:32'!
test06FindIsCaseSensitive

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'Hola como estas'.
	stack push: 'hola mucho gusto'.
	stack push: 'holanda'.
	stack push: 'Patricio Bruno'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'hol'.
	
	self assert: matches size = 2.
	self assert: (matches at: 1) = 'holanda'.
	self assert: (matches at: 2) = 'hola mucho gusto'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:07:49'!
test07FindReturnsTwiceIfFoundTwice

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'hola mucho gusto'.
	stack push: 'hola mucho gusto'.
	stack push: 'holanda'.
	stack push: 'Patricio Bruno'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'hola '.
	
	self assert: matches size = 2.
	self assert: (matches at: 1) = 'hola mucho gusto'.
	self assert: (matches at: 2) = 'hola mucho gusto'.
	
	



! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ms 9/17/2022 18:17:19'!
test08StackShouldBeSameAsBefore

	| stack finder matches |
	
	stack := OOStack new.
	stack push: 'hola mucho susto'.
	stack push: 'hola mucho gusto'.
	stack push: 'holanda'.
	stack push: 'Patricio Bruno'.
	
	finder := SentenceFinderByPrefix withStack: stack.
	matches := finder find: 'hola '.
	
	self assert: finder pop = 'Patricio Bruno'.
	self assert: finder pop = 'holanda'.
	self assert: finder pop = 'hola mucho gusto'.
	self assert: finder pop = 'hola mucho susto'.
	



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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
