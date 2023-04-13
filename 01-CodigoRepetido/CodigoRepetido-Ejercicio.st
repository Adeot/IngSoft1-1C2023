!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/10/2023 21:27:55'!
activity: Aclosure takesLessTimeThan: time	
	| timeBeforeRunning timeAfterRunning|
	timeBeforeRunning := Time millisecondClockValue.
	
	Aclosure value .
	
	timeAfterRunning := Time millisecondClockValue.
		
	self assert: (timeAfterRunning-timeBeforeRunning) < time.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:33:29'!
checkNumberOfExpectedActiveUsers: expectedActiveUsers checkNumberOfSuspendedUsers: expectedSuspendedUsers  checkNumberOfTotalUsers: expectedTotalUsers   inCustomerBook: customerBook
	self
		assert: expectedActiveUsers 
		equals: customerBook numberOfActiveCustomers.
	self
		assert: expectedSuspendedUsers  
		equals: customerBook numberOfSuspendedCustomers.
	self
		assert: expectedTotalUsers
		equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/12/2023 18:49:07'!
illegalActivity: illegalClosure expectedError: nameOfError shouldSatisfy: conditionToBeSatisfiedClosure
	
	[  illegalClosure value  self fail]
		on: nameOfError
		do: conditionToBeSatisfiedClosure! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/10/2023 21:33:27'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
		self activity: [customerBook addCustomerNamed: 'John Lennon'.] takesLessTimeThan: (50 * millisecond)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/10/2023 21:34:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook  paulMcCartney |
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.

	self activity: [customerBook removeCustomerNamed: paulMcCartney.] takesLessTimeThan: (100 * millisecond)

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:34:04'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook  |
	customerBook := CustomerBook new.
	
	self illegalActivity:  [ customerBook addCustomerNamed: ''. ] expectedError: Error shouldSatisfy:  [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:34:56'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self illegalActivity:  [ customerBook removeCustomerNamed: 'Paul McCartney'.] expectedError: NotFound shouldSatisfy: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:35:43'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self
		checkNumberOfExpectedActiveUsers: 0
		checkNumberOfSuspendedUsers: 1
		checkNumberOfTotalUsers: 1
		inCustomerBook: customerBook .
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:36:10'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
		self
		checkNumberOfExpectedActiveUsers: 0
		checkNumberOfSuspendedUsers: 0
		checkNumberOfTotalUsers: 0
		inCustomerBook: customerBook .
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/12/2023 18:47:37'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		self illegalActivity:  [ customerBook suspendCustomerNamed: 'George Harrison'.] expectedError: CantSuspend  shouldSatisfy:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:37:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		illegalActivity: [ customerBook suspendCustomerNamed: johnLennon ]
		expectedError: CantSuspend
		shouldSatisfy: [ :argm4_3 |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:27:39'!
includesActiveCustomerNamed: nameUser
	^ active includes: nameUser.! !

!CustomerBook methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:28:20'!
includesCustomerNamed: nameUser
	^ (self includesActiveCustomerNamed: nameUser) or: (self includesSuspendedCustomerNamed: nameUser).! !

!CustomerBook methodsFor: 'testing' stamp: 'afchb 4/13/2023 16:27:58'!
includesSuspendedCustomerNamed: nameUser
	^ suspended includes: nameUser.! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'afchb 4/13/2023 16:23:45'!
addCustomerNamed: aName	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'afchb 4/13/2023 16:25:37'!
numberOfCustomers	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'afchb 4/13/2023 16:26:38'!
removeCustomerNamed: name1
	(self includesCustomerNamed: name1) ifFalse: [ ^ NotFound signal ].
	(self includesActiveCustomerNamed: name1) ifTrue: [ ^ active remove: name1 ].
	(self includesSuspendedCustomerNamed: name1) ifTrue: [ ^ suspended remove: name1 ].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
