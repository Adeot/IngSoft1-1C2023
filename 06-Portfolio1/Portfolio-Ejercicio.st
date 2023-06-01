!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'portfolio1 account1 portfolio2 account2 portfolio3 portfolio4 account3 account4'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'setup' stamp: 'sdfsd 5/22/2023 15:37:11'!
setUp

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account1 := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.! !


!ReceptiveAccountTest methodsFor: 'transactions' stamp: 'sdfsd 5/22/2023 14:48:37'!
deposit: aDepositValue on: anAccount
	
	^Deposit register: aDepositValue on: anAccount! !

!ReceptiveAccountTest methodsFor: 'transactions' stamp: 'sdfsd 5/22/2023 14:48:43'!
withdraw: aWithdrawValue from: anAccount
	
	^Withdraw register: aWithdrawValue on: anAccount! !


!ReceptiveAccountTest methodsFor: 'assertions' stamp: 'sdfsd 5/22/2023 15:51:32'!
assertCorrectMessageWhenInvalidIncorporationOf: aBankAsset into: aPortfolio
	"comment stating purpose of message"

	^[ self should: [aPortfolio incorporate: aBankAsset.] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: (Portfolio invalidIncorporationMessage) equals: error messageText.
			 ].
	]! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account1 balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test02DepositIncreasesBalanceOnTransactionValue 
	
	| depositValue |
	
	depositValue := 100.
	
	self deposit: depositValue on: account1.
		
	self assert: depositValue equals: account1 balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	self deposit: 100 on: account1.
	self withdraw: 50 from: account1.
		
	self assert: 50 equals: account1 balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test04WithdrawValueMustBePositive 

	| withdrawValue |
	
	withdrawValue := (self withdraw: 50 from: account1) value.
	
	self assert: 50 equals: withdrawValue
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |

	deposit := self deposit:  100 on: account1.
	withdraw := self withdraw: 50 from: account1.
		
	self assert: (account1 hasRegistered: deposit).
	self assert: (account1 hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw|
	
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account1 hasRegistered: deposit).
	self deny: (account1 hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := self deposit: 50 on: account1. 
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:03'!
test08NewPortfolioHasNoAccounts
		
	self assert: 0 equals: portfolio1 bankAssets size.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test09PortfolioCanIncorporateAnAccount

	portfolio1 incorporate: account1.
	
	self assert: (portfolio1 hasBankAsset: account1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test10PortfolioCanIncorporateAnAccountLeaveOneAccountOut

	portfolio1 incorporate: account1.
	
	self assert: (portfolio1 hasBankAsset: account1).
	self deny: (portfolio1 hasBankAsset: account2).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test11PortfolioBalanceisSumOfAccounts

	self deposit: 50 on: account1.
	self deposit: 300 on: account2.

	portfolio1 incorporate: account1.
	portfolio1 incorporate: account2.

	self assert: 350 equals: (portfolio1 balance).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:32'!
test12PortfolioCanIncorporateAPortfolio

	portfolio1 incorporate: portfolio2.
	
	self assert: (portfolio1 hasBankAsset: portfolio2).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test13PortfolioCanGetTransactionsFromAllItsAccounts

	| deposit deposit2 deposit3 withdraw |
	
	deposit := self deposit: 100 on: account1.
	withdraw := self withdraw: 50 from: account1.
	
	portfolio1 incorporate: account1.
	portfolio1 incorporate: account2.

	deposit2 := self deposit: 200 on: account2.
	deposit3 := self deposit: 200 on: account2.

	self assert: (Set with: deposit with: withdraw with: deposit2 with: deposit3) equals: (portfolio1 transactions).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test14PortfolioCanGetTransactionsFromAllItsAccountsAndPortfolios

	| deposit deposit2 deposit3 withdraw |
	
	deposit := self deposit: 100 on: account1.
	withdraw := self withdraw: 50 from: account1.
	
	portfolio1 incorporate: account1.
	portfolio2 incorporate: account2.
	portfolio1 incorporate: portfolio2.

	deposit2 := self deposit: 200 on: account2.
	deposit3 := self deposit: 300 on: account2.

	self assert: (Set with: deposit with: withdraw with: deposit2 with: deposit3) equals: (portfolio1 transactions).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test15PortfolioCanGetBalanceFromAllItsAccountsAndPortfolios

	| deposit deposit2 deposit3 withdraw |
	
	deposit := self deposit: 100 on: account1.
	withdraw := self withdraw: 50 from: account1.
	
	portfolio1 incorporate: account1.
	portfolio2 incorporate: account2.
	portfolio1 incorporate: portfolio2.

	deposit2 := self deposit: 200 on: account2.
	deposit3 := self deposit: 300 on: account2.
	
	self assert: 550 equals: (portfolio1 balance).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:57'!
test16PortfolioCanTellIfHasRegisteredATransactionFromAccount

	| deposit deposit2 deposit3 withdraw |
	
	deposit := self deposit: 100 on: account1.
	withdraw := self withdraw: 50 from: account1.
	
	portfolio1 incorporate: account1.
	
	portfolio2 incorporate: account2.
	
	deposit2 := self deposit: 200 on: account2.
	deposit3 := self deposit: 300 on: account2.
	
	self assert: (portfolio1 hasRegistered: deposit).
	self assert: (portfolio1 hasRegistered: withdraw).
	self deny: (portfolio1 hasRegistered: deposit2).

! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:42:15'!
test17PortfolioCanTellIfHasRegisteredATransactionFromAccountOrPortfolio
	
	| deposit deposit2 deposit3 |
	
	deposit := self deposit: 100 on: account1. 

	portfolio1 incorporate: account1.
	portfolio2 incorporate: account2.
	portfolio1 incorporate: portfolio2 .

	deposit2 := self deposit: 300 on: account2.
	deposit3 := self deposit: 300 on: account3.
	
	self assert:(portfolio1 hasRegistered: deposit).
	self assert:(portfolio1 hasRegistered: deposit2).
	self deny: (portfolio1 hasRegistered: deposit3).

! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:36:51'!
test18EmptyPortfolioHasNothingRegistered

	| deposit |
	
	deposit := self deposit: 100 on: account1. 
	
	self deny: (portfolio1 hasRegistered: deposit).


! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:49:18'!
test19PortfolioCantIncorporateItself

	self deposit: 100 on: account1.
	
	portfolio1 incorporate: account1.
	
	^(self assertCorrectMessageWhenInvalidIncorporationOf: portfolio1 into: portfolio1) value


! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:49:27'!
test20PortfolioCantIncorporateAPortfolioThatContainsSameBankAsset

	self deposit: 100 on: account1.
		
	portfolio1 incorporate: account1.
	
	portfolio2 incorporate: account1.

	^(self assertCorrectMessageWhenInvalidIncorporationOf: portfolio1 into: portfolio2) value


! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:40:43'!
test21PortfolioCantIncorporateAPortfolioYouAlreadyHave
"No podes tener de hijo a tu nieto."
	
	self deposit: 100 on: account1.
	self deposit: 200 on: account2.
	self deposit: 300 on: account3.
	self deposit: 400 on: account4.
	
	portfolio1 incorporate: account1.	
	portfolio2 incorporate: account2.
	portfolio3 incorporate: account3.	
	portfolio4 incorporate: account4.
	
	portfolio1 incorporate: portfolio2.	
	portfolio2 incorporate: portfolio3.	
	
	self deny:  (portfolio1 hasBankAsset: account2 ).
	self 
		should: [portfolio1 incorporate: portfolio3 .] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: (Portfolio invalidIncorporationMessage) equals: error messageText.

			self assert:  (portfolio1 hasBankAsset: portfolio2 ).
			self assert:  (portfolio1 hasBankAsset: account1 ).
			self deny:  (portfolio1 hasBankAsset: portfolio4 ).
			 ].


! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sdfsd 5/22/2023 15:50:56'!
test22PortfolioCantIncorporateAnAlreadyPresentReceptiveAccount

	self deposit: 100 on: account1.
	
	portfolio1 incorporate: account1.
	portfolio1 incorporate: account3.

	portfolio2 incorporate: account2.
	portfolio1 incorporate: portfolio2.
	
	^(self assertCorrectMessageWhenInvalidIncorporationOf: account1 into: portfolio1) value



! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 21:02:58'!
calcularBalanceCuentaconBalanceActual: currentBalance
	^self value + currentBalance .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'af 5/15/2023 19:27:25'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'af 5/15/2023 21:02:36'!
calcularBalanceCuentaconBalanceActual: currentBalance
	^-1 * self value + currentBalance .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BankAsset
	instanceVariableNames: 'rootPorfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAsset methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 17:48:06'!
balance
	^self subclassResponsibility .! !

!BankAsset methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 17:50:08'!
hasRegistered: aTransaction
	^ self  subclassResponsibility .! !

!BankAsset methodsFor: 'as yet unclassified' stamp: 'af 5/18/2023 21:58:09'!
rootPortfolios
^rootPorfolios .! !

!BankAsset methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 17:48:21'!
transactions
	^self subclassResponsibility .! !


!BankAsset methodsFor: 'transactions' stamp: 'af 5/18/2023 21:58:09'!
addNewRoot: aPortfolio
	rootPorfolios add: aPortfolio.
	(aPortfolio rootPortfolios) do: [:aGrandParentPortfolio | (self addNewRoot: aGrandParentPortfolio).] .! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAsset subclass: #Portfolio
	instanceVariableNames: 'bankAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 23:33:37'!
allBankAssetsDescendency
	| bankAssetsAccumulator |
	bankAssetsAccumulator := (Set with: self) addAll: bankAssets .
	bankAssets do: [:aBankAsset | (bankAssetsAccumulator addAll: (aBankAsset allBankAssetsDescendency)).] .
	^bankAssetsAccumulator.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 18:28:00'!
balance
	^bankAssets sum: [:aBankAsset | aBankAsset balance ] ifEmpty: [0].
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 18:24:08'!
bankAssets
	^bankAssets .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 18:26:49'!
hasBankAsset: aBankAsset
	^bankAssets includes: aBankAsset .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 18:29:30'!
hasRegistered: aTransaction
	^(bankAssets anySatisfy: [:aBankAsset | aBankAsset hasRegistered: aTransaction ]).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/18/2023 22:24:21'!
incorporate: aBankAssetToBeIncorporated
	(self satisfyConditionToBeIncorporated: aBankAssetToBeIncorporated) 
	ifTrue: [
	bankAssets add: aBankAssetToBeIncorporated .
	aBankAssetToBeIncorporated addNewRoot: self.]
	ifFalse:  [^self error: Portfolio invalidIncorporationMessage ] 
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 22:25:23'!
initialize
	bankAssets  := Set new.
	rootPorfolios  := Set new.
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/18/2023 21:58:09'!
rootsOfAllDescendency
	| rootsOfAll |
	rootsOfAll := Set new.
	(self allBankAssetsDescendency ) do: [:aBankAsset | (rootsOfAll addAll: (aBankAsset rootPortfolios ))].
	^rootsOfAll .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 22:53:28'!
satisfyConditionToBeIncorporated: aBankAssetToBeIncorporated
	^(((aBankAssetToBeIncorporated rootsOfAllDescendency) intersection: (self rootsOfAllDescendency)) isEmpty) .
	"(((aBankAssetToBeIncorporated rootsPortfolios) intersection: (self rootPortfolios)) isEmpty)"! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 18:28:47'!
transactions
	| transactions |
	transactions := Set new.
	bankAssets do: [:aBankAsset | transactions addAll: (aBankAsset transactions ).].
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'af 5/16/2023 20:05:25'!
invalidIncorporationMessage
	^'Cant add this bankAsset because it is already present in current portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'af 5/16/2023 21:16:08'!
initialize
	transactions := OrderedCollection new.
	rootPorfolios := Set new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'af 5/16/2023 22:39:54'!
allBankAssetsDescendency
	^Set with: self.
! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'af 5/15/2023 21:09:07'!
balance
	^transactions inject: 0 into: [:partialBalance :currentTransaction | currentTransaction calcularBalanceCuentaconBalanceActual: partialBalance ].
! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'af 5/16/2023 22:47:54'!
rootsOfAllDescendency
	^rootPorfolios .
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
