!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:01:05'!
test01aReportOfNewAccountIsOnlyBalance0
	| cuenta1 reporteCuenta1 |
	cuenta1 := ReceptiveAccount new.
	reporteCuenta1 := AccountReport newOfAccount: cuenta1.
	self assert: (OrderedCollection with: 'Balance = 0') equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:02:36'!
test02aReportCanContainTransactionsAndAffectsBalance
	| account1  reporteCuenta1 withdraw1 deposit1 |
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	
	reporteCuenta1 := AccountReport newOfAccount: account1 .
	self assert:  (OrderedCollection with: 'Depósito por 110' with: 'Extracción por 20' with: 'Balance = 90')
				equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:34:19'!
test03aReportCanContainTransfersAndAffectsBalance
	| account1  reporteCuenta1 withdraw1 deposit1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	account1 transferMoneyTo: account2 anAmountOf: 89.
	account2 transferMoneyTo: account1 anAmountOf: 9.
	"
	Salida por transferencia de 20.
Entrada por transferencia de 30.
"
	reporteCuenta1 := AccountReport newOfAccount: account1 .
	self assert:  (OrderedCollection with: 'Depósito por 110' with: 'Extracción por 20' 
	with: 'Salida por transferencia de 89' with: 'Entrada por transferencia de 9' with:'Balance = 10')
				equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 11:46:48'!
test04aReportCanContainTransfersAndAffectsBalanceFromPortfolio
	| account1  reporteCuenta1 withdraw1 deposit1 account2 account3 deposito4 portfolio1 printCorrecto |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	account1 transferMoneyTo: account2 anAmountOf: 89.
	account2 transferMoneyTo: account1 anAmountOf: 9.
	account3 := ReceptiveAccount new.
	deposito4 := Deposit register: 100 on: account3.
	portfolio1 := 	Portfolio with: account1 with: account3 .
	
	reporteCuenta1 := AccountReport newOfAccount: portfolio1 .
	printCorrecto := (OrderedCollection with: 'Depósito por 110' with: 'Extracción por 20' 
	with: 'Salida por transferencia de 89' with: 'Entrada por transferencia de 9' with: 'Depósito por 100' with:'Balance = 110').
	
	self assert: printCorrecto
				equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:45:41'!
test05TransferNetReportWithNoTransferIsZero
	| account1  reporteCuenta1 withdraw1 deposit1 printCorrecto account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	account1 transferMoneyTo: account2 anAmountOf: 89.
	account2 transferMoneyTo: account1 anAmountOf: 9.

	
	reporteCuenta1 := TransferNetReport newOfAccount: account1 .
	printCorrecto := -80.
	
	self assert: printCorrecto
				equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:49:54'!
test06TransferNetReportWithTransferIsSumOfTransfers
	| account1  reporteCuenta1 withdraw1 deposit1 printCorrecto account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	account1 transferMoneyTo: account2 anAmountOf: 89.
	account2 transferMoneyTo: account1 anAmountOf: 9.

	reporteCuenta1 := TransferNetReport newOfAccount: account1 .
	printCorrecto := -80.
	
	self assert: printCorrecto
				equals: (reporteCuenta1 print).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:51:53'!
test07aTranssferNetReportCanContainTransfersAndAffectsBalanceFromPortfolio
	| account1  reporteCuenta1 withdraw1 deposit1 account2 account3 deposito4 portfolio1 printCorrecto |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit1 := Deposit register: 110 on: account1 .
	withdraw1 := Withdraw register: 20 on: account1 .
	account1 transferMoneyTo: account2 anAmountOf: 89.
	account2 transferMoneyTo: account1 anAmountOf: 9.
	account3 := ReceptiveAccount new.
	account1 transferMoneyTo: account3 anAmountOf: 300.

	deposito4 := Deposit register: 100 on: account3.
	portfolio1 := 	Portfolio with: account1 with: account3 .
	
	reporteCuenta1 := TransferNetReport newOfAccount: portfolio1 .
	printCorrecto := -80.
	
	self assert: printCorrecto
				equals: (reporteCuenta1 print).! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'senderAccount1 recipientAccount1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/22/2023 21:32:53'!
