!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'initialPosition north south east west marsRoverCuriosity initialOrientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setUpAndTearDown' stamp: 'ado 5/14/2023 20:57:57'!
setUp

	north := North new.
	south := South new.
	east := East new.
	west := West new.
	
	initialPosition := PositionOfMarsRover newPositionAtXCoordinate: 0 andYCoordinate: 0.
	initialOrientation := North new.
	
	marsRoverCuriosity := MarsRover newAtPosition: initialPosition andOrientation: initialOrientation.
	! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'ado 5/14/2023 22:20:54'!
assertAfter: aMarsRover receives: someSignals thePositionEquals: anExpectedPosition andTheOrientationEquals: anExpectedOrientation

	| commands |
	
	commands := Command  newWithSignals: someSignals.	
	aMarsRover recieveCommand: commands.

	self assert: (aMarsRover position) equals: anExpectedPosition.
	self assert: (aMarsRover orientation) equals: anExpectedOrientation.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'af 5/15/2023 12:55:37'!
assertOrientationOf: aMarsRover afterReceiving: someSignals equals: anExpectedOrientation
	
	| commands |
	
	commands := Command newWithSignals: someSignals.	
	aMarsRover recieveCommand: commands.	
	
	self assert: anExpectedOrientation equals: (aMarsRover orientation).! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'ado 5/14/2023 22:52:28'!
assertPositionOf: aMarsRover afterReceiving: someSignals equals: anExpectedPosition

	| commands |
	
	commands := Command newWithSignals: someSignals.	
	aMarsRover recieveCommand: commands.

	self assert: (aMarsRover position) equals: anExpectedPosition.! !


!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/15/2023 17:22:26'!
test000MarsRoverStaysTheSameWithEmptyCommand
	self assertAfter: marsRoverCuriosity receives: '' thePositionEquals: initialPosition andTheOrientationEquals: initialOrientation .! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:43:47'!
test00MarsRoverIsCorrectlyInitializedInAPosition

	self assert: marsRoverCuriosity position equals: initialPosition .! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:43:42'!
test01MarsRoverIsCorrectlyInitializedInOrientation

	self assert: marsRoverCuriosity orientation equals: north .! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:40:02'!
test02MarsRoverMovesFowardCorrectlyWhenFacingNorth

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 0 andYCoordinate: 1.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'f' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:40:28'!
test03MarsRoverMovesBackwardsCorrectlyWhenFacingNorth

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 0 andYCoordinate: -1.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'b' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:37:45'!
test04MarsRoverFacesEastWhenRotatingRightOneTimeFromNorth

	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'r' equals: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:31:40'!
test05MarsRoverFacesSouthWhenRotatingRightTwoTimesFromNorth
	
	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'rr' equals: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:34:26'!
test06MarsRoverFacesWestWhenRotatingRightThreeTimesFromNorth
	
	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'rrr' equals: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:34:48'!
test07MarsRoverFacesNorthWhenRotatingRightFourTimesFromNorth
	
	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'rrrr' equals: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:40:24'!
test08MarsRoverFacesWestWhenRotatingLeftOneTimeFromNorth
	
	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'l' equals: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:40:48'!
test09MarsRoverFacesSouthWhenRotatingLeftTwoTimesFromNorth

	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'll' equals: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:41:04'!
test10MarsRoverFacesEastWhenRotatingLeftThreeTimesFromNorth

	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'lll' equals: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:41:21'!
test11MarsRoverFacesNorthWhenRotatingLeftFourTimesFromNorth
	
	self assertOrientationOf: marsRoverCuriosity afterReceiving: 'llll' equals: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:44:37'!
test12MarsRoverMovesFowardCorrectlyWhenFacingEast 

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 1 andYCoordinate: 0.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'rf' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:47:12'!
test13MarsRoverMovesBackwardsCorrectlyWhenFacingEast 

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: -1 andYCoordinate: 0.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'rb' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:48:03'!
test14MarsRoverMovesFowardCorrectlyWhenFacingWest 
	
	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: -1 andYCoordinate: 0.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'lf' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:49:00'!
