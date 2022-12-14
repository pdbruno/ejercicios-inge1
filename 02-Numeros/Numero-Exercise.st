!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:07'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:17'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:51:13'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:37'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:42'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/24/2020 02:50:52'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:57:14'!
* aMultiplier 

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:57:00'!
+ anAdder 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:00:35'!
negated

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:04'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:14'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:22'!
isZero

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:13:15'!
throwDivisionErrorIfZero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:04:27'!
addInteger: anInteger withFraction: aFraction
	^Fraccion with: anInteger * aFraction denominator + aFraction numerator over: aFraction denominator! !

!Numero class methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:10:01'!
multiplyInteger: anInteger byFraction: aFraction
	^Fraccion with: anInteger * aFraction numerator over: aFraction denominator! !


!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 17:02:08'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de n???mero inv???lido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:41:30'!
* aMultiplier 

	^aMultiplier multiplyByInteger: self
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:41:27'!
+ anAdder 

	^anAdder addWithInteger: self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:24:53'!
- aSubtrahend 
	^aSubtrahend substractToInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:22:35'!
/ aDivisor 

	^aDivisor divideInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:56:37'!
// aDivisor 

	 ^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:06:02'!
addWithFraction: aFraction 
	^Numero addInteger: self withFraction: aFraction
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:37:34'!
addWithInteger: anInteger 
	^self class with: value + anInteger integerValue.
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:18:57'!
divideFraction: aFraction 
	^Fraccion with: aFraction numerator over: aFraction denominator * self.
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:22:05'!
divideInteger: anInteger 
	^Fraccion with: anInteger over: self
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:04:13'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
		
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:52:04'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:10:53'!
multiplyByFraction: aFraction 

	^Numero multiplyInteger: self byFraction: aFraction
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/11/2022 17:42:57'!
multiplyByInteger: anInteger 

	^self class with: value * (anInteger integerValue)
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:57:07'!
negateAndInstantiateWithClass: aClass
	
	^aClass with: -1 * self integerValue 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:57:32'!
negated
	
	^self negateAndInstantiateWithClass: self class 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:41:08'!
substractToFraction: aFraction 
	^Fraccion with: aFraction denominator over: aFraction numerator - self * aFraction denominator.
	
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:30:45'!
substractToInteger: anInteger 
	^self class with: anInteger integerValue - self integerValue.
	
		
	! !


!Entero methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:58:12'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:42:34'!
hash

	^value hash.
	! !


!Entero methodsFor: 'initialization' stamp: 'NR 9/8/2019 22:32:50'!
initializeWith: aValue
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'NR 9/8/2019 22:39:05'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'NR 9/8/2019 22:29:40'!
printOn: aStream
	
	 aStream print: value.
	! !


!Entero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:08:34'!
executeBlockIfNegative: aBlock
	
	! !

!Entero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:08:45'!
executeBlockIfOne: aBlock
	
	! !

!Entero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:08:28'!
executeBlockIfZero: aBlock
	
	! !

!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:36:29'!
isNegative

	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:37:27'!
isOne
	
	^value = 1
! !

!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:38:23'!
isZero
	
	^value = 0
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est??? definido aqu??? para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'pdb 9/14/2022 15:59:16'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^ Cero new].
	aValue = 1 ifTrue: [^ Uno new].
	aValue < 0 ifTrue: [^ Negativo new initializeWith: aValue].
	
	^self new initializeWith: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:36:04'!
addWithInteger: anInteger 
	^Entero with: anInteger integerValue
	! !

!Cero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:29:18'!
divideInteger: anInteger 
	^self error: self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:37:21'!
fibonacci
	^Uno new! !

!Cero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:29:54'!
multiplyByInteger: anInteger 

	^Cero new! !

!Cero methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:36:14'!
substractToInteger: anInteger 
	^Entero with: anInteger integerValue! !


!Cero methodsFor: 'initialization' stamp: 'pdb 9/14/2022 16:15:28'!
initialize
	
	value := 0! !


