!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

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

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

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

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

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


!NumeroTest methodsFor: 'setup' stamp: 'HernanWilkinson 5/7/2016 20:56'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	four := Entero with: 4.
	five := Entero with: 5.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NDC 4/19/2018 20:36:30'!
addAFraction: anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NDC 4/19/2018 20:36:36'!
addAnInteger: anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NDC 4/19/2018 20:36:44'!
multiplyAFraction: anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NDC 4/19/2018 20:36:49'!
multiplyAnInteger: anAdder

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'NDC 4/19/2018 21:31:18'!
asDenominator

	self subclassResponsibility ! !

!Entero methodsFor: 'comparing' stamp: 'NDC 4/19/2018 21:10:18'!
asNumerator

	^self! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !

!Entero methodsFor: 'comparing' stamp: 'NDC 4/19/2018 20:56:31'!
raiseErrorOnNullFraction! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:08:39'!
* aMultiplier 
	
	^aMultiplier multiplyAnInteger: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:07:13'!
+ anAdder 
	
	^anAdder addAnInteger: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:49:01'!
/ aDivisor 
	
	^self * (aDivisor inverse)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:10:24'!
addAFraction: anAdder 
	
	^anAdder addAnInteger: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:04:32'!
addAnInteger: anAdder 
	
	^self class with: value + anAdder integerValue
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:37:58'!
inverse 
	
	^Fraccion with: (self class with: 1) over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:09:04'!
multiplyAFraction: aMultiplier 
	
	^aMultiplier multiplyAnInteger: self	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:07:47'!
multiplyAnInteger: aMultiplier 
	
	^self class with: value * aMultiplier integerValue
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NDC 4/19/2018 21:33:12'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [ ^ Zero new init ].
     aValue = 1 ifTrue: [ ^ Uno new init].
	^EnterosMayoresA2 new initalizeWith: aValue! !


!classDefinition: #EnterosMayoresA2 category: #'Numero-Exercise'!
Entero subclass: #EnterosMayoresA2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnterosMayoresA2 methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:08:45'!
asDenominator

^self! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:49:03'!
* aMultiplier
	
	^aMultiplier! !

!Uno methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:08:23'!
asDenominator
	
	^self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ! !

!Uno methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:29:40'!
init

self initalizeWith: 1! !

!Uno methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:48:31'!
multiplyAFraction: AMultiplier
	
	^AMultiplier! !

!Uno methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:48:09'!
multiplyAnInteger: AMultiplier
	
	^AMultiplier! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:06:02'!
* aMultiplier
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:05:23'!
+ anAdder
	
	^anAdder! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:50:36'!
/ aDivisor
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:20:52'!
addAFraction: AnAdder
	
	^AnAdder! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:21:03'!
addAnInteger: AnAdder
	
	^AnAdder! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:12:50'!
asDenominator

	^self error: self canNotDivideByZeroErrorDescription! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:12:40'!
asNumerator

	^self error: 'una fraccion no puede ser cero'! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 21:29:34'!
init

self initalizeWith: 0! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 22:02:20'!
inverse
	
	^self error: self class canNotDivideByZeroErrorDescription! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:50:55'!
multiplyAFraction: AMultiplier
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:51:01'!
multiplyAnInteger: AMultiplier
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'NDC 4/19/2018 20:55:32'!
raiseErrorOnNullFraction
	^self error: 'una fraccion no puede ser cero'! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'NDC 4/19/2018 21:07:37'!
initializeWith: desiredNumerator over: desiredDenominator

	numerator := desiredNumerator asNumerator.
	denominator := desiredDenominator asDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:02:10'!
* aMultiplier 
	
	^aMultiplier multiplyAFraction: self 
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 20:57:57'!
+ anAdder 
	
	^anAdder addAFraction: self ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:48:29'!
/ aDivisor 
	
	^self * (aDivisor inverse)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:19:58'!
addAFraction: anAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:28:20'!
addAnInteger: anAdder 
	
	| newNumerator |
	
	newNumerator := numerator + (denominator * anAdder).
	
	^newNumerator / denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:50:28'!
inverse
	
	^Fraccion with: denominator over: numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:01:01'!
multiplyAFraction: aMultiplier 
	
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NDC 4/16/2018 21:52:09'!
multiplyAnInteger: aMultiplier 
	
	^Fraccion with: (numerator * aMultiplier) over: denominator
	! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NDC 4/19/2018 21:12:20'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDividend isZero ifTrue: [ ^aDividend ].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
