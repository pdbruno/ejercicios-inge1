!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 16:02:14'!
test01ConstruyoRoverEnPuntoInicialYEsIgualAlObservado

	self assert: ((MarsRover onPoint: 1@1 pointingTo: $N) isAt: (1@1) lookingAt: $N).
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:49:48'!
test03RoverSeMueveUnMovimientoHaciaAdelanteYNoRota

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $N.
	
	rover mover: 'f'.
	
	self assert: (rover isAt: (1@2) lookingAt: $N).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:50:08'!
test04RoverSeMueveUnMovimientoHaciaAtrasYNoRota

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $N.
	
	rover mover: 'b'.
	
	self assert: (rover isAt: (1@0) lookingAt: $N).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:50:15'!
test05RoverRota90GradosHaciaLaIzquierdaYNoSeMueve

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $N.
	
	rover mover: 'l'.
	
	self assert: (rover isAt: (1@1) lookingAt: $O).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:50:23'!
test06RoverRota90GradosHaciaLaDerechaYNoSeMueve

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $N.
	
	rover mover: 'r'.
	
	self assert: (rover isAt: (1@1) lookingAt: $E).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:52:33'!
test07RoverSeMueveHaciaDelanteMirandoHaciaElSur

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $S.
	
	rover mover: 'f'.
	
	self assert: (rover isAt: (1@0) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:12:35'!
test08RoverSeMueveHaciaDelanteMirandoHaciaElEste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'f'.
	
	self assert: (rover isAt: (2@1) lookingAt: $E).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:14:22'!
test09RoverSeMueveHaciaDelanteMirandoHaciaElOeste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $O.
	
	rover mover: 'f'.
	
	self assert: (rover isAt: (0@1) lookingAt: $O).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:16:52'!
test10RoverSeMueveHaciaAtrasMirandoHaciaElSur

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $S.
	
	rover mover: 'b'.
	
	self assert: (rover isAt: (1@2) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:18:01'!
test11RoverSeMueveHaciaAtrasMirandoHaciaElEste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'b'.
	
	self assert: (rover isAt: (0@1) lookingAt: $E).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:19:42'!
test12RoverSeMueveHaciaAtrasMirandoHaciaElOeste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $O.
	
	rover mover: 'b'.
	
	self assert: (rover isAt: (2@1) lookingAt: $O).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:21:41'!
test13RoverRotaALaIzquierdaMirandoHaciaElSur

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $S.
	
	rover mover: 'l'.
	
	self assert: (rover isAt: (1@1) lookingAt: $E).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:22:29'!
test14RoverRotaALaIzquierdaMirandoHaciaElEste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'l'.
	
	self assert: (rover isAt: (1@1) lookingAt: $N).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:23:38'!
test15RoverRotaALaIzquierdaMirandoHaciaElOeste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $O.
	
	rover mover: 'l'.
	
	self assert: (rover isAt: (1@1) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:25:09'!
test16RoverRotaALaDerechaMirandoHaciaElSur

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $S.
	
	rover mover: 'r'.
	
	self assert: (rover isAt: (1@1) lookingAt: $O).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:26:01'!
test17RoverRotaALaDerechaMirandoHaciaElOeste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $O.
	
	rover mover: 'r'.
	
	self assert: (rover isAt: (1@1) lookingAt: $N).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:26:26'!
test18RoverRotaALaDerechaMirandoHaciaElEste

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'r'.
	
	self assert: (rover isAt: (1@1) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:31:59'!
test19RoverEjecutaSecuenciaConMasDeUnMovimiento

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'rff'.
	
	self assert: (rover isAt: (1@-1) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:45:20'!
test20RoverEjecutaSecuenciaConMasDeUnMovimientoHastaMovimientoInvalido

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $E.
	
	rover mover: 'rhff'.
	
	self assert: (rover isAt: (1@1) lookingAt: $S).	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'ms 10/6/2022 15:46:03'!
test21RoverNoSeMueveAnteSecuenciaVacia

	| rover |
	
	rover := MarsRover onPoint: 1@1 pointingTo: $N.
	
	rover mover: OrderedCollection new.
	
	self assert: (rover isAt: (1@1) lookingAt: $N).	
	
	! !


!classDefinition: #DireccionState category: 'MarsRover'!
Object subclass: #DireccionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DireccionState class' category: 'MarsRover'!
DireccionState class
	instanceVariableNames: ''!

!DireccionState class methodsFor: 'accessing' stamp: 'ms 10/3/2022 21:29:12'!
direction
	self subclassResponsibility ! !


!DireccionState class methodsFor: 'instance creation' stamp: 'ms 10/3/2022 21:21:50'!
for: aDirection

	^self subclasses detect: [ :aSubclass | aSubclass isFor: aDirection ] ifNone: [^self error: 'Error'].! !


!DireccionState class methodsFor: 'testing' stamp: 'ms 10/6/2022 15:29:31'!
isFor: aDirection
	
	self subclassResponsibility ! !


!DireccionState class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:36:46'!
moveBackward: aMarsRover 
	self subclassResponsibility .! !

!DireccionState class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:31:22'!
moveForward: aMarsRover 
	self subclassResponsibility.! !

!DireccionState class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:40:28'!
rotateLeft: aMarsRover 
	self subclassResponsibility.! !

!DireccionState class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:44:05'!
rotateRight: aMarsRover 
	self subclassResponsibility.! !


!classDefinition: #DireccionStateEste category: 'MarsRover'!
DireccionState subclass: #DireccionStateEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DireccionStateEste class' category: 'MarsRover'!
DireccionStateEste class
	instanceVariableNames: ''!

!DireccionStateEste class methodsFor: 'accessing' stamp: 'ms 10/6/2022 15:08:38'!
direction
	^$E! !


!DireccionStateEste class methodsFor: 'testing' stamp: 'ms 10/3/2022 21:19:10'!
isFor: aDirection
	
	^aDirection = $E

	! !


!DireccionStateEste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:19:13'!
moveBackward: aMarsRover 
	
	aMarsRover moveLeft.! !

!DireccionStateEste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:13:16'!
moveForward: aMarsRover 
	aMarsRover moveRight.! !

!DireccionStateEste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:22:48'!
rotateLeft: aMarsRover 
	
	aMarsRover lookAtNorth! !

!DireccionStateEste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:26:41'!
rotateRight: aMarsRover 
		
	aMarsRover lookAtSouth! !


!classDefinition: #DireccionStateNorte category: 'MarsRover'!
DireccionState subclass: #DireccionStateNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DireccionStateNorte class' category: 'MarsRover'!
DireccionStateNorte class
	instanceVariableNames: ''!

!DireccionStateNorte class methodsFor: 'accessing' stamp: 'ms 10/3/2022 21:29:56'!
direction
	^$N! !


!DireccionStateNorte class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:37:56'!
moveBackward: aMarsRover 
	aMarsRover moveDown.! !

!DireccionStateNorte class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:33:47'!
moveForward: aMarsRover 
	aMarsRover moveUp! !

!DireccionStateNorte class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:41:54'!
rotateLeft: aMarsRover 
	aMarsRover lookAtWest! !

!DireccionStateNorte class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:44:33'!
rotateRight: aMarsRover 
	aMarsRover lookAtEast! !


!DireccionStateNorte class methodsFor: 'testing' stamp: 'ms 10/3/2022 21:19:04'!
isFor: aDirection
	
	^aDirection = $N

	! !


!classDefinition: #DireccionStateOeste category: 'MarsRover'!
DireccionState subclass: #DireccionStateOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DireccionStateOeste class' category: 'MarsRover'!
DireccionStateOeste class
	instanceVariableNames: ''!

!DireccionStateOeste class methodsFor: 'accessing' stamp: 'ms 10/6/2022 15:08:32'!
direction
	^$O! !


!DireccionStateOeste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:20:01'!
moveBackward: aMarsRover 
	
	aMarsRover moveRight.! !

!DireccionStateOeste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:14:49'!
moveForward: aMarsRover 
	
	aMarsRover moveLeft! !

!DireccionStateOeste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:23:58'!
rotateLeft: aMarsRover 
	
	aMarsRover lookAtSouth! !

!DireccionStateOeste class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:26:15'!
rotateRight: aMarsRover 
	
	aMarsRover lookAtNorth! !


!DireccionStateOeste class methodsFor: 'testing' stamp: 'ms 10/3/2022 21:18:55'!
isFor: aDirection
	
	^aDirection = $O

	! !


!classDefinition: #DireccionStateSur category: 'MarsRover'!
DireccionState subclass: #DireccionStateSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DireccionStateSur class' category: 'MarsRover'!
DireccionStateSur class
	instanceVariableNames: ''!

!DireccionStateSur class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:17:30'!
moveBackward: aMarsRover 
	
	aMarsRover moveUp! !

!DireccionStateSur class methodsFor: 'updating' stamp: 'ms 10/3/2022 21:46:21'!
moveForward: aMarsRover 
	aMarsRover moveDown ! !

!DireccionStateSur class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:22:06'!
rotateLeft: aMarsRover 
	
	aMarsRover lookAtEast.! !

!DireccionStateSur class methodsFor: 'updating' stamp: 'ms 10/6/2022 15:25:43'!
rotateRight: aMarsRover 
	
	aMarsRover lookAtWest! !


!DireccionStateSur class methodsFor: 'accessing' stamp: 'ms 10/6/2022 15:08:24'!
direction

	^$S! !


!DireccionStateSur class methodsFor: 'testing' stamp: 'ms 10/3/2022 21:18:10'!
isFor: aDirection

	^aDirection = $S
	
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'ms 10/3/2022 21:25:43'!
initializeIn: aPosition to: aDirectionState

	position := aPosition.
	direction := aDirectionState.! !


!MarsRover methodsFor: 'testing' stamp: 'ms 10/6/2022 16:03:13'!
isAt: aPosition lookingAt: aDirection

	^(position = aPosition and: direction = (DireccionState for: aDirection))

! !


!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:11:08'!
lookAtEast
	direction := DireccionStateEste! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:23:18'!
lookAtNorth
	
	direction := DireccionStateNorte! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:24:16'!
lookAtSouth
	
	direction := DireccionStateSur! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:11:12'!
lookAtWest
	direction  := DireccionStateOeste! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:45:02'!
moveBy: aCommand
	
	(aCommand  = $f) ifTrue: [^direction moveForward: self].

	(aCommand  = $b) ifTrue: [^direction moveBackward: self].
		
	(aCommand  = $l) ifTrue: [^direction rotateLeft: self].

	(aCommand  = $r) ifTrue: [^direction rotateRight: self].		
	
	self error: self class invalidOperationErrorMessage 
		



! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/3/2022 21:38:49'!
moveDown
	position := position + (0@-1)! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:15:31'!
moveLeft
	
	position := position + (-1@0)! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:13:48'!
moveRight
	
	position := position + (1@0).! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/3/2022 21:36:02'!
moveUp
	position  := position + (0@1) ! !

!MarsRover methodsFor: 'updating' stamp: 'ms 10/6/2022 15:41:42'!
mover: aCollection
	
	aCollection do: [ :aCommand | 
		
		[self moveBy: aCommand] on: Error do: [^self] 
		
	].



! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error messages' stamp: 'ms 10/6/2022 15:44:37'!
invalidOperationErrorMessage

	^'Invalid operation'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'ms 10/3/2022 21:25:28'!
onPoint: aPosition pointingTo: aDirection

	^self new initializeIn: aPosition to: (DireccionState for: aDirection) 



! !
