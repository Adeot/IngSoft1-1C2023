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
	instanceVariableNames: 'oostack sentenceFinder anOOStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 15:13:10'!
setup
	
	anOOStack := OOStack new.
	anOOStack push: 'winter is coming'.
	anOOStack push: 'winning is everything'.
	anOOStack push: 'The winds of Winter'.
	anOOStack push: 'Winter is here'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 16:25:43'!
test01CanNotSelectFromStackWhenPrefixIsEmpty

	
	self assert: (sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: '') = (sentenceFinder  signalPrefixEmptyErrorDescription).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 16:27:04'!
test02CanNotSelectFromStackWhenPrefixContainsSpaces


	self assert: (sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'Winter is') = (sentenceFinder signalPrefixContainsSpacesErrorDescription).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:24:42'!
test03FinderReturnsEmptyCollectionIfStackIsEmpty
	
	|emptyCollection anOtherOOStack selectedElementsFromStack|
	
	emptyCollection := OrderedCollection new. 
	anOtherOOStack := OOStack new.
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOtherOOStack whichHavePrefix: 'summer'.
	
	self assert: selectedElementsFromStack = emptyCollection.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:22:01'!
test04FinderCanSelectNoneFromStack

	|emptyCollection selectedElementsFromStack|
	
	emptyCollection := OrderedCollection new. 
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'summer'.
	
	self assert: selectedElementsFromStack = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:28:53'!
test05FinderCanSelectASentenceFromStackWithPrefix

	| collectionWithCorrectSentences selectedElementsFromStack|

	collectionWithCorrectSentences := OrderedCollection new.
	collectionWithCorrectSentences add: 'winter is coming'.
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'winter'.
	
	self assert: selectedElementsFromStack = collectionWithCorrectSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:30:39'!
test06FinderCanSelectMultipleSentencesFromStackWithPrefix

	| collectionWithCorrectSentences selectedElementsFromStack|

	collectionWithCorrectSentences := OrderedCollection new.
	collectionWithCorrectSentences add: 'winter is coming'.
	collectionWithCorrectSentences add: 'winning is everything'.
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'win'.
	
	self assert: selectedElementsFromStack = collectionWithCorrectSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:21:20'!
test07FinderAfterSelectingHoldsStackIntactInSameOrder

	| collectionWithCorrectSentences selectedElementsFromStack|

	collectionWithCorrectSentences := OrderedCollection new.
	collectionWithCorrectSentences add: 'winter is coming'.
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'winter'.
	
	self assert: selectedElementsFromStack = collectionWithCorrectSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:21:13'!
test08FinderDoesNotSelectLowerCaseWhenPrefixIsInUpperCase

	|emptyCollection selectedElementsFromStack|
	
	emptyCollection := OrderedCollection new. 
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'Winning'.
	
	self assert: selectedElementsFromStack = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:21:06'!
test09FinderDoesNotSelectUpperCaseWhenPrefixIsInLowerCase

	|emptyCollection selectedElementsFromStack|
	
	emptyCollection := OrderedCollection new. 
	selectedElementsFromStack := sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'the'.
	
	self assert: selectedElementsFromStack = emptyCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ado 4/24/2023 13:20:58'!
test10FinderDoesNotSelectSentenceWhenPrefixIsInTheMiddleOfTheSentence

	|emptyCollection|
	
	emptyCollection := OrderedCollection new. 
	
	self assert: (sentenceFinder selectAllElementsFromStack: anOOStack whichHavePrefix: 'winds') = emptyCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixTest class' category: 'Stack-Exercise'!
SentenceFinderByPrefixTest class
	instanceVariableNames: 'sentenceFinder anOOStack'!


!classDefinition: #Numero category: 'Stack-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:55:10'!
dividirEntero: aDivisorEntero

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:57:30'!
dividirFraccion: aDivisorFraccion

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:55:33'!
multiplicarEntero: aProductoEntero

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:56:36'!
multiplicarFraccion: aProductFraccion

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:54:23'!
restarEntero: anRestarEntero

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:57:07'!
restarFraccion: anRestarFraccion

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:54:00'!
sumarEntero: anAdderEntero

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:56:10'!
sumarFraccion: anAdderFraccion

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Stack-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Stack-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:27:14'!
* aMultiplier 
	^aMultiplier multiplicarEntero: self.
	"
	(aMultiplier isKindOf: self class) ifTrue:  [^(self class with: value * aMultiplier integerValue).]
	 ifFalse: [^ (aMultiplier class with: (self * aMultiplier numerator) over: (aMultiplier denominator))] ."
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:10:07'!
+ anAdder 
	^ anAdder sumarEntero: self.
	"(anAdder isKindOf: self class) ifTrue:  [^self class with: value + anAdder integerValue.]
	 ifFalse: [^(anAdder class with: ((self * anAdder denominator )+ ( anAdder numerator ))  over: (anAdder denominator ))
		]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 15:41:37'!
