!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'AF 6/8/2023 19:55:03'!
test09CantCheckOutEmptyCart

	| cart aCard cashier |
	
	cart := self createCart.
	cashier := Cashier new.
	aCard := Card new.
	self 
		should: [(cashier checkOut: cart payingWith: aCard)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier emptyCartCheckOutErrorMessage. ]! !

!CartTest methodsFor: 'tests' stamp: 'ado 6/12/2023 16:34:53'!
test10CanCheckOutWithJustOneProductInCart

	| cart cashier card date merchantProcessor |
	
	cart := self createCart.
	cashier := Cashier new.
	card := self createCard. 
	cart add: self itemSellByTheStore.
	date := GregorianMonthOfYear juneOf: (self createAYear: 2019).
	PriceList at: (self itemSellByTheStore) put: 10.
	merchantProcessor := MerchantProcessor new.

	self 
		assert: 10 equals: (cashier checkOut: cart payingWith: card on: date processedBy: merchantProcessor).
! !

!CartTest methodsFor: 'tests' stamp: 'ado 6/12/2023 16:30:59'!
test11CanCheckOutWithManyProductsInCart

	| cart cashier card date merchantProcessor |
	
	cart := self createCart.
	cashier := Cashier new.
	card := self createCard. 
	
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore.
	PriceList at: (self itemSellByTheStore) put: 10.
	
	merchantProcessor := MerchantProcessor new.
	date := GregorianMonthOfYear juneOf: (self createAYear: 2019).
	
	self assert: 30 equals: (cashier checkOut: cart payingWith: card on: date processedBy: merchantProcessor).
	! !

!CartTest methodsFor: 'tests' stamp: 'ado 6/12/2023 16:20:02'!
test12CantCheckOutWithExpiredCard

	| cart cashier card date merchantProcessor |
	
	cart := self createCart.
	cashier := Cashier new.
	card := self createCard. 
	cart add: self itemSellByTheStore.
	merchantProcessor := MerchantProcessor new.
	date := GregorianMonthOfYear juneOf: (self createAYear: 2023).
	
	self 
		should: [(cashier checkOut: cart payingWith: card on: date processedBy: merchantProcessor)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = merchantProcessor invalidCardErrorMessage. ]
	! !


!CartTest methodsFor: 'support' stamp: 'ado 6/12/2023 16:16:17'!
createAYear: aYearNumber

	^ GregorianYear createYear: aYearNumber.! !

!CartTest methodsFor: 'support' stamp: 'ado 6/12/2023 16:15:13'!
createCard
	| aDate aYear |
	aYear := GregorianYear createYear: 2023.
	aDate := GregorianMonthOfYear aprilOf: aYear.
	^Card with: 1111222233334444 expiringOn: aDate securedWith: 123. ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'ado 6/12/2023 14:58:05'!
setUp

	PriceList new.! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'cardNumber expiringDate securityCode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 15:11:45'!
cardNumber

	^ cardNumber
! !

!Card methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 15:12:09'!
expiringDate

	^expiringDate
! !

!Card methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 15:10:43'!
initializeWith: aCardNumber expiringOn: anExpiringDate securedWith: aSecurityCode

	cardNumber := aCardNumber.
	expiringDate := anExpiringDate.
	securityCode := aSecurityCode. ! !

!Card methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 15:12:35'!
securityCode

	^securityCode! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 15:09:17'!
with: aCardNumber expiringOn: anExpiringDate securedWith: aSecurityCode

	^ Card new initializeWith: aCardNumber expiringOn: anExpiringDate securedWith: aSecurityCode.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'AF 6/8/2023 20:39:25'!
totalPriceOfAllProducts

	^items inject: 0 into: [:subtotal :item | subtotal + (PriceList priceOf: item)]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 00:58:31'!
checkOut: aCart payingWith: aCard

	(aCart isEmpty) ifTrue: [^self error: self emptyCartCheckOutErrorMessage .]. 

		^ self generateTicketFor: aCart.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 16:24:35'!
checkOut: aCart payingWith: aCard on: aDate processedBy: aMerchantProcessor

	(aCart isEmpty) ifTrue: [^self error: self emptyCartCheckOutErrorMessage .]. 
	(aMerchantProcessor verify: aCard isValidOn: aDate) ifFalse: [^self error: aMerchantProcessor invalidCardErrorMessage.]. 

	^ self generateTicketFor: aCart.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AF 6/8/2023 19:57:45'!
emptyCartCheckOutErrorMessage
^'It is not possible to checkout an empty cart'! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AF 6/8/2023 20:30:03'!
generateTicketFor: aCart
	^aCart totalPriceOfAllProducts.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 00:56:08'!
send: aCard toBeVerifiedBy: aMerchantProcessor andGenerateTicketFor: aCart on: aDate
	^aCart totalPriceOfAllProducts.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 01:01:27'!
send: aCard toBeVerifiedBy: aMerchantProcessor generateTicketFor: aCart
	^aCart totalPriceOfAllProducts.! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 16:21:51'!
invalidCardErrorMessage

^'It is not possible to checkout an invalid card'! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 16:35:14'!
verify: aCard isValidOn: aDate

	^ (aDate < aCard expiringDate).! !


!classDefinition: #PriceList category: 'TusLibros'!
Object subclass: #PriceList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PriceList class' category: 'TusLibros'!
PriceList class
	instanceVariableNames: 'dictonaryOfPrices'!

!PriceList class methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 00:25:35'!
at: aProduct put: aPrice 

	dictonaryOfPrices at: aProduct put: aPrice.! !

!PriceList class methodsFor: 'as yet unclassified' stamp: 'AF 6/8/2023 20:26:17'!
new
	dictonaryOfPrices := Dictionary new.! !

!PriceList class methodsFor: 'as yet unclassified' stamp: 'ado 6/12/2023 00:25:25'!
priceOf: aProduct 

	^dictonaryOfPrices at: aProduct.! !
