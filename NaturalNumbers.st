!classDefinition: #I category: 'NaturalNumbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NaturalNumbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:01:18'!
* aMultiplier
	^aMultiplier ! !

!I class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:11:14'!
+ unSumando
	^unSumando next! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:33:18'!
/ aDivisor
	self = aDivisor  ifTrue: [^self] ifFalse: [self doesNotUnderstand: 'no se puede brodiii']! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:41:37'!
< aNaturalNumber
	^(self = aNaturalNumber) not! !

!I class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:25:37'!
next
	^II! !


!classDefinition: #II category: 'NaturalNumbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NaturalNumbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:08:01'!
* aMultiplier
	^previous * aMultiplier + aMultiplier! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:29:41'!
+ anAdder
	^previous + anAdder  next! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:42:56'!
- unRestando
	unRestando = I ifTrue: [^previous] ifFalse: [^previous - unRestando previous] ! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 23:04:46'!
/ aDivisor
	self < aDivisor ifTrue: [self doesNotUnderstand: 'BASTAAA NO PODES'].
	self = aDivisor ifTrue: [^I].
	self-aDivisor < aDivisor ifTrue: [^I] 	ifFalse: [^ 		self-aDivisor / aDivisor + I		] ! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:47:13'!
< aNaturalNumber
	^ aNaturalNumber = I ifTrue: [false] ifFalse: [previous < aNaturalNumber previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:37:46'!
clear
	next ifNotNil: 
	[
		next clear.
		next removeFromSystem.
		next := nil
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:28:17'!
next
	next ifNil: [
		next := II createChildNamed: self name , 'I'.
		next previous: self].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:40:54'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:28:57'!
previous: aNaturalNumber
	previous  := aNaturalNumber ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NaturalNumbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NaturalNumbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'NaturalNumbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NaturalNumbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'NaturalNumbers'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NaturalNumbers'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'NaturalNumbers'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'NaturalNumbers'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'NaturalNumbers'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'NaturalNumbers'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'NaturalNumbers'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'NaturalNumbers'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/27/2022 00:27:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!