test15MarsRoverMovesBackwardsCorrectlyWhenFacingWest 
	
	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 1 andYCoordinate: 0.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'lb' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:49:30'!
test16MarsRoverMovesFowardCorrectlyWhenFacingSouth

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 0 andYCoordinate: -1.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'llf' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 20:50:15'!
test17MarsRoverMovesBackwardsCorrectlyWhenFacingSouth

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 0 andYCoordinate: 1.
	
	self assertPositionOf: marsRoverCuriosity afterReceiving: 'llb' equals: expectedPosition.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:53:47'!
test18MarsRoverDoesNothingWhenReceivesBlankCommand

	self assertAfter: marsRoverCuriosity receives: '' thePositionEquals: initialPosition andTheOrientationEquals: initialOrientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/15/2023 13:39:04'!
test19MarsRoverDoesNothingWhenReceivesInvalidCommand	| commands |
	commands := Command newWithSignals: 'x'.
	self 
		should: [ marsRoverCuriosity recieveCommand: commands] 
		raise: Error 
		withExceptionDo: [ :error | 
			self assert:  (MarsRover invalidSignalMessage)   equals: (error messageText) .
			self assert: initialOrientation equals: marsRoverCuriosity orientation ].! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ado 5/14/2023 22:22:41'!
test20MarsRoverMovesFowardRotatesAndContinuesCommandWhenAllAreValid

	| expectedPosition|
	
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: 2 andYCoordinate: 2.
	
	self assertAfter: marsRoverCuriosity receives: 'ffrff' thePositionEquals: expectedPosition andTheOrientationEquals: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'af 5/15/2023 13:40:57'!
test21MarsRoverFollowsCommandsOnlyUntilLastValidSignal

	| expectedPosition commands |
	expectedPosition := PositionOfMarsRover newPositionAtXCoordinate: -1  andYCoordinate: 1.	commands := Command newWithSignals: 'flflxrrb'.

	self 
		should: [ marsRoverCuriosity recieveCommand: commands] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: (MarsRover invalidSignalMessage) equals: error messageText.
			self assert: expectedPosition equals: (marsRoverCuriosity position).
			self assert: south equals: marsRoverCuriosity orientation .
			 ].! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: 'signals'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:37:49'!
initializeWithSignals: aStringOfSignals
	signals := aStringOfSignals collect: [:aChar | Signal newWith: aChar ]! !

!Command methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:39:16'!
signals
	^signals ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:34:22'!
newWithSignals: aStringOfSignals
 	^(self new) initializeWithSignals: aStringOfSignals.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion orientacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'commands' stamp: 'af 5/15/2023 13:02:38'!
followCommand: commandsToBeFollowed
	^(commandsToBeFollowed isEmpty) 
		ifTrue: [self .] 	
		ifFalse: [self followThisCommand: (commandsToBeFollowed first) andContinueWith: (commandsToBeFollowed allButFirst) ].! !

!MarsRover methodsFor: 'commands' stamp: 'af 5/12/2023 22:35:38'!
followThisCommand: aSingleCommandToBeFollowed andContinueWith: commandsToBeFollowed
	aSingleCommandToBeFollowed beDoneBy: self andContinueWithCommands: commandsToBeFollowed.! !

!MarsRover methodsFor: 'commands' stamp: 'af 5/15/2023 13:38:42'!
haltCommands
	^self error: (MarsRover invalidSignalMessage).
! !

!MarsRover methodsFor: 'commands' stamp: 'af 5/12/2023 23:43:15'!
recieveCommand: aCommand
	^self followCommand: (aCommand signals).! !


!MarsRover methodsFor: 'moving' stamp: 'af 5/15/2023 13:50:44'!
moveBackwards
	^posicion  := orientacion moveBackwardsMarsRover: self.! !

!MarsRover methodsFor: 'moving' stamp: 'af 5/15/2023 13:51:00'!
moveFoward
	^posicion := orientacion moveFowardMarsRover: self.! !