- aSubtrahend 
	^aSubtrahend restarEntero: self.
	"^ self class with: value - aSubtrahend integerValue."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 15:43:05'!
/ aDivisor 
	^ aDivisor dividirEntero: self.
	"^Fraccion with: self over: aDivisor"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/22/2023 11:10:12'!
TellMeIfIAmEmpty: unOOstack
	^self subclassResponsibility .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:16:33'!
dividirEntero: enteroToBeDivided
	^Fraccion with: enteroToBeDivided over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:17:53'!
dividirFraccion: fractionToBeDivided
	^Fraccion 
	with: (fractionToBeDivided numerator) 
	over: (fractionToBeDivided denominator * self ) .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:52:24'!
fibonacci
	^self subclassResponsibility .
	"| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].
	
	^ (self - one) fibonacci + (self - two) fibonacci"
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:27:21'!
multiplicarEntero: aProductoEntero
	^self class with: ((aProductoEntero integerValue)*value ) .
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:13:23'!
multiplicarFraccion: aProductFraccion
	^ (aProductFraccion class with: (self * aProductFraccion numerator) over: (aProductFraccion denominator))! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:03:39'!
restarEntero: aNumberToSuprahendEntero
	^self class with: aNumberToSuprahendEntero integerValue - value.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:08:31'!
restarFraccion: aFractionToBeSuprahended
	^ aFractionToBeSuprahended class with: 
		(( aFractionToBeSuprahended numerator )-
		(self * aFractionToBeSuprahended denominator ) )  	
	over: (aFractionToBeSuprahended denominator ).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 14:59:36'!
sumarEntero: anAdderEntero
	^self class with: value + anAdderEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:17:02'!
sumarFraccion: anAdderFraccion
	^anAdderFraccion class with: ((self * (anAdderFraccion denominator)) + (anAdderFraccion numerator ) )
	over: anAdderFraccion denominator .! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Stack-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'af 4/22/2023 11:04:06'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	aValue<0 ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	aValue>1 ifTrue: [^EnteroPositivoMayorA1 new initalizeWith: aValue].
	aValue=1 ifTrue: [^Uno new initalizeWith: aValue].
	aValue=0 ifTrue: [^Cero new initalizeWith: aValue].! !


!classDefinition: #Cero category: 'Stack-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:11:11'!
TellMeIfIAmEmpty: unOOstack
	^unOOstack popFromEmpty .! !

!Cero methodsFor: 'as yet unclassified' stamp: 'af 4/19/2023 21:17:32'!
fibonacci
	^Entero with: 1.! !


!classDefinition: #EnteroNegativo category: 'Stack-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EnteroNegativo methodsFor: 'as yet unclassified' stamp: 'af 4/19/2023 21:17:04'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Stack-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'af 4/19/2023 21:10:20'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #EnteroPositivo category: 'Stack-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EnteroPositivo methodsFor: 'as yet unclassified' stamp: 'af 4/19/2023 21:17:58'!
fibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	value = 1 ifTrue: [^self].
	^ (self - one) fibonacci + (self - two) fibonacci.
		! !


!classDefinition: #EnteroPositivoMayorA1 category: 'Stack-Exercise'!
Entero subclass: #EnteroPositivoMayorA1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EnteroPositivoMayorA1 methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:12:12'!
TellMeIfIAmEmpty: unOOstack
	^unOOstack popFromNonEmpty .! !

!EnteroPositivoMayorA1 methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:00:39'!
fibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	^ (self - one) fibonacci + (self - two) fibonacci.
		! !


!classDefinition: #Uno category: 'Stack-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:12:04'!
TellMeIfIAmEmpty: unOOstack
	^unOOstack popFromNonEmpty .! !

!Uno methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:00:58'!
fibonacci
	^self.
	
		! !


