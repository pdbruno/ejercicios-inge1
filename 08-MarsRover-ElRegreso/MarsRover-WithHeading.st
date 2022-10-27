!classDefinition: #LoggerListenerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LoggerListenerTest
	instanceVariableNames: 'aMarsRover anExpectedLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggerListenerTest methodsFor: 'setUp' stamp: 'ms 10/27/2022 15:29:15'!
setUp
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	anExpectedLog := OrderedCollection new.! !


!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:31:57'!
assertExpectedLogEqualesLoggerLog: aLogger
	self assert: anExpectedLog equals: aLogger log.
! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:32:17'!
test01ReturnEmptyListIfNothingWasObserved

	| logger |
	
	logger := LoggerListener observes: (OrderedCollection with: MarsRover directionEvent) on: aMarsRover.
	
	aMarsRover process: ''.
	
	self assertExpectedLogEqualesLoggerLog: logger
	! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:33:23'!
test02ReturnListWithOneItemIfMovesOnePosition

	|  logger |
	
	
	logger := LoggerListener observes: (OrderedCollection with: MarsRover positionEvent) on: aMarsRover.
	
	aMarsRover process: 'f'.
	
	anExpectedLog add: '0@1'.
	
	self assertExpectedLogEqualesLoggerLog: logger! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:34:51'!
test03ReturnListWithOneItemIfChangeDirection

	|  logger |
	
	logger := LoggerListener observes: (OrderedCollection with: MarsRover directionEvent) on: aMarsRover.
	
	aMarsRover process: 'l'.
	
	anExpectedLog add: 'West'.
	
	self assertExpectedLogEqualesLoggerLog: logger
	! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:35:35'!
test04ReturnListWithMoreItemIfProcess

	|  logger  |
	
	logger := LoggerListener 
		observes: (OrderedCollection with: MarsRover directionEvent with: MarsRover positionEvent) 
		on: aMarsRover.
	
	aMarsRover process: 'lflfrbrf'.
	
	anExpectedLog addLast: 'West'; addLast: '-1@0'; addLast: 'South'; addLast: '-1@ -1'; addLast: 'West'; addLast: '0@ -1'; addLast: 'North'; addLast: '0@0'.
	
	self assertExpectedLogEqualesLoggerLog: logger
	! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:38:09'!
test05ReturnListWithMoreItemIfProcessButJustDirection

	|  logger  |
	
	
	logger := LoggerListener observes: (OrderedCollection with: MarsRover directionEvent) on: aMarsRover.
	
	aMarsRover process: 'lflfrbrf'.

	anExpectedLog addLast: 'West'; addLast: 'South'; addLast: 'West'; addLast: 'North'.
	
	self assertExpectedLogEqualesLoggerLog: logger
	
	! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:39:12'!
test06ReturnListWithMoreItemIfProcessButJustPosition

	| logger |
	
	
	logger := LoggerListener observes: (OrderedCollection with: MarsRover positionEvent) on: aMarsRover.
	
	aMarsRover process: 'lflfrbrf'.

	anExpectedLog addLast: '-1@0'; addLast: '-1@ -1'; addLast: '0@ -1'; addLast: '0@0'.
	
	self assertExpectedLogEqualesLoggerLog: logger
	! !

!LoggerListenerTest methodsFor: 'as yet unclassified' stamp: 'ms 10/27/2022 15:39:57'!
test07ReturnEmptyListIfProcessButListeningNothing

	|  logger |
	
	logger := LoggerListener observes: (OrderedCollection new) on: aMarsRover.
	
	aMarsRover process: 'lflfrbrf'.
	
	self assertExpectedLogEqualesLoggerLog: logger
	
	! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MultipleListenersTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MultipleListenersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MultipleListenersTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:24:11'!
test01MarsRoverHandlesMultipleListeners
	
	| marsRover window logger expectedLog|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	
	window := WindowListener 
		observesDirectionAndPositionOn: marsRover.
		
	logger := LoggerListener observes: (OrderedCollection with: MarsRover directionEvent with: MarsRover positionEvent ) on: marsRover.
	
	marsRover process: 'rf'.
	
	self assert: '1@0' equals: window position.
	self assert: 'Heading East' equals: window heading.
	
	expectedLog := OrderedCollection new.
	expectedLog addLast: 'East'; addLast: '1@0'.
	
	self assert: expectedLog equals: logger log.
	! !