!MarsRover methodsFor: 'initializing' stamp: 'af 5/12/2023 00:04:55'!
initializeWith: aPosition andOrientation: anOrientation.
	posicion  := aPosition.
	orientacion  := anOrientation.! !


!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:51:12'!
rotate90DegreesLeft
	orientacion rotate90DegreesLeftMarsRover: self.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:47:28'!
rotate90DegreesLeftFromEast
	orientacion := North new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:49:31'!
rotate90DegreesLeftFromNorth
	orientacion := West new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:48:31'!
rotate90DegreesLeftFromSouth
	orientacion := East new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:47:53'!
rotate90DegreesLeftFromWest
	orientacion := South new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:51:53'!
rotate90DegreesRight
	orientacion rotate90DegreesRightMarsRover: self.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:48:56'!
rotate90DegreesRightFromEast
	orientacion := South new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:49:41'!
rotate90DegreesRightFromNorth
	orientacion := East new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:50:01'!
rotate90DegreesRightFromSouth
	orientacion := West new.! !

!MarsRover methodsFor: 'rotations' stamp: 'af 5/12/2023 14:50:28'!
rotate90DegreesRightFromWest
	orientacion := North new.! !


!MarsRover methodsFor: 'locationAndStatus' stamp: 'af 5/12/2023 15:03:06'!
orientation
	^orientacion .! !

!MarsRover methodsFor: 'locationAndStatus' stamp: 'af 5/12/2023 15:16:22'!
position
	^posicion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'nil' stamp: 'af 5/12/2023 00:04:17'!
newAtPosition: aPosition andOrientation: anOrientation
	^(self new) initializeWith: aPosition andOrientation: anOrientation.! !


!MarsRover class methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 13:19:20'!
invalidSignalMessage
	^'An invalid signal was recieved, there are no instructions to be followed. Stoping future signals from the same command.'! !


!classDefinition: #OrientationOfMarsRover category: 'MarsRover'!
Object subclass: #OrientationOfMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!OrientationOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 15:45:54'!
= anotherOrientation
	^self class = anotherOrientation class.! !

!OrientationOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:49:04'!
moveBackwardsMarsRover: aMarsRover
^self subclassResponsibility.! !

!OrientationOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:48:28'!
moveFowardMarsRover: aMarsRover
^self subclassResponsibility.! !

!OrientationOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 14:52:18'!
rotate90DegreesLeftMarsRover: aMarsRover
	^self subclassResponsibility .! !

!OrientationOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 14:52:25'!
rotate90DegreesRightMarsRover: aMarsRover
	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrientationOfMarsRover class' category: 'MarsRover'!
OrientationOfMarsRover class
	instanceVariableNames: ''!

!OrientationOfMarsRover class methodsFor: 'nil' stamp: 'ado 5/14/2023 13:15:47'!
newOrientationAt: anOrientationName
	(self isValidOrientation: anOrientationName) 
	
	ifTrue: 
	[^(OrientationOfMarsRover allSubclasses  detect:[:aOrientation | aOrientation canHandle: anOrientationName]) newOr] 
	
	ifFalse: [^self error: 'Not A Valid Orientation']
! !


!OrientationOfMarsRover class methodsFor: 'as yet unclassified' stamp: 'af 5/11/2023 23:56:29'!
canHandle: anOrientationName 
	^self subclassResponsibility 
! !

!OrientationOfMarsRover class methodsFor: 'as yet unclassified' stamp: 'af 5/11/2023 23:50:48'!
isValidOrientation: anOrientationName
	| orientacionesValidas |
	orientacionesValidas := Set with: 'N'  with: 'S' with: 'W' with: 'E'.

	^orientacionesValidas includes: anOrientationName .! !

!OrientationOfMarsRover class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 00:00:07'!
newOr
	^(self new) initialize.! !


!classDefinition: #East category: 'MarsRover'!
OrientationOfMarsRover subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:51:28'!
moveBackwardsMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitWest .! !

!East methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:50:06'!
moveFowardMarsRover: aMarsRover
^(aMarsRover position ) moveOneUnitEast .! !