!classDefinition: #Fraccion category: 'Stack-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:31:27'!
* aMultiplier 
	^aMultiplier multiplicarFraccion: self.
	
	"
	(aMultiplier isKindOf: self class) ifTrue:  [^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator).]
	 ifFalse: [^ (aMultiplier * self)] ."! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:31:21'!
+ anAdder 
	
	^anAdder sumarFraccion: self.
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:31:33'!
- aSubtrahend 
	^aSubtrahend restarFraccion: self.
	"| newNumerator newDenominator |
	
	newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator "
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:31:37'!
/ aDivisor 
	^aDivisor dividirFraccion: self.
	"^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:52:32'!
dividirEntero: enteroToBeDivided
	^self class with: enteroToBeDivided * denominator over: numerator .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:51:15'!
dividirFraccion: fractionToBeDivided
	^self class with:  (denominator * fractionToBeDivided numerator) over: (numerator * fractionToBeDivided denominator ).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:33:48'!
multiplicarEntero: aProductoEntero
	^ self class with: numerator * aProductoEntero  over: denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:25:54'!
multiplicarFraccion: aProductFraccion
	^self class with:  (numerator * aProductFraccion numerator) over: (denominator * aProductFraccion denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:42:05'!
restarEntero: aNumberToSuprahendEntero
	^self class with: ((aNumberToSuprahendEntero * denominator ) - numerator )over: denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:47:01'!
restarFraccion: aFractionToBeSuprahended
	| newNumerator newDenominator |
	newNumerator := 
	(denominator * aFractionToBeSuprahended numerator) - (numerator * aFractionToBeSuprahended denominator ).
	
	newDenominator := denominator * aFractionToBeSuprahended denominator.
	
	^ self class with: newNumerator over: newDenominator .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 17:38:37'!
sumarEntero: anAdderEntero
	^self class with: (( anAdderEntero * denominator) + numerator)
	  over: denominator .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'af 4/19/2023 16:38:55'!
sumarFraccion: anAdderFraccion
	
	| newNumerator newDenominator |
	newNumerator := 
	(numerator * anAdderFraccion denominator) + (denominator * anAdderFraccion numerator).
	
	newDenominator := denominator * anAdderFraccion denominator.
	
	^ self class with: newNumerator over: newDenominator .! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Stack-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'colecccion tamanioEntero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:05:28'!
initialize
	colecccion := OrderedCollection new .
	tamanioEntero  := Entero with: 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/21/2023 11:22:20'!
isEmpty
^  self size =0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:16:26'!
pop
	^tamanioEntero TellMeIfIAmEmpty: self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:15:40'!
popFromEmpty
	self restarUnoTamanioStack.
	^self error: OOStack stackEmptyErrorDescription.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:15:48'!
popFromNonEmpty
	self restarUnoTamanioStack.

	^colecccion removeLast.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:07:41'!
push: anElementToBeAdded
	| uno |
	uno := Entero with: 1.
	tamanioEntero := tamanioEntero + uno.
	colecccion addLast: anElementToBeAdded.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:15:11'!
restarUnoTamanioStack
	| uno |
	uno := Entero with: 1.
	tamanioEntero := tamanioEntero - uno.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/20/2023 21:35:48'!
size 
	^colecccion size ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'af 4/20/2023 21:40:36'!
top 
	| elementTop |
	elementTop := self pop.
	self push: elementTop.
	^elementTop.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'initalize'!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'anOOstack prefix collectionOfSentencesFromStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ado 4/24/2023 00:46:37'!
initialize
	collectionOfSentencesFromStack := OrderedCollection new .

	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ado 4/24/2023 16:32:58'!
selectAllElementsFromStack: aOOstack whichHavePrefix: aPrefix

	aPrefix = '' ifTrue: [^ self signalPrefixEmptyErrorDescription].
	(aPrefix findString: ' ' startingAt: 1) > 0 ifTrue: [^self signalPrefixContainsSpacesErrorDescription].
	
	"completar"
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ado 4/24/2023 16:18:56'!
signalPrefixContainsSpacesErrorDescription

	^ self class prefixContainsSpacesErrorDescription
	
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ado 4/24/2023 16:20:04'!
signalPrefixEmptyErrorDescription

	^ self class prefixEmptyErrorDescription
	
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:31:30'!
prefixContainsSpacesErrorDescription
	
	^ 'a prefix should not contain spaces in between words!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'af 4/22/2023 11:30:51'!
prefixEmptyErrorDescription
	
	^ 'prefix is empty!!!!!!'! !