setUp
	senderAccount1 := ReceptiveAccount new.
	recipientAccount1 := ReceptiveAccount new.
		! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:00:41'!
test01aTransactionCantHaveNegativeValue
	
	| invalidOperation |
	invalidOperation := [senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: -100.].
	self 
		should: [ invalidOperation value. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Transfer invalidTransactionAmount equals: anError messageText. ]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:02:06'!
test02aTransactionModifiesBalanceOfItsAccounts
	
	senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	
	self assert: -50 equals: (senderAccount1 balance).
	self assert: 50 equals: (recipientAccount1 balance).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:08:00'!
test03aTransferAndWithdrawAndDepositModifiesBalanceOfItsAccounts
	
	| deposit1 withdraw1 |
	senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	deposit1 := Deposit register: 110 on: senderAccount1.
	withdraw1 := Withdraw register: 20 on: recipientAccount1.
	
	self assert: 60 equals: (senderAccount1 balance).
	self assert: 30 equals: (recipientAccount1 balance).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:30:52'!
test04anAccountHasRegisteredItsTransferAndOtherTransactions
	
	| deposit1 withdraw1 transfer1 |
	transfer1 := senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	deposit1 := Deposit register: 110 on: senderAccount1.
	withdraw1 := Withdraw register: 20 on: recipientAccount1.

	self assert: (senderAccount1 hasRegistered: deposit1).
	self assert: (senderAccount1 hasRegistered: (transfer1 transferSender )).
	self deny: (senderAccount1 hasRegistered: withdraw1 ).
	self deny: (senderAccount1 hasRegistered: (transfer1 transferRecipient )).
	
	self deny: (recipientAccount1 hasRegistered: deposit1).
	self deny: (recipientAccount1 hasRegistered: (transfer1 transferSender )).
	self assert: (recipientAccount1 hasRegistered: withdraw1 ).
	self assert: (recipientAccount1 hasRegistered: (transfer1 transferRecipient )).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:50:09'!
test05aSenderWithATransferCanKnowItsRecipient
	
	| transfer1 transferSenderTransaction1 |
	transfer1 := senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	transferSenderTransaction1 := transfer1 transferSender.
	self assert:  recipientAccount1 equals: (senderAccount1 recipientOfTransferSend: transferSenderTransaction1 ).
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:56:46'!
test06aRecipientWithATransferCanKnowItsSender
	
	| transfer1 transferRecipientTransaction1 |
	transfer1 := senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	transferRecipientTransaction1 := transfer1 transferRecipient .
	self assert: senderAccount1 equals: (recipientAccount1 senderOfTransferRecipient: transferRecipientTransaction1 ).
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 14:08:06'!
test07aRecipientWithATransferOnlyKnowItsSenderIfItsTheirs
	
	| transfer1 transferRecipientTransaction1 outsiderAccount |
	transfer1 := senderAccount1 transferMoneyTo: recipientAccount1 anAmountOf: 50.
	transferRecipientTransaction1 := transfer1 transferRecipient .
	
	outsiderAccount := ReceptiveAccount new.
	
	self 
		should: [  (outsiderAccount senderOfTransferRecipient: transferRecipientTransaction1 )]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ReceptiveAccount invalidRequestOfTransferInformation equals: anError messageText.]
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: 'nameOfAccount'!


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'AF 6/1/2023 16:30:53'!
initializeWithNamed: aName 
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'reporting' stamp: 'AF 6/1/2023 11:44:50'!
reportTransactionTo: aReport
	accounts do: [:anAccount | anAccount reportTransactionTo: aReport .].
	^self.! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 16:33:03'!