!East methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:53:55'!
rotate90DegreesLeftMarsRover: aMarsRover
	^aMarsRover rotate90DegreesLeftFromEast .! !

!East methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:54:26'!
rotate90DegreesRightMarsRover: aMarsRover
	^aMarsRover rotate90DegreesRightFromEast .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'nil' stamp: 'af 5/11/2023 23:55:44'!
canHandle: anOrientationName 
	^anOrientationName='E'.
! !


!classDefinition: #North category: 'MarsRover'!
OrientationOfMarsRover subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:51:08'!
moveBackwardsMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitSouth .! !

!North methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:50:54'!
moveFowardMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitNorth .! !

!North methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:55:20'!
rotate90DegreesLeftMarsRover: aMarsRover
	^aMarsRover rotate90DegreesLeftFromNorth .! !

!North methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:55:08'!
rotate90DegreesRightMarsRover: aMarsRover
	^aMarsRover rotate90DegreesRightFromNorth .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'nil' stamp: 'af 5/11/2023 23:55:58'!
canHandle: anOrientationName 
	^anOrientationName='N'.! !


!classDefinition: #South category: 'MarsRover'!
OrientationOfMarsRover subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:50:54'!
moveBackwardsMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitNorth .! !

!South methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:51:08'!
moveFowardMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitSouth .! !

!South methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:56:21'!
rotate90DegreesLeftMarsRover: aMarsRover
	^aMarsRover rotate90DegreesLeftFromSouth .! !

!South methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:56:06'!
rotate90DegreesRightMarsRover: aMarsRover
	^aMarsRover rotate90DegreesRightFromSouth .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'nil' stamp: 'af 5/11/2023 23:56:07'!
canHandle: anOrientationName 
	^anOrientationName='S'.! !


!classDefinition: #West category: 'MarsRover'!
OrientationOfMarsRover subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:50:06'!
moveBackwardsMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitEast .! !

!West methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 23:51:28'!
moveFowardMarsRover: aMarsRover
^(aMarsRover position) moveOneUnitWest .! !

!West methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:57:19'!
rotate90DegreesLeftMarsRover: aMarsRover
	^aMarsRover rotate90DegreesLeftFromWest.! !

!West methodsFor: 'marsRoverActions' stamp: 'af 5/12/2023 14:57:05'!
rotate90DegreesRightMarsRover: aMarsRover
	^aMarsRover rotate90DegreesRightFromWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'nil' stamp: 'af 5/11/2023 23:56:17'!
canHandle: anOrientationName 
	^anOrientationName='W'.! !


!classDefinition: #PositionOfMarsRover category: 'MarsRover'!
Object subclass: #PositionOfMarsRover
	instanceVariableNames: 'posicionEjeX posicionEjeY'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 15:38:35'!
= anotherPositionOfMarsRiver
	^(self position = anotherPositionOfMarsRiver  position ).! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'ado 5/14/2023 20:13:31'!
initializeWithXCoordinate: anXcordinate andYCoordinate: anYcordinate.
	posicionEjeX  := anXcordinate .
	posicionEjeY  := anYcordinate .! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 13:52:22'!
moveOneUnitEast
	^PositionOfMarsRover newPositionAtXCoordinate: (posicionEjeX+1) andYCoordinate: posicionEjeY .! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 13:52:51'!
moveOneUnitNorth
	^PositionOfMarsRover newPositionAtXCoordinate: (posicionEjeX) andYCoordinate: (posicionEjeY+1).! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 13:53:07'!
moveOneUnitSouth

	^PositionOfMarsRover newPositionAtXCoordinate: (posicionEjeX) andYCoordinate: (posicionEjeY-1).! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 13:53:17'!
moveOneUnitWest
	^PositionOfMarsRover newPositionAtXCoordinate: (posicionEjeX-1) andYCoordinate: (posicionEjeY).! !

!PositionOfMarsRover methodsFor: 'as yet unclassified' stamp: 'af 5/11/2023 21:29:04'!
position
	^posicionEjeX@posicionEjeY.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionOfMarsRover class' category: 'MarsRover'!
