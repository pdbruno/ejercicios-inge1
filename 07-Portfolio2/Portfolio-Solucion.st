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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ms 10/17/2022 21:48:16'!
test08TransferFromOneAccountToAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Transfer register: 100 from: account1 to: account2.
	
	self assert: account1 balance equals: 100.
	self assert: account2 balance equals: 100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ms 10/19/2022 17:33:53'!
test09ReceptiveAccountKnowsRegisteredTransfer

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on: account1.
	transfer := Transfer register: 100 from: account1 to: account2.
	
	self assert: (account1 hasRegisteredTransfer: transfer).
	self assert: (account2 hasRegisteredTransfer: transfer).! !


!classDefinition: #SummaryReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:06:36'!
test01CanObtainTransferFromWithdraw

	| account1 account2 transfer deposit withdrawal |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on: account1.
	transfer := Transfer register: 100 from: account1 to: account2.
	
	deposit := transfer deposit.
	withdrawal := transfer withdrawal.
	
	self assert: deposit equals: withdrawal transfer deposit.
	self assert: withdrawal equals: deposit transfer withdrawal.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:07:09'!
test02GenerateSummaryReportForEmptyAccount

	| account summaryReport generatedReport | 
	
	account := ReceptiveAccount new.
	summaryReport := SummaryReport new.
	
	generatedReport := account generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Balance = 0').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:07:14'!
test03GenerateSummaryReportForAccountWithDeposit

	| account summaryReport generatedReport | 
	
	account := ReceptiveAccount new.
	summaryReport := SummaryReport new.
	Deposit register: 100 on: account.
	
	generatedReport := account generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Deposito por 100.' with: 'Balance = 100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:07:20'!
test04GenerateSummaryReportForAccountWithWithdraw

	| account summaryReport generatedReport | 
	
	account := ReceptiveAccount new.
	summaryReport := SummaryReport new.
	Withdraw register: 100 on: account.
	
	generatedReport := account generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Extraccion por 100.' with: 'Balance = -100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:07:26'!
test05GenerateSummaryReportForAccountWithTransferDeposit

	| account1 account2 summaryReport generatedReport | 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	summaryReport := SummaryReport new.
	Transfer register: 100 from: account1 to: account2.
	
	generatedReport := account2 generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:07:19'!
test06GenerateSummaryReportForAccountWithTransferWithdraw
	
	| account1 account2 summaryReport generatedReport | 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	summaryReport := SummaryReport new.
	Transfer register: 100 from: account1 to: account2.
	
	generatedReport := account1 generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:14:21'!
test07GenerateSummaryReportForPortfolioWithDeposit

	| portfolio account summaryReport generatedReport | 
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	summaryReport := SummaryReport new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	generatedReport := portfolio generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Deposito por 100.' with: 'Balance = 100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:16:26'!
test08GenerateSummaryReportForPortfolioWithWithdraw

	| portfolio account summaryReport generatedReport | 
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	summaryReport := SummaryReport new.
	Withdraw register: 100 on: account.
	
	portfolio add: account.
	
	generatedReport := portfolio generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Extraccion por 100.' with: 'Balance = -100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:17:20'!
test09GenerateSummaryReportForPortfolioWithTransferDeposit

	| portfolio account1 account2 summaryReport generatedReport | 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio new.
	summaryReport := SummaryReport new.
	Transfer register: 100 from: account1 to: account2.
	
	portfolio add: account2.
	
	generatedReport := portfolio generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100').
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:18:39'!
test10GenerateSummaryReportForPortfolioWithTransferWithdraw

	| portfolio account1 account2 summaryReport generatedReport | 
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio new.
	summaryReport := SummaryReport new.
	Transfer register: 100 from: account1 to: account2.
	
	portfolio add: account1.
	
	generatedReport := portfolio generateReport: summaryReport.
	
	self assert: generatedReport equals: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100').
! !


!classDefinition: #SummaryTreeStructureReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #SummaryTreeStructureReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryTreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/24/2022 14:49:44'!
test01GenerateSummaryReportForEmptyAccount

	| portfolio result report | 
	
	portfolio := Portfolio named: 'Portfolio 1'.
	report := SummaryTreeStructureReport new.
	
	result := portfolio generateReport: report.
	
	self assert: result equals: (OrderedCollection with: 'Portfolio 1' with: ' Balance = 0').
! !

!SummaryTreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/24/2022 15:07:42'!
test02GenerateSummaryReportForPortfolioWithOneEmptyAccount

	| portfolio result report | 
	
	portfolio := Portfolio named: 'Portfolio 1'.
	portfolio add: (ReceptiveAccount named: 'La Cuenta de Patito' ).
	report := SummaryTreeStructureReport new.
	
	result := portfolio generateReport: report.
	
	self assert: result equals: (OrderedCollection with: 'Portfolio 1'  with: ' La Cuenta de Patito'  with: '  Balance = 0' with: ' Balance = 0').
! !

!SummaryTreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/24/2022 15:19:06'!
test03GenerateSummaryReportForPortfolioWithOneUsedAccount

	| portfolio account result report | 
	
	portfolio := Portfolio named: 'Portfolio 1'.
	account := ReceptiveAccount named: 'La Cuenta de Patito'.
	Deposit register: 100 on: account.
	portfolio add: account.
	report := SummaryTreeStructureReport new.
	
	result := portfolio generateReport: report.
	
	self assert: result equals: (OrderedCollection with: 'Portfolio 1'  with: ' La Cuenta de Patito' with: '  Deposito por 100.' with: '  Balance = 100' with: ' Balance = 100').
! !

!SummaryTreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/24/2022 16:01:19'!
test04GenerateSummaryReportForPortfolioWithManyUsedAccount

	| johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio result actual | 
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 100 on: johnsAccount.
	Withdraw  register: 50 on: johnsAccount .
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	Transfer register: 100 from: angiesAccount to: ReceptiveAccount new.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with:
	johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	Deposit register: 100 on: myAccount.
	Withdraw register: 50 on: myAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with:
	myAccount with: childrenPortfolio.
	
	
	result := familyPortfolio generateReport: SummaryTreeStructureReport  new.
	actual := OrderedCollection new.
	actual 
	addLast: 'Portfolio de la familia';
	addLast: ' Cuenta Mia';
	addLast: '  Deposito por 100.';
	addLast: '  Extraccion por 50.';
	addLast: '  Balance = 50';
	addLast: ' Portfolio de hijos';
	addLast: '  Cuenta de Juan';
	addLast: '   Deposito por 100.';
	addLast: '   Extraccion por 50.';
	addLast: '   Balance = 50';
	addLast: '  Cuenta de Angeles';
	addLast: '   Salida por transferencia de 100.';
	addLast: '   Balance = -100';
	addLast: '  Balance = -50';
	addLast: ' Balance = 0'.
		
	self assert: result equals: actual.! !


!classDefinition: #TransferNetReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:10:01'!
test01TransferNetReportReturnZeroIfAccountEmpty
	
	| account transferReport |
	
	account := ReceptiveAccount new.
	
	transferReport := TransferNetReport new.
	
	self assert: (account generateReport: transferReport) equals: 0.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 19:46:25'!
test02TransferNetReportReturnCorrectForOneTransfer
	
	| account1 account2 transferReport1 transferReport2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer register: 100 from: account1 to: account2.
	
	transferReport1 := TransferNetReport new.
	transferReport2 := TransferNetReport new.
	
	self assert: (account1 generateReport: transferReport1) equals: -100.
	self assert: (account2 generateReport: transferReport2) equals: 100.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'ms 10/20/2022 20:22:59'!
test03TransferNetReportReturnCorrectForOneTransferAndOneDeposit
	
	| account1 account2 transferReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 300 on: account1.
	Transfer register: 100 from: account1 to: account2.
	
	transferReport := TransferNetReport new.
	
	self assert: (account1 generateReport: transferReport) equals: -100.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 19:42:22'!
test04TransferNetReportReturnCorrectForOneTransferAndOneWithdraw
	
	| account1 account2 transferReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Withdraw register: 300 on: account1.
	Transfer register: 100 from: account1 to: account2.
	
	transferReport := TransferNetReport new.
	
	self assert: (account1 generateReport: transferReport) equals: -100.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 20:28:16'!
test05TransferNetReportReturnCorrectForOneTransferForPortfolio
	
	| portfolio1 portfolio2 account1 account2 transferReport1 transferReport2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	
	Transfer register: 100 from: account1 to: account2.
	
	transferReport1 := TransferNetReport new.
	transferReport2 := TransferNetReport new.
	
	self assert: (portfolio1 generateReport: transferReport1) equals: -100.
	self assert: (portfolio2 generateReport: transferReport2) equals: 100.! !


!classDefinition: #TreeStructureReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #TreeStructureReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 21:25:47'!
test01TreeStructureReportReturnJustPortfolioIfEmpty
	
	| portfolio report |

	portfolio := Portfolio named: 'Portfolio 1'.
	
	
	report := TreeStructureReport new.
	
	self assert: (portfolio generateReport: report) equals: (OrderedCollection with: 'Portfolio 1').! !

!TreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 22:36:49'!
test02TreeStructureReportReturnWithOneChild
	
	| portfolio account report |
	
	account := ReceptiveAccount named: 'Receptive Account 1'.
	portfolio := Portfolio named: 'Portfolio 1' with: account.
	
	
	report := TreeStructureReport new.
	
	self assert: (portfolio generateReport: report) equals: (OrderedCollection with: 'Portfolio 1' with: ' Receptive Account 1').! !

!TreeStructureReportTest methodsFor: 'tests' stamp: 'ms 10/21/2022 22:55:00'!
test03TreeStructureReportReturnWithMultilevelChildren
	
	| johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio report expected |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with:
	johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with:
	myAccount with: childrenPortfolio.
	
	report := TreeStructureReport new.
	
	expected := OrderedCollection new.
	expected addLast: 'Portfolio de la familia';addLast: 	' Cuenta Mia';addLast: ' Portfolio de hijos';addLast: '  Cuenta de Juan';addLast: '  Cuenta de Angeles'.
	
	self assert: (familyPortfolio generateReport: report) equals: expected.! !


!classDefinition: #AbstractTransaction category: 'Portfolio-Solucion'!
Object subclass: #AbstractTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AbstractTransaction methodsFor: 'reports' stamp: 'ms 10/21/2022 19:01:56'!
aggregateToReport: aReport

	self subclassResponsibility 

! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
AbstractTransaction subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'ms 10/20/2022 20:37:26'!
affectTransferBalance: aBalance

	^aBalance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
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


!Deposit methodsFor: 'value' stamp: 'ms 10/21/2022 19:04:30'!
aggregateToReport: aReport
	
	^aReport aggregateDepositToReport: self.
	! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ms 10/21/2022 19:06:39'!
aggregateToReport: aReport
	
	^aReport aggregateWithdrawToReport: self.
	! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransferTransaction category: 'Portfolio-Solucion'!
AbstractTransaction subclass: #AccountTransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransferTransaction methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 23:03:06'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransferTransaction methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 17:52:35'!
initializeFor: aTransfer

	transfer := aTransfer 

! !

!AccountTransferTransaction methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 17:53:01'!
transfer

	^transfer

! !

!AccountTransferTransaction methodsFor: 'as yet unclassified' stamp: 'ms 10/21/2022 19:18:05'!
value

	^transfer value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferTransaction class' category: 'Portfolio-Solucion'!
AccountTransferTransaction class
	instanceVariableNames: ''!

!AccountTransferTransaction class methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 17:52:15'!
on: account forTransfer: aTransfer

	| transaction |
	
	transaction := self new initializeFor: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
AccountTransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 23:03:38'!
affectBalance: aBalance
	
	^aBalance + transfer value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'ms 10/21/2022 19:09:30'!
aggregateToReport: aReport
	
	^aReport aggregateTransferDepositToReport: self.
	! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
AccountTransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 23:03:43'!
affectBalance: aBalance
	
	^aBalance - transfer value! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'ms 10/21/2022 19:10:44'!
aggregateToReport: aReport
	
	^aReport aggregateTransferWithdrawToReport: self.
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
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

!Account methodsFor: 'transactions' stamp: 'ms 10/20/2022 20:33:53'!
inject: anInitialValue intoTransactions: aBlock
	
	^self transactions inject: anInitialValue into: aBlock ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'ms 10/21/2022 20:55:20'!
name
	^name! !


!Account methodsFor: 'reports' stamp: 'ms 10/21/2022 22:07:53'!
aggregateToReport: aReport

	self subclassResponsibility .

! !

!Account methodsFor: 'reports' stamp: 'ms 10/21/2022 20:14:47'!
generateReport: aReport

	^aReport generate: self.

! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
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


!Portfolio methodsFor: 'initialization' stamp: 'ms 10/21/2022 20:54:41'!
initialize
	name := 'Une Portfolie'.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ms 10/21/2022 21:26:49'!
initializeWithName: aName 

	name := aName.
! !

!Portfolio methodsFor: 'initialization' stamp: 'ms 10/21/2022 22:05:58'!
initializeWithName: aName andAccount: anAccount 

	name := aName.
	accounts := OrderedCollection with: anAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'ms 10/21/2022 22:39:18'!
initializeWithName: aName andAccount: anAccount andAccount: anotherAccount 

	name := aName.
	accounts := OrderedCollection with: anAccount with: anotherAccount! !


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


