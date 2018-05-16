!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/14/2018 18:15:27'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^ (AccountSummary of: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/14/2018 18:33:58'!
accountTransferNetOf: aReceptiveAccount 
	
	^ (TransferNet of: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/14/2018 18:43:31'!
investmentEarningsOf: aReceptiveAccount 
	
	^ (InvestmentEarnings of: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/14/2018 18:41:21'!
investmentNetOf: aReceptiveAccount 
	
	^ (InvestmentNet of: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/15/2018 20:14:46'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^ (PortfolioTreePrinter of: aPortfolio namingAccountWith: aDictionary) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'MI 5/15/2018 20:15:26'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary

	^ (ReversePortfolioTreePrinter of: aPortfolio namingAccountWith: aDictionary) value! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MI 5/14/2018 18:58:24'!
modifyBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'MI 5/14/2018 18:56:33'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'query' stamp: 'MI 5/14/2018 18:56:39'!
answerQuery: aQuery

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'value' stamp: 'MI 5/10/2018 21:31:32'!
modifyBalance: aBalance

	^ aBalance - value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'MI 5/14/2018 18:18:58'!
numberOfDays

	^ numberOfDays! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'MI 5/14/2018 18:17:57'!
tna

	^ tna! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'MI 5/10/2018 21:25:30'!
value

	^ value! !


!CertificateOfDeposit methodsFor: 'query' stamp: 'MI 5/14/2018 18:31:38'!
answerQuery: aQuery

	^ aQuery certificateOfDepositQueryValue: self.! !


!CertificateOfDeposit methodsFor: 'initialization' stamp: 'MI 5/10/2018 21:16:05'!
initializeFor: aValue during: aNumberOfDays at: anInterestRate on: aReceptiveAccount

	value := aValue.
	tna := anInterestRate.
	numberOfDays := aNumberOfDays.
	account := aReceptiveAccount! !


!CertificateOfDeposit methodsFor: 'earnings' stamp: 'MI 5/14/2018 15:35:18'!
investmentEarning

	^ value * tna * numberOfDays / 360! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'MI 5/10/2018 21:30:54'!
register: aValue during: aNumberOfDays at: anInterestRate on: aReceptiveAccount

	| certificateOfDeposit |
	
	certificateOfDeposit := self new initializeFor: aValue during: aNumberOfDays at: anInterestRate on: aReceptiveAccount.
	aReceptiveAccount register: certificateOfDeposit.
	
	^ certificateOfDeposit! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MI 5/10/2018 19:36:45'!
modifyBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'query' stamp: 'MI 5/14/2018 18:30:45'!
answerQuery: aQuery

	^ aQuery depositQueryValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'value' stamp: 'MI 5/14/2018 18:51:54'!
transfer

	^ transfer! !


!TransferLeg methodsFor: 'initialization' stamp: 'MI 5/14/2018 18:59:39'!
initializeFor: aTransfer

	transfer := aTransfer! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'MI 5/10/2018 19:59:41'!
modifyBalance: aBalance

	^ aBalance + transfer value! !


!TransferDeposit methodsFor: 'query' stamp: 'MI 5/14/2018 18:30:10'!
answerQuery: aQuery

	^ aQuery transferDepositQueryValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'MI 5/10/2018 20:01:04'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'MI 5/10/2018 19:56:48'!
modifyBalance: aBalance

	^ aBalance - transfer value! !


!TransferWithdraw methodsFor: 'consultas' stamp: 'MI 5/14/2018 18:29:35'!
answerQuery: aQuery

	^ aQuery transferWithdrawQueryValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'MI 5/10/2018 20:00:42'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MI 5/10/2018 19:36:04'!
modifyBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'MI 5/10/2018 18:51:49'!
value

	^ value! !


!Withdraw methodsFor: 'query' stamp: 'MI 5/14/2018 18:28:57'!
answerQuery: aQuery

	^ aQuery withdrawQueryValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Query category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Query
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Query methodsFor: 'query' stamp: 'MI 5/15/2018 22:35:51'!
value
	
	self subclassResponsibility ! !


!classDefinition: #AccountQuery category: #'PortfolioTreePrinter-Ejercicio'!
Query subclass: #AccountQuery
	instanceVariableNames: 'accountNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountQuery methodsFor: 'initialization' stamp: 'MI 5/15/2018 22:36:24'!
initializeOf: anAccount namingAccountWith: anAccountNameDictionary

	self subclassResponsibility ! !


!AccountQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:37:22'!
portfolioValue: aPortfolio

	self subclassResponsibility ! !

!AccountQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:37:10'!
receptiveAccountValue: aReceptiveAccount

	self subclassResponsibility ! !


!classDefinition: #PortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
AccountQuery subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'MI 5/14/2018 19:11:00'!
initializeOf: anAccount namingAccountWith: anAccountNameDictionary

	account := anAccount.
	accountNames := anAccountNameDictionary.! !


!PortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 22:04:30'!
portfolioValue: aPortfolio

	| result |
	
	result := OrderedCollection with: (accountNames at: aPortfolio).
		
	aPortfolio accountsDo: [ :account | result addAllLast: ((account answerQuery: self) collect: [ :line | ' ', line ] ) ]. 
	
	^ result! !

!PortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 19:21:16'!
receptiveAccountValue: aReceptiveAccount

	^ OrderedCollection with: (accountNames at: aReceptiveAccount)! !

!PortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 19:29:31'!
value

	^ account answerQuery: self
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'MI 5/15/2018 19:53:03'!
of: anAccount namingAccountWith: anAccountNameDictionary

	^ self new initializeOf: anAccount namingAccountWith: anAccountNameDictionary! !


!classDefinition: #ReversePortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
AccountQuery subclass: #ReversePortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReversePortfolioTreePrinter methodsFor: 'initialization' stamp: 'MI 5/15/2018 20:14:02'!
initializeOf: anAccount namingAccountWith: anAccountNameDictionary

	account := anAccount.
	accountNames := anAccountNameDictionary.! !


!ReversePortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 22:05:35'!
portfolioValue: aPortfolio

	| result |
	
	result := OrderedCollection new.
		
	aPortfolio accountsDo: [ :account | result addAllFirst: ((account answerQuery: self) collect: [ :line | ' ', line ] ) ].
		
	result addLast: (accountNames at: aPortfolio).
	
	^ result! !

!ReversePortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 20:14:02'!
receptiveAccountValue: aReceptiveAccount

	^ OrderedCollection with: (accountNames at: aReceptiveAccount)! !

!ReversePortfolioTreePrinter methodsFor: 'query' stamp: 'MI 5/15/2018 20:14:02'!
value

	^ account answerQuery: self
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReversePortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
ReversePortfolioTreePrinter class
	instanceVariableNames: ''!

!ReversePortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'MI 5/15/2018 20:14:02'!
of: anAccount namingAccountWith: anAccountNameDictionary

	^ self new initializeOf: anAccount namingAccountWith: anAccountNameDictionary! !


!classDefinition: #TransactionQuery category: #'PortfolioTreePrinter-Ejercicio'!
Query subclass: #TransactionQuery
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransactionQuery methodsFor: 'initialization' stamp: 'MI 5/15/2018 22:38:03'!
initializeOf: anAccount

	self subclassResponsibility ! !


!TransactionQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:39:15'!
certificateOfDepositQueryValue: aCertificateOfDeposit

	self subclassResponsibility ! !

!TransactionQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:39:25'!
depositQueryValue: aDeposit

	self subclassResponsibility ! !

!TransactionQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:39:33'!
transferDepositQueryValue: aTransferDeposit

	self subclassResponsibility ! !

!TransactionQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:39:42'!
transferWithdrawQueryValue: aTransferWithdraw

	self subclassResponsibility ! !

!TransactionQuery methodsFor: 'query' stamp: 'MI 5/15/2018 22:39:49'!
withdrawQueryValue: aWithdraw

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
TransactionQuery subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'MI 5/14/2018 18:01:33'!
initializeOf: anAccount

	account := anAccount ! !


!AccountSummary methodsFor: 'query' stamp: 'MI 5/14/2018 19:13:06'!
certificateOfDepositQueryValue: aCertificateOfDeposit

	^ 'Plazo fijo por ' , aCertificateOfDeposit value printString , ' durante ' , aCertificateOfDeposit numberOfDays printString , ' dias a una tna de ' , (100 * aCertificateOfDeposit tna) printString , '%'.! !

!AccountSummary methodsFor: 'query' stamp: 'MI 5/14/2018 19:13:26'!
depositQueryValue: aDeposit

	^ 'Deposito por ' , aDeposit value printString.! !

!AccountSummary methodsFor: 'query' stamp: 'MI 5/14/2018 19:13:23'!
transferDepositQueryValue: aTransferDeposit

	^ 'Transferencia por ' , aTransferDeposit transfer value printString.! !

!AccountSummary methodsFor: 'query' stamp: 'MI 5/14/2018 19:13:18'!
transferWithdrawQueryValue: aTransferWithdraw

	^ 'Transferencia por -' , aTransferWithdraw transfer value printString.! !

!AccountSummary methodsFor: 'query' stamp: 'MI 5/15/2018 22:20:44'!
value

	| summary |
	
	summary := OrderedCollection new.
		
	account transactionsDo: [ :transaction | summary add: (transaction answerQuery: self) ].
	
	^ summary! !

!AccountSummary methodsFor: 'query' stamp: 'MI 5/14/2018 19:13:14'!
withdrawQueryValue: aWithdraw

	^ 'Extraccion por ' , aWithdraw value printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'MI 5/14/2018 18:19:38'!
of: anAccount

	^ self new initializeOf: (anAccount copy)! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
TransactionQuery subclass: #InvestmentEarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'initialization' stamp: 'MI 5/14/2018 18:42:24'!
initializeOf: anAccount

	account := anAccount ! !


!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/14/2018 18:43:10'!
certificateOfDepositQueryValue: aCertificateOfDeposit

	^ aCertificateOfDeposit investmentEarning! !

!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/14/2018 18:42:24'!
depositQueryValue: aDeposit

	^ 0! !

!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/14/2018 18:42:24'!
transferDepositQueryValue: aTransferDeposit

	^ 0! !

!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/14/2018 18:42:24'!
transferWithdrawQueryValue: aTransferWithdraw

	^ 0! !

!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/15/2018 22:27:57'!
value

	| investmentEarnings |
	
	investmentEarnings := 0.
	
	account transactionsDo: [ :transaction | investmentEarnings := investmentEarnings + (transaction answerQuery: self) ].

	^ investmentEarnings! !

!InvestmentEarnings methodsFor: 'query' stamp: 'MI 5/14/2018 18:42:24'!
withdrawQueryValue: aWithdraw

	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarnings class
	instanceVariableNames: ''!

!InvestmentEarnings class methodsFor: 'instance creation' stamp: 'MI 5/14/2018 18:42:24'!
of: anAccount

	^ self new initializeOf: (anAccount copy)! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
TransactionQuery subclass: #InvestmentNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'initialization' stamp: 'MI 5/14/2018 18:39:34'!
initializeOf: anAccount

	account := anAccount ! !


!InvestmentNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:40:28'!
certificateOfDepositQueryValue: aCertificateOfDeposit

	^ aCertificateOfDeposit value! !

!InvestmentNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:39:34'!
depositQueryValue: aDeposit

	^ 0! !

!InvestmentNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:40:48'!
transferDepositQueryValue: aTransferDeposit

	^ 0! !

!InvestmentNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:40:54'!
transferWithdrawQueryValue: aTransferWithdraw

	^ 0! !

!InvestmentNet methodsFor: 'query' stamp: 'MI 5/15/2018 22:27:17'!
value

	| investmentNet |
	
	investmentNet := 0.
	
	account transactionsDo: [ :transaction | investmentNet := investmentNet + (transaction answerQuery: self) ].

	^ investmentNet ! !

!InvestmentNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:39:34'!
withdrawQueryValue: aWithdraw

	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'instance creation' stamp: 'MI 5/14/2018 18:39:34'!
of: anAccount

	^ self new initializeOf: (anAccount copy)! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
TransactionQuery subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'initialization' stamp: 'MI 5/14/2018 18:21:11'!
initializeOf: anAccount

	account := anAccount ! !


!TransferNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:35:06'!
certificateOfDepositQueryValue: aCertificateOfDeposit

	^ 0! !

!TransferNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:35:20'!
depositQueryValue: aDeposit

	^ 0! !

!TransferNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:35:47'!
transferDepositQueryValue: aTransferDeposit

	^ aTransferDeposit transfer value! !

!TransferNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:36:33'!
transferWithdrawQueryValue: aTransferWithdraw

	^ aTransferWithdraw transfer value negated! !

!TransferNet methodsFor: 'query' stamp: 'MI 5/15/2018 22:27:35'!
value

	| transferNet |
	
	transferNet := 0.
	
	account transactionsDo: [ :transaction | transferNet := transferNet + (transaction answerQuery: self) ].
	
	^ transferNet! !

!TransferNet methodsFor: 'query' stamp: 'MI 5/14/2018 18:36:53'!
withdrawQueryValue: aWithdraw

	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'MI 5/14/2018 18:21:11'!
of: anAccount

	^ self new initializeOf: (anAccount copy)! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'query' stamp: 'MI 5/15/2018 19:22:33'!
answerQuery: aQuery

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'printing' stamp: 'MI 5/14/2018 17:01:13'!
treePrintWithNames: anAccountNameDictionary

	| treePrint |
	
	treePrint := OrderedCollection with: (anAccountNameDictionary at: self).
	
	treePrint addAllLast: (accounts collect: [ :account | 
		(account treePrintWithNames: anAccountNameDictionary) collect: [ :line | ' ', line ] ]).
	
	^ treePrint ! !


!Portfolio methodsFor: 'query' stamp: 'MI 5/15/2018 19:42:58'!
answerQuery: aQuery

	^ aQuery portfolioValue: self! !


!Portfolio methodsFor: 'enumerating' stamp: 'MI 5/15/2018 21:57:32'!
accountsDo: aBlock

	^ accounts do: aBlock ! !

!Portfolio methodsFor: 'enumerating' stamp: 'MI 5/15/2018 22:12:27'!
transactionsDo: aBlock

	^ accounts do: [ :account | account transactionsDo: aBlock ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MI 5/10/2018 21:28:49'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	certificatesOfDeposit := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MI 5/10/2018 20:48:22'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction modifyBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'query' stamp: 'MI 5/15/2018 19:23:11'!
answerQuery: aQuery

	^ aQuery receptiveAccountValue: self! !


!ReceptiveAccount methodsFor: 'printing' stamp: 'MI 5/14/2018 16:49:52'!
treePrintWithNames: anAccountNameDictionary

	^ OrderedCollection with: (anAccountNameDictionary at: self)! !


!ReceptiveAccount methodsFor: 'enumerating' stamp: 'MI 5/15/2018 22:13:16'!
transactionsDo: aBlock

	^ transactions do: aBlock! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'MI 5/10/2018 19:09:36'!
initializeFor: aValue from: fromAccount to: toAccount

	value := aValue.
	from := fromAccount.
	to := toAccount! !


!Transfer methodsFor: 'value' stamp: 'MI 5/10/2018 19:13:52'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'MI 5/10/2018 19:08:37'!
for: aValue from: fromAccount to: toAccount

	^ self new initializeFor: aValue from: fromAccount to: toAccount! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'MI 5/10/2018 20:48:40'!
register: aValue from: fromAccount to: toAccount
	| transfer incoming outgoing |
	transfer _ self
		for: aValue
		from: fromAccount
		to: toAccount.
	incoming _ TransferDeposit for: transfer.
	outgoing _ TransferWithdraw for: transfer.
	fromAccount register: outgoing.
	toAccount register: incoming.
	^ transfer.! !
