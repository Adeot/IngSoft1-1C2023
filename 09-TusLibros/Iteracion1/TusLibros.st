!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 14:21:06'!
test01CarritoNuevoEstaVacio
	
	| carrito |
	
	carrito := Carrito createCart.
	
	self assert: carrito isEmpty
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 16:58:01'!
test02CarritoDejaDeEstarVacioAlAgregarLibro
	
	| bookISBM bookQuantity carrito editorial |
	
	editorial := Editorial newEditorial.
	editorial addISBM: 123.
	
	carrito := Carrito createCartFrom: editorial.
	bookISBM := 123.
	bookQuantity := 3.
	carrito addToCart: (bookISBM@bookQuantity).
	
	self deny: carrito isEmpty
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 16:57:52'!
test03CarritoListaSusLibrosAlAgregarUnaPila
	
	| bookISBM bookQuantity carrito collectionOfBooks pileOfEqualBooks editorial |
	
	editorial := Editorial newEditorial.
	editorial addISBM: 123.
	
	carrito := Carrito createCartFrom: editorial.
	bookISBM := 123.
	bookQuantity := 3.
	pileOfEqualBooks := (bookISBM@bookQuantity).
	
	collectionOfBooks := OrderedCollection new.
	collectionOfBooks add: pileOfEqualBooks.
	
	carrito addToCart: pileOfEqualBooks.
	
	self assert: (carrito listCart) equals: collectionOfBooks.
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 16:57:27'!
test04CarritoEnvia1SiElISBNNoEsDeLaEditorial
	
	| bookISBM bookQuantity carrito pileOfEqualBooks addPileOfBooks editorial |
	
	
	bookISBM := 123.
	bookQuantity := 3.
	pileOfEqualBooks := (bookISBM@bookQuantity).
	
	editorial := Editorial newEditorial.
	editorial addISBM: 456.
	
	carrito := Carrito createCartFrom: editorial.
	
	addPileOfBooks := [carrito addToCart: pileOfEqualBooks].
	
	self assert: (addPileOfBooks value) equals: 1.
	
	! !


!classDefinition: #Carrito category: 'TusLibros'!
Object subclass: #Carrito
	instanceVariableNames: 'booksInCart publisher'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'accessing' stamp: 'ado 6/8/2023 14:34:53'!
initialize

	booksInCart := OrderedCollection new.! !

!Carrito methodsFor: 'accessing' stamp: 'ado 6/8/2023 16:29:36'!
initializeFrom: aPublisher

	booksInCart := OrderedCollection new.
	publisher := aPublisher! !

!Carrito methodsFor: 'accessing' stamp: 'ado 6/8/2023 14:37:54'!
isEmpty

	^booksInCart isEmpty.! !

!Carrito methodsFor: 'accessing' stamp: 'ado 6/8/2023 14:43:49'!
listCart
	
	^booksInCart.! !


!Carrito methodsFor: 'adding' stamp: 'ado 6/8/2023 16:44:22'!
addToCart: aPileOfBooks 
	
	(publisher hasISBM: (aPileOfBooks x)) ifTrue:[
		booksInCart add: aPileOfBooks.
		^0.
		].
	^1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: 'TusLibros'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'initialization' stamp: 'ado 6/8/2023 14:32:33'!
createCart

	^Carrito new initialize.! !

!Carrito class methodsFor: 'initialization' stamp: 'ado 6/8/2023 16:29:00'!
createCartFrom: aPublisher

	^Carrito new initializeFrom: aPublisher.! !


!classDefinition: #Editorial category: 'TusLibros'!
Object subclass: #Editorial
	instanceVariableNames: 'isbmList'
	classVariableNames: 'ISBMList'
	poolDictionaries: ''
	category: 'TusLibros'!

!Editorial methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 16:18:01'!
initialize

	isbmList := Set new.! !


!Editorial methodsFor: 'adding' stamp: 'ado 6/8/2023 15:15:23'!
addISBM: bookISBM 

	isbmList add: bookISBM.! !

!Editorial methodsFor: 'adding' stamp: 'ado 6/8/2023 16:57:18'!
hasISBM: bookISBM 

	(isbmList includes: bookISBM) ifTrue: [^true].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: 'TusLibros'!
Editorial class
	instanceVariableNames: ''!

!Editorial class methodsFor: 'as yet unclassified' stamp: 'ado 6/8/2023 15:11:29'!
newEditorial
	
	^self new initialize.! !