!Portfolio methodsFor: 'reports' stamp: 'ms 10/21/2022 22:19:12'!
aggregateToReport: aReport
	
	^aReport aggregatePortfolioToReport: self.! !

!Portfolio methodsFor: 'reports' stamp: 'ms 10/21/2022 22:03:47'!
inject: anInitialValue intoAccounts: aBlockClosure 
	^accounts inject: anInitialValue into: aBlockClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'instance creation' stamp: 'ms 10/21/2022 20:42:53'!
named: aName with: anAccount

	^self new initializeWithName: aName andAccount: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'ms 10/21/2022 22:42:38'!
named: aName with: anAccount with: anotherAccount
	^self new initializeWithName: aName andAccount: anAccount andAccount: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'initialization' stamp: 'ms 10/21/2022 21:26:38'!
named: aName 

	^self new initializeWithName: aName;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions transfers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ms 10/21/2022 22:13:43'!
initialize

	super initialize.
	name := 'Une Receptive Account'.
	transactions := OrderedCollection new.
	transfers := OrderedCollection new.
	^self! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ms 10/21/2022 22:13:38'!
initializeWith: aName

	super initialize.
	name := aName.
	transactions := OrderedCollection new.
	transfers := OrderedCollection new.
	
	^self! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ms 10/19/2022 17:23:56'!
registerTransfer: aTransfer

	transfers add: aTransfer 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ms 10/19/2022 17:22:31'!
hasRegisteredTransfer: aTransfer

	^ transfers includes: aTransfer 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'ms 10/21/2022 22:19:07'!
aggregateToReport: aReport
	
	^aReport aggregateReceptiveAccountToReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'ms 10/21/2022 22:13:21'!
named: aName
	^self new initializeWith: aName ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'evaluating' stamp: 'ms 10/21/2022 19:57:20'!
generate: anAccount
	self subclassResponsibility ! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Report subclass: #AccountReport
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'aggregate accounts' stamp: 'ms 10/24/2022 16:33:45'!
aggregatePortfolioToReport: aPortfolio

	| result |
	self augmentIndentation.
	result := self generate: aPortfolio.
	self reduceIndentation.
	^result! !

!AccountReport methodsFor: 'aggregate accounts' stamp: 'ms 10/24/2022 16:32:02'!
aggregateReceptiveAccountToReport: aReceptiveAccount
	
	self subclassResponsibility ! !


!AccountReport methodsFor: 'initialize' stamp: 'ms 10/24/2022 16:32:55'!
initialize
	indentation := ''! !


!AccountReport methodsFor: 'identation' stamp: 'ms 10/24/2022 16:32:59'!
augmentIndentation

	^ indentation := indentation , ' '! !

!AccountReport methodsFor: 'identation' stamp: 'ms 10/24/2022 16:33:04'!
reduceIndentation

	^ indentation := indentation copyFrom:1 to: (indentation size - 1)! !


!classDefinition: #SummaryTreeStructureReport category: 'Portfolio-Solucion'!
AccountReport subclass: #SummaryTreeStructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryTreeStructureReport methodsFor: 'evaluating' stamp: 'ms 10/24/2022 15:51:39'!
generate: aPortfolio 

	| result |
	
	result := aPortfolio inject: (OrderedCollection with: (indentation,aPortfolio name)) intoAccounts: 
	[:aCollection :aAccount | (aCollection addAllLast: (aAccount aggregateToReport: self)). aCollection]. 
	result add: indentation,' Balance = ',aPortfolio balance printString.
	^result! !


!SummaryTreeStructureReport methodsFor: 'aggregate accounts' stamp: 'ms 10/24/2022 15:54:33'!
aggregateReceptiveAccountToReport: aReceptiveAccount
	
	| result |
	self augmentIndentation.
	result  := OrderedCollection with: indentation, aReceptiveAccount name.
	self augmentIndentation.
	result addAllLast: ((aReceptiveAccount generateReport: SummaryReport new) collect: [ :aLine | indentation, aLine]).
	self reduceIndentation.
	self reduceIndentation.
	^result! !


!classDefinition: #TreeStructureReport category: 'Portfolio-Solucion'!
AccountReport subclass: #TreeStructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureReport methodsFor: 'aggregate accounts' stamp: 'ms 10/21/2022 22:56:52'!
aggregateReceptiveAccountToReport: aReceptiveAccount
	
	^OrderedCollection with: indentation,' ',aReceptiveAccount name! !