named: aName
	^self new initializeWithNamed: aName ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 16:33:20'!
named: aName with: anAccount 

	^(self new initializeWithNamed: aName)
		add: anAccount;
		yourself ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 16:33:43'!
named: aName with: anAccount with: anotherAccount 

	^(self new initializeWithNamed: aName)
		add: anAccount;
		add: anotherAccount;
		yourself ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AF 6/1/2023 16:31:33'!
initializeWithNamed: aName 
	
	super initialize.
	transactions := OrderedCollection new.
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AF 5/26/2023 14:02:47'!
recipientOfTransferSend: aTransferSenderTransaction
	| aTransferSenderTransaction1 |
	aTransferSenderTransaction1 := transactions detect: [:aTransaction | (aTransaction == aTransferSenderTransaction)] 
							ifNone: [^self error: ((self class) invalidRequestOfTransferInformation )].
	^aTransferSenderTransaction1 recipient .! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AF 5/26/2023 14:02:03'!
senderOfTransferRecipient: aTransferRecipientTransaction
	| aTransferRecipientTransaction1 |
	aTransferRecipientTransaction1 := transactions detect: [:aTransaction | (aTransaction == aTransferRecipientTransaction)] 
							ifNone: [^self error: ((self class) invalidRequestOfTransferInformation )].
	^aTransferRecipientTransaction1 sender.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AF 5/26/2023 13:01:33'!
transferMoneyTo: aReceptiveAccount anAmountOf: aValue
	^Transfer newFrom: self  to: aReceptiveAccount withValue: aValue.
	! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'AF 5/29/2023 16:26:40'!
reportTransactionTo: aReport
	transactions do: [:aTransaction | aTransaction reportThisTransactionTo: aReport .].
	^self.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 14:03:32'!
invalidRequestOfTransferInformation
^'This Transfer was not made by this account, therefore cant provide sender nor reciever'! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 16:32:29'!
named: aName 
	^self new initializeWithNamed: aName ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:21:15'!
reportThisTransactionTo: aReport
	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AF 5/26/2023 12:51:45'!
register: aValueOrTransfer on: account

	| transaction |
	
	transaction := self for: aValueOrTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:21:57'!
reportThisTransactionTo: aReport
	aReport reportDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferRecipient category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferRecipient
	instanceVariableNames: 'fromTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:41:02'!
affectBalance: aBalance

	^fromTransfer affectBalanceFromRecipient: aBalance.! !

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:22:56'!
initializeFor: aTransfer

	fromTransfer := aTransfer.
	aTransfer transferRecipientTransactionIs: self.! !

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 15:42:35'!
recipient
	^fromTransfer recipient .! !

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:22:25'!
reportThisTransactionTo: aReport
	aReport reportTransferRecipient: self.! !

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:44:58'!
sender
	^fromTransfer sender .! !

!TransferRecipient methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:40:05'!
value
	^fromTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferRecipient class' category: 'Portfolio-Solucion'!
TransferRecipient class
	instanceVariableNames: ''!

!TransferRecipient class methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:17:23'!
for: aTransfer
	^ self new initializeFor: aTransfer! !


!classDefinition: #TransferSender category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferSender
	instanceVariableNames: 'fromTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:41:38'!
affectBalance: aBalance

	^fromTransfer affectBalanceFromSender: aBalance.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:26:33'!
initializeFor: aTransfer

	fromTransfer := aTransfer.
	aTransfer transferSenderTransactionIs: self.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:45:42'!
recipient
	^fromTransfer recipient .! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:22:47'!
reportThisTransactionTo: aReport
	aReport reportTransferSender: self.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 15:42:41'!
sender
	^fromTransfer sender.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:40:15'!
value
	^fromTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSender class' category: 'Portfolio-Solucion'!
TransferSender class
	instanceVariableNames: ''!