!classDefinition: #WindowListenerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowListenerTest
	instanceVariableNames: 'aMarsRover anExpectedHeading anExpectedPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:44:48'!
assertExpectedPositionEquals: aPosition andHeading: aHeading
	self assert: anExpectedHeading equals: aHeading.
	self assert: anExpectedPosition equals: aPosition.
! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:47:16'!
assertExpectedWindow: aWindow
	self assert: anExpectedHeading equals: aWindow heading.
	self assert: anExpectedPosition equals: aWindow position.
! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:41:37'!
setUp
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	anExpectedHeading := ''.
	anExpectedPosition := ''.! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:47:23'!
test01ReturnEmptyHeaderAndPositionIfNothingWasObserved

	| window |
		
	window := WindowListener observesDirectionOn: aMarsRover .
	
	aMarsRover process: ''.
	
	self assertExpectedWindow: window.! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:47:28'!
test02ReturnNewPositionIfRoverMovesForward

	| window |
		
	window := WindowListener observesPositionOn: aMarsRover.
	
	aMarsRover process: 'f'.
	
	anExpectedPosition := '0@1'.
	
	self assertExpectedWindow: window.! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:49:53'!
test03ReturnNewHeadingIfRoverTurnsRight

	| window |
	
	window := WindowListener observesDirectionOn: aMarsRover.
	
	aMarsRover process: 'r'.
	
	anExpectedHeading := 'Heading East'.
	
	self assertExpectedWindow: window.
! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:49:48'!
test04ReturnNewHeadingAndNewPositionIfRoverTurnsRightAndForward

	|  window |
	
	window := WindowListener 
		observesDirectionAndPositionOn: aMarsRover.
	
	aMarsRover process: 'rf'.
	
	anExpectedHeading := 'Heading East'.
	anExpectedPosition := '1@0'.
	
	self assertExpectedWindow: window.! !

!WindowListenerTest methodsFor: 'tests' stamp: 'ms 10/27/2022 15:49:42'!
test05ReturnOnlyLastHeadingAndNewPositionIfRoverMoves

	|  window |
	
	window := WindowListener observesDirectionAndPositionOn: aMarsRover.
	
	aMarsRover process: 'rf'.
	
	anExpectedHeading := 'Heading East'.
	anExpectedPosition := '1@0'.
	self assertExpectedWindow: window.

	aMarsRover process: 'br'.
	
	anExpectedHeading := 'Heading South'.
	anExpectedPosition := '0@0'.
	self assertExpectedWindow: window.
! !


!classDefinition: #LoggerListener category: 'MarsRover-WithHeading'!
Object subclass: #LoggerListener
	instanceVariableNames: 'arrayOfEventNames marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggerListener methodsFor: 'accessing' stamp: 'ms 10/24/2022 20:44:22'!
log

	^log

! !


!LoggerListener methodsFor: 'initialization' stamp: 'ms 10/24/2022 21:26:23'!
initializeObserving: anArrayOfEventNames on: aMarsRover
	log := OrderedCollection new.
	anArrayOfEventNames do: [:anEventName | aMarsRover subscribeToEvents: anEventName handleWith: [:aValue | log add: aValue]].
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoggerListener class' category: 'MarsRover-WithHeading'!
LoggerListener class
	instanceVariableNames: ''!

!LoggerListener class methodsFor: 'instance creation' stamp: 'ms 10/24/2022 20:24:42'!
observes: anArrayOfEventNames on: aMarsRover

	"validar nombres de los parametros"
	^self new initializeObserving: anArrayOfEventNames on: aMarsRover

! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head subscribersByEvent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ms 10/26/2022 18:23:53'!
initializeAt: aPosition heading: aHeadingType

	subscribersByEvent := Dictionary new.
	subscribersByEvent 
		add: self class positionEvent -> OrderedCollection new; 
		add: self class directionEvent -> OrderedCollection new.

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'ms 10/24/2022 20:53:22'!
headEast
	
	head := MarsRoverHeadingEast for: self
! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/24/2022 21:07:26'!
rotateLeft
	
	head rotateLeft.
	self emitEvent: self class directionEvent with: head printString.
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'ms 10/24/2022 21:07:24'!
rotateRight
	
	head rotateRight.
	self emitEvent: self class directionEvent with: head printString.
! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'ms 10/24/2022 21:08:21'!
moveBackward

	head moveBackward.
	self emitEvent: self class positionEvent with: position printString.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/24/2022 20:52:23'!
moveForward
	
	head moveForward.
	self emitEvent: self class positionEvent with: position printString.! !

!MarsRover methodsFor: 'moving' stamp: 'ms 10/24/2022 20:46:51'!
moveNorth

	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'events-registering' stamp: 'ms 10/27/2022 15:01:56'!
subscribeToEvents: anEventName handleWith: aBlockClosure 
	
	| closures |
	
	closures := subscribersByEvent at: anEventName.
	closures add: aBlockClosure.
! !


!MarsRover methodsFor: 'events-triggering' stamp: 'ms 10/26/2022 18:26:31'!
emitEvent: anEventName with: aValue 
	
	(subscribersByEvent at: anEventName) do: [:aSubscriber | aSubscriber value: aValue].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!MarsRover class methodsFor: 'event names' stamp: 'ms 10/24/2022 20:43:11'!
directionEvent
	^'direction'! !

!MarsRover class methodsFor: 'event names' stamp: 'ms 10/24/2022 20:43:32'!
positionEvent
	^'position'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'printing' stamp: 'ms 10/24/2022 20:57:20'!
printString
	
	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'ms 10/24/2022 20:57:33'!
printString
	
	^'East'! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'ms 10/24/2022 21:06:13'!
printString
	
	^'North'! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'ms 10/24/2022 21:06:00'!
printString
	
	^'South'! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'ms 10/24/2022 21:05:53'!
printString
	
	^'West'! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #WindowListener category: 'MarsRover-WithHeading'!
Object subclass: #WindowListener
	instanceVariableNames: 'arrayOfEventNames marsRover heading position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowListener methodsFor: 'initialization' stamp: 'ms 10/27/2022 15:03:30'!
initialize

	heading := ''.
	position := ''.

! !

!WindowListener methodsFor: 'initialization' stamp: 'ms 10/27/2022 15:14:51'!
initializeObservingDirectionAndPositionOn: aMarsRover

	self initialize.
	aMarsRover subscribeToEvents: MarsRover directionEvent handleWith: [:aDirection | self handleDirectionEvent: aDirection].
	aMarsRover subscribeToEvents: MarsRover positionEvent handleWith: [:aPosition | self handlePositionEvent: aPosition].

! !

!WindowListener methodsFor: 'initialization' stamp: 'ms 10/27/2022 15:15:33'!
initializeObservingDirectionOn: aMarsRover

	self initialize.
	aMarsRover subscribeToEvents: MarsRover directionEvent handleWith: [:aDirection | self handleDirectionEvent: aDirection ].

! !

!WindowListener methodsFor: 'initialization' stamp: 'ms 10/27/2022 15:13:20'!
initializeObservingPositionOn: aMarsRover

	self initialize.
	aMarsRover subscribeToEvents: MarsRover positionEvent handleWith: [:aPosition | self handlePositionEvent: aPosition].

! !


!WindowListener methodsFor: 'accessing' stamp: 'ms 10/24/2022 21:43:28'!
heading
	^heading! !

!WindowListener methodsFor: 'accessing' stamp: 'ms 10/24/2022 21:43:12'!
position
	^position! !


!WindowListener methodsFor: 'event handling' stamp: 'ms 10/27/2022 15:14:26'!
handleDirectionEvent: aDirection
 	heading := 'Heading ',aDirection! !

!WindowListener methodsFor: 'event handling' stamp: 'ms 10/27/2022 15:12:33'!
handlePositionEvent: aPosition
	position := aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WindowListener class' category: 'MarsRover-WithHeading'!
WindowListener class
	instanceVariableNames: ''!

!WindowListener class methodsFor: 'instance creation' stamp: 'ms 10/27/2022 15:06:47'!
observesDirectionAndPositionOn: aMarsRover

	^self new initializeObservingDirectionAndPositionOn: aMarsRover
! !

!WindowListener class methodsFor: 'instance creation' stamp: 'ms 10/27/2022 15:06:14'!
observesDirectionOn: aMarsRover

	^self new initializeObservingDirectionOn: aMarsRover
! !

!WindowListener class methodsFor: 'instance creation' stamp: 'ms 10/27/2022 15:06:34'!
observesPositionOn: aMarsRover

	^self new initializeObservingPositionOn: aMarsRover
! !