PositionOfMarsRover class
	instanceVariableNames: ''!

!PositionOfMarsRover class methodsFor: 'as yet unclassified' stamp: 'ado 5/14/2023 20:17:56'!
newPositionAtXCoordinate: anXcordinate andYCoordinate: anYcordinate
	^(self new) initializeWithXCoordinate: anXcordinate andYCoordinate: anYcordinate.! !


!classDefinition: #Signal category: 'MarsRover'!
Object subclass: #Signal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Signal methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 22:37:22'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	^self subclassResponsibility .	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Signal class' category: 'MarsRover'!
Signal class
	instanceVariableNames: ''!

!Signal class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 22:45:05'!
canHandle: aCharacterThatRepresentsASignal
	^self subclassResponsibility .! !

!Signal class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:12:15'!
newSignal
	^(self new).! !

!Signal class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 22:43:51'!
newWith: aCharacterThatRepresentsASignal
	^(Signal allSubclasses  detect:[:aSignalClass | aSignalClass canHandle: aCharacterThatRepresentsASignal]) newSignal.! !


!classDefinition: #InvalidSignal category: 'MarsRover'!
Signal subclass: #InvalidSignal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!InvalidSignal methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:15:30'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	^aMarsRover haltCommands .	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidSignal class' category: 'MarsRover'!
InvalidSignal class
	instanceVariableNames: ''!

!InvalidSignal class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:06:36'!
canHandle: aCharacterThatRepresentsASignal
	| validChars |
	validChars := ValidSignal validCharacters.
	^(validChars includes: aCharacterThatRepresentsASignal) not.! !


!classDefinition: #ValidSignal category: 'MarsRover'!
Signal subclass: #ValidSignal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidSignal class' category: 'MarsRover'!
ValidSignal class
	instanceVariableNames: ''!

!ValidSignal class methodsFor: 'as yet unclassified' stamp: 'ado 5/14/2023 17:20:27'!
canHandle: aCharacterThatRepresentsASignal
	^false.! !

!ValidSignal class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:08:03'!
validCharacters
	^Set with: $l with: $r with: $f with: $b.! !


!classDefinition: #Backwards category: 'MarsRover'!
ValidSignal subclass: #Backwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Backwards methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:47:15'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	aMarsRover moveBackwards.
	aMarsRover followCommand: commandsToBeFollowedByMarsRover.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backwards class' category: 'MarsRover'!
Backwards class
	instanceVariableNames: ''!

!Backwards class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:09:54'!
canHandle: aCharacterThatRepresentsASignal
	^aCharacterThatRepresentsASignal=($b).! !


!classDefinition: #Foward category: 'MarsRover'!
ValidSignal subclass: #Foward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Foward methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:46:49'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	aMarsRover moveFoward .
	aMarsRover followCommand: commandsToBeFollowedByMarsRover.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Foward class' category: 'MarsRover'!
Foward class
	instanceVariableNames: ''!

!Foward class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:10:05'!
canHandle: aCharacterThatRepresentsASignal
	^aCharacterThatRepresentsASignal=($f).! !


!classDefinition: #RotateLeft category: 'MarsRover'!
ValidSignal subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:18:07'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	aMarsRover rotate90DegreesLeft .
	aMarsRover followCommand: commandsToBeFollowedByMarsRover.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:10:13'!
canHandle: aCharacterThatRepresentsASignal
	^aCharacterThatRepresentsASignal=($l).! !


!classDefinition: #RotateRight category: 'MarsRover'!
ValidSignal subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:18:21'!
beDoneBy: aMarsRover andContinueWithCommands: commandsToBeFollowedByMarsRover
	aMarsRover rotate90DegreesRight .
	aMarsRover followCommand: commandsToBeFollowedByMarsRover.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'as yet unclassified' stamp: 'af 5/12/2023 23:10:20'!
canHandle: aCharacterThatRepresentsASignal
	^aCharacterThatRepresentsASignal=($r).! !
