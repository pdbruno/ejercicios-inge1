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

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:50:26'!
- aSubstraend
	self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:50:45'!
/ aDivisor
	self = aDivisor  ifTrue: [^self] ifFalse: [self error: self canNotDivideByBiggerNumberErrorDescription ]! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:41:37'!
< aNaturalNumber
	^(self = aNaturalNumber) not! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:40:11'!
canNotDivideByBiggerNumberErrorDescription
	^'No se puede dividir por un n�mero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:42:08'!
negativeNumbersNotSupportedErrorDescription
	^'No est�n soportados los n�meros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:25:37'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'pdb 8/29/2022 20:31:21'!
substractFrom: aNaturalNumber
	^aNaturalNumber previous! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/29/2022 20:49:23'!
- aSustrahend
	^aSustrahend substractFrom: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:50:51'!
/ aDivisor
	self < aDivisor ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ].
	self = aDivisor ifTrue: [^I].
	self-aDivisor < aDivisor ifTrue: [^I] 	ifFalse: [^ 		self-aDivisor / aDivisor + I		] ! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/26/2022 22:47:13'!
< aNaturalNumber
	^ aNaturalNumber = I ifTrue: [false] ifFalse: [previous < aNaturalNumber previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:40:33'!
canNotDivideByBiggerNumberErrorDescription
	^'No se puede dividir por un n�mero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:37:46'!
clear
	next ifNotNil: 
	[
		next clear.
		next removeFromSystem.
		next := nil
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/31/2022 23:30:58'!
nameOfNext

	(self name endsWith: 'CMXCIX') ifTrue: [^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/29/2022 21:17:21'!
next
	next ifNil: [
		next := II createChildNamed: self nameOfNext.
		next previous: self].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:40:54'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'pato 8/25/2022 21:28:57'!
previous: aNaturalNumber
	previous  := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'pdb 8/29/2022 20:30:04'!
substractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/31/2022 23:55:21'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/31/2022 23:55:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NaturalNumbers'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NaturalNumbers'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'pdb 8/31/2022 23:55:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
