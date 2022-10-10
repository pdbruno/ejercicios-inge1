!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 15:44:23'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 15:58:48'!
test02PortfolioWithOneAccountHasSameBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 10 on: account.
	
	portfolio add: account.

	self assert: (account balance) equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:01:49'!
test03PortfolioWithTwoAccountsHasSumOfBalances

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 10 on: account1.
	Deposit register: 30 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: (account1 balance + account2 balance) equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:03:04'!
test04PortfolioWithTwoAccountsOneNegativeHasSumOfBalances

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 10 on: account1.
	Withdraw register: 30 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: (account1 balance + account2 balance)  equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:03:51'!
test05PortfolioWithOneAccountHasSameTransactions

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio add: account.

	self assert: (portfolio transactions) includes: deposit.
	self assert: 1 equals: (portfolio transactions) size.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:08:34'!
test06PortfolioWithTwoAccountHasAllTransactions

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 10 on: account1.
	Withdraw register: 30 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: ((portfolio transactions) allSatisfy: 
		[ :aTransaction | (account1 transactions includes: aTransaction) or: (account2 transactions includes: aTransaction) ]).
	self assert: (account1 transactions size + account2 transactions size) equals: portfolio transactions size.

! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:10:55'!
test07PortfolioHasRegisteredTransaction

	| portfolio account transaction |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.

	transaction := Deposit register: 100 on: account.

	portfolio add: account.


	self assert: (portfolio hasRegistered: transaction) 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:12:29'!
test08PortfolioHasNotRegisteredTransaction

	| portfolio account account2 transaction |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	transaction := Deposit register: 100 on: account.
	Deposit register: 100 on: account2.

	portfolio add: account2.


	self deny: (portfolio hasRegistered: transaction) 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:15:08'!
test09PortfolioWithOnePortfolioHasSameBalance

	| portfolio childPortfolio account |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 10 on: account.
	
	childPortfolio add: account.
	portfolio add: childPortfolio.

	self assert: (childPortfolio balance) equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:16:49'!
test10PortfolioWithPortfolioAndAccountHasSameBalance

	| portfolio childPortfolio account account2 |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Deposit register: 50 on: account2.
	
	childPortfolio add: account.
	portfolio add: childPortfolio.
	portfolio add: account2.

	self assert: (childPortfolio balance + account2 balance) equals: (portfolio balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ms 10/10/2022 16:18:47'!
test11PortfolioWithMultiLevelPortfolioHasSameBalance

	| portfolio childPortfolio childChildPortfolio account |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	childChildPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.

	Deposit register: 100 on: account.
	
	childChildPortfolio add: account.
	childPortfolio add: childChildPortfolio.
	portfolio add: childPortfolio.

	self assert: account balance equals: (portfolio balance).
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ms 10/10/2022 15:32:16'!
updateBalance: aBalance 

	self subclassResponsibility ! !

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


!Deposit methodsFor: 'value' stamp: 'ms 10/10/2022 15:32:58'!
updateBalance: aBalance

	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ms 10/10/2022 15:33:13'!
updateBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ms 10/10/2022 15:46:44'!
add: anAsset
	
	assets add: anAsset.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ms 10/10/2022 15:59:34'!
balance
	
	^assets sum: [:anAsset | anAsset balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ms 10/10/2022 16:12:55'!
hasRegistered: aTransaction
	
	^self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ms 10/10/2022 15:46:21'!
initialize
	
	assets := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ms 10/10/2022 15:51:40'!
transactions
	^(assets collect: [:anAsset | anAsset transactions]) flatten
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ms 10/10/2022 15:33:45'!
balance

	^transactions inject: 0 into: [ :balance :aTransaction | aTransaction updateBalance: balance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