!TreeStructureReport methodsFor: 'evaluating' stamp: 'ms 10/21/2022 22:57:29'!
generate: aPortfolio

	^aPortfolio inject: (OrderedCollection with: (indentation,aPortfolio name)) intoAccounts: 
	[:aCollection :aAccount | (aCollection addAllLast: (aAccount aggregateToReport: self)). aCollection].
! !


!classDefinition: #TransactionReport category: 'Portfolio-Solucion'!
Report subclass: #TransactionReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionReport methodsFor: 'aggregate transactions' stamp: 'ms 10/24/2022 16:34:31'!
aggregateDepositToReport: aDeposit
	self subclassResponsibility ! !

!TransactionReport methodsFor: 'aggregate transactions' stamp: 'ms 10/24/2022 16:34:36'!
aggregateTransferDepositToReport: aTransferDeposit
	self subclassResponsibility ! !

!TransactionReport methodsFor: 'aggregate transactions' stamp: 'ms 10/24/2022 16:34:40'!
aggregateTransferWithdrawToReport: aTransferWithdraw
	self subclassResponsibility ! !

!TransactionReport methodsFor: 'aggregate transactions' stamp: 'ms 10/24/2022 16:34:45'!
aggregateWithdrawToReport: aWithdraw
	self subclassResponsibility ! !


!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
TransactionReport subclass: #SummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:05:43'!
aggregateDepositToReport: aDeposit
	
	^'Deposito por ',aDeposit value printString,'.'.! !

!SummaryReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:11:59'!
aggregateTransferDepositToReport: aTransferDeposit
	
	^'Entrada por transferencia de ',aTransferDeposit value printString,'.'.! !

!SummaryReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:11:30'!
aggregateTransferWithdrawToReport: aTransferWithdraw
	
	^'Salida por transferencia de ',aTransferWithdraw value printString,'.'.! !

!SummaryReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:11:45'!
aggregateWithdrawToReport: aWithdraw
	
	^'Extraccion por ',aWithdraw value printString,'.'.! !


!SummaryReport methodsFor: 'evaluating' stamp: 'ms 10/21/2022 19:16:03'!
generate: anAccount

	| collection |

	collection := anAccount inject: OrderedCollection new intoTransactions: 
		[:aCollection :aTransaction | aCollection add: (aTransaction aggregateToReport: self). aCollection ].
	collection add: 'Balance = ',anAccount balance printString.
	
	^collection.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
TransactionReport subclass: #TransferNetReport
	instanceVariableNames: 'partialBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'ms 10/21/2022 19:36:18'!
initialize
	partialBalance := 0! !


!TransferNetReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:41:45'!
aggregateDepositToReport: aDeposit 
! !

!TransferNetReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:44:52'!
aggregateTransferDepositToReport: aTransferDeposit 
	partialBalance := aTransferDeposit affectBalance: partialBalance.
	^partialBalance. ! !

!TransferNetReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:38:02'!
aggregateTransferWithdrawToReport: aTransferWithdraw 
	partialBalance := aTransferWithdraw affectBalance: partialBalance.
	^partialBalance ! !

!TransferNetReport methodsFor: 'aggregate transactions' stamp: 'ms 10/21/2022 19:42:45'!
aggregateWithdrawToReport: aWithdraw 
	! !


!TransferNetReport methodsFor: 'evaluating' stamp: 'ms 10/21/2022 19:37:18'!
generate: anAccount

	^anAccount inject: 0 intoTransactions: 
	[:partialTransferBalance :aTransaction | aTransaction aggregateToReport: self].



! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawal deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'accessing' stamp: 'ms 10/19/2022 17:49:07'!
deposit
	
	^deposit! !

!Transfer methodsFor: 'accessing' stamp: 'ms 10/19/2022 23:05:16'!
value
	
	^value
! !

!Transfer methodsFor: 'accessing' stamp: 'ms 10/19/2022 17:49:37'!
withdrawal
	
	^withdrawal
! !


!Transfer methodsFor: 'initialize' stamp: 'ms 10/19/2022 17:50:53'!
initializeFor: aValue from: anAccount to: otherAccount

	value := aValue.
	withdrawal := TransferWithdraw on: anAccount forTransfer: self.
	deposit := TransferDeposit on: otherAccount forTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ms 10/19/2022 17:33:27'!
register: aValue from: anAccount to: otherAccount

	| transfer |
	
	transfer := self new initializeFor: aValue from: anAccount to: otherAccount.
	anAccount registerTransfer: transfer.
	otherAccount registerTransfer: transfer.
	
	^ transfer! !