!TransferSender class methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:17:30'!
for: aTransfer
	^ self new initializeFor: aTransfer! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:23:09'!
reportThisTransactionTo: aReport
	aReport reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:56:35'!
print
	^self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:56:13'!
reportDeposit: aDeposit
	^self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:55:58'!
reportTransferRecipient: aTransferRecipient
	^self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:55:42'!
reportTransferSender: aTransferSender
	^self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:55:24'!
reportWithdraw: aWithdraw
	^self subclassResponsibility .! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Report subclass: #AccountReport
	instanceVariableNames: 'accountToBeReported lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 15:51:32'!
initializeReportOf: anAccount
	accountToBeReported := anAccount.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 11:45:03'!
print
	lines:= OrderedCollection new.
	accountToBeReported reportTransactionTo: self.
	lines add: ('Balance = ', accountToBeReported balance asString).
	^lines
! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:27:43'!
reportDeposit: aDeposit
	lines add: ('Depósito por ', aDeposit value asString )! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:38:23'!
reportTransferRecipient: aTransferRecipient
	lines add: ('Entrada por transferencia de ', aTransferRecipient value asString ) ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:38:02'!
reportTransferSender: aTransferSender
	lines add: ('Salida por transferencia de ', aTransferSender value asString ) ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:28:40'!
reportWithdraw: aWithdraw
	lines add: ('Extracción por ', aWithdraw value asString ) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 15:50:58'!
newOfAccount: anAccount
	^(self new) initializeReportOf: anAccount.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'accountToBeReported totalSum'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:39:59'!
initializeReportOf: anAccount
	accountToBeReported := anAccount.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:41:34'!
print
	totalSum := 0.
	accountToBeReported reportTransactionTo: self.
	^totalSum .
! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:42:18'!
reportDeposit: aDeposit
	totalSum := totalSum  + 0.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:43:22'!
reportTransferRecipient: aTransferRecipient
	totalSum := totalSum  + aTransferRecipient value! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:43:40'!
reportTransferSender: aTransferSender
	totalSum := totalSum  - aTransferSender value! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:42:38'!
reportWithdraw: aWithdraw
	totalSum  := totalSum  + 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'Portfolio-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'AF 6/1/2023 12:40:11'!
newOfAccount: anAccount
	^(self new) initializeReportOf: anAccount.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value recipient sender transferRecipientTransaction transferSenderTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:43:30'!
affectBalanceFromRecipient: aBalance
	^aBalance + value .
! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:43:43'!
affectBalanceFromSender: aBalance
	^aBalance - value .
! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:09:31'!
initializeFrom: aSenderAccount  to: aRecipientAccount withValue: aValue
	sender  := aSenderAccount .
	recipient := aRecipientAccount .
	value  := aValue .

	TransferSender register: self on: aSenderAccount.
	TransferRecipient register: self on: aRecipientAccount .
	^self.
! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:12:03'!
recipient
	^recipient.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 12:11:38'!
sender
	^sender.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:27:46'!
transferRecipient
	^transferRecipientTransaction! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:24:51'!
transferRecipientTransactionIs: aTransferRecipient.
	transferRecipientTransaction := aTransferRecipient .! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:27:33'!
transferSender
	^transferSenderTransaction! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/26/2023 13:25:38'!
transferSenderTransactionIs: aTransferSenderTransaction.
	transferSenderTransaction := aTransferSenderTransaction.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AF 5/29/2023 16:39:25'!
value
	^value .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AF 5/22/2023 21:24:55'!
invalidTransactionAmount
	^'The value must be a positive number in order to be a valid transaction'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AF 5/22/2023 21:33:46'!
newFrom: aSenderAccount  to: aRecipientAccount withValue: aValue
	^(aValue <= 0) ifTrue: [self error: (self invalidTransactionAmount)] 
	ifFalse: [(self new) initializeFrom: aSenderAccount  to: aRecipientAccount withValue: aValue]! !