!Cero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:09:01'!
executeBlockIfZero: aBlock
	^aBlock value! !

!Cero methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:01:33'!
throwDivisionErrorIfZero
	^self error: self class canNotDivideByZeroErrorDescription ! !


!Cero methodsFor: 'value' stamp: 'pdb 9/14/2022 16:08:11'!
integerValue
	^0! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:09:15'!
executeBlockIfNegative: aBlock
	^aBlock value! !


!Negativo methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:04:31'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:57:48'!
negated
	^self negateAndInstantiateWithClass: Entero! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'value' stamp: 'pdb 9/14/2022 16:08:46'!
integerValue
 ^1! !


!Uno methodsFor: 'initialization' stamp: 'pdb 9/14/2022 16:16:16'!
initialize
	value := 1! !


!Uno methodsFor: 'testing' stamp: 'pdb 9/14/2022 17:09:08'!
executeBlockIfOne: aBlock
	^aBlock value! !


!Uno methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:34:42'!
addWithInteger: anInteger 
	^Entero with: anInteger integerValue +1
	! !

!Uno methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:36:33'!
divideInteger: anInteger 

	^Entero with: anInteger integerValue
	! !

!Uno methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:03:25'!
fibonacci
	^Uno new! !

!Uno methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:36:36'!
multiplyByInteger: anInteger 

	^Entero with: anInteger integerValue
	! !

!Uno methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 16:36:38'!
substractToInteger: anInteger 
	^Entero with: (anInteger integerValue) -1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:42:41'!
* aMultiplier 

	^aMultiplier multiplyByFraction: self
		
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:42:44'!
+ anAdder 

	^anAdder addWithFraction: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:36:37'!
- aSubtrahend 
	^aSubtrahend substractToFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/14/2022 17:11:39'!
/ aDivisor 

	aDivisor throwDivisionErrorIfZero.
	
	^aDivisor divideFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 20:08:13'!
addWithFraction: aFraction 
	| newNumerator newDenominator |

	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	
	^self class with: newNumerator over: newDenominator.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:06:54'!
addWithInteger: anInteger 	
	^Numero addInteger: anInteger withFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:15:22'!
divideFraction: aFraction 
	^(aFraction numerator * self denominator) / (aFraction denominator * self numerator).
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:22:20'!
divideInteger: anInteger 
	^(self class with: self denominator over: self numerator) * anInteger.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/11/2022 17:44:27'!
multiplyByFraction: aFraction 
	^self class with: (numerator * (aFraction numerator)) over: (denominator * (aFraction denominator))
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ms 9/15/2022 15:11:12'!
multiplyByInteger: anInteger 
	^Numero multiplyInteger: anInteger byFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:08:35'!
negated
	
	 ^self class with: numerator * (Entero with: -1) over: denominator .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:38:24'!
substractToFraction: aFraction 	
	| newNumerator newDenominator |

	newNumerator := (aFraction numerator * denominator) - (numerator * aFraction denominator).
	newDenominator := denominator * aFraction denominator.
	
	^self class with: newNumerator over: newDenominator.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'pdb 9/12/2022 21:33:26'!
substractToInteger: anInteger 	
	^self class with: (anInteger * denominator) - numerator over: denominator.
	! !


!Fraccion methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:58:37'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:43:08'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'NR 9/8/2019 22:39:29'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'NR 9/8/2019 22:40:00'!
numerator

	^numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'NR 9/8/2019 22:33:11'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:36:50'!
isNegative

	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:37:42'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:38:37'!
isZero

	^false! !


!Fraccion methodsFor: 'printing' stamp: 'NR 9/8/2019 22:30:07'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'pdb 9/14/2022 17:08:12'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor throwDivisionErrorIfZero.
	aDividend executeBlockIfZero: [ ^aDividend ].
	
	aDivisor executeBlockIfNegative: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator executeBlockIfOne: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
