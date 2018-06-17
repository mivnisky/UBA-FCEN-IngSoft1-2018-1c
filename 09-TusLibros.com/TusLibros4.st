!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:13:25'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:12:44'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:13:09'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:13:00'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:12:54'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/17/2018 19:13:17'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreTest category: #TusLibros!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjectsFactory clientValidationBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'setup' stamp: 'MI 6/17/2018 16:28:38'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clientValidationBehavior := [ :aClientID :aPassword | ]! !


!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 18:00:00'!
test01

	| store cartID |
	
	store _ Store withCatalog: testObjectsFactory defaultCatalog andClientDatabase: self.
	cartID _ store createCartWithClientId: 9000 
		andPassword: 'password'.
	
	self assert: cartID = 1.! !

!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 18:00:10'!
test02

	| store |
	
	store _ Store withCatalog: testObjectsFactory defaultCatalog andClientDatabase: self.
	clientValidationBehavior _ [ :aClientID :aPassword | self error: Store invalidClientCredentialsErrorMessage ].
	
	self 
		should: [ store createCartWithClientId: 9000 
			andPassword: 'password' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidClientCredentialsErrorMessage.
			self 
				should: [ store listCartWithId: 1 ]
				raise: Error - MessageNotUnderstood
				withExceptionDo: [ :anotherError |
					self assert: anotherError messageText = Store invalidCartIdErrorMessage. ] ]! !

!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 18:00:17'!
test03

	| store cartID cartList |
	
	store _ Store withCatalog: testObjectsFactory defaultCatalog andClientDatabase: self.
	cartID _ store createCartWithClientId: 9000 
		andPassword: 'password'.
	store add: 8 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	cartList _ store listCartWithId: cartID.
	
	self assert: cartList size = 1.
	self assert: (cartList at: testObjectsFactory itemSellByTheStore) = 8.! !

!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 18:00:23'!
test04

	| store cartID transactionID |
	
	store _ Store withCatalog: testObjectsFactory defaultCatalog andClientDatabase: self.
	cartID _ store createCartWithClientId: 9000 
		andPassword: 'password'.
	store add: 8 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	transactionID _ store checkOutCart: cartID
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today.
			
	self assert: transactionID = 1.! !

!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 20:01:13'!
test05

	| store cartID purchasesList |
	
	store _ Store withCatalog: testObjectsFactory defaultCatalog andClientDatabase: self.
	
	cartID _ store createCartWithClientId: 9000 
		andPassword: 'password'.
		
	store add: 8 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	store checkOutCart: cartID
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today.
		
	purchasesList _ store listPurchasesFromClient: 9000 withPassword: 'password'.
	
	self assert: purchasesList size = 1.! !

!StoreTest methodsFor: 'tests' stamp: 'MI 6/17/2018 20:02:17'!
test06

	"Misterioso test de 30min"! !


!StoreTest methodsFor: 'merchant processor protocol' stamp: 'MI 6/17/2018 17:43:05'!
debit: anAmount from: aCreditCard 

	"Always successful"! !


!StoreTest methodsFor: 'client database protocol' stamp: 'MI 6/17/2018 16:22:42'!
validateClientId: aClientID withPassword: aPassword

	^ clientValidationBehavior value: aClientID value: aPassword! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'iterating' stamp: 'MI 6/17/2018 17:28:01'!
itemsDo: aBlock

	^ items copy do: aBlock! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total detail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'MI 6/17/2018 19:37:31'!
calculateDetail
	
	cart itemsDo: [ :item | detail at: item put: (detail at: item ifAbsent: 0) + 1 ]
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MI 6/17/2018 19:36:05'!
createSale

	^ Sale of: total withDetail: detail.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'MI 6/17/2018 19:38:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self calculateDetail.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'MI 6/17/2018 19:37:51'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	detail := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'MI 6/17/2018 19:12:31'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^ self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total detail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MI 6/17/2018 19:34:54'!
of: aTotal withDetail: aDetail

	total := aTotal.
	detail := aDetail ! !


!Sale methodsFor: 'detail' stamp: 'MI 6/17/2018 19:34:02'!
detail 

	^ detail! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MI 6/17/2018 19:34:26'!
of: aTotal withDetail: aDetail

	"should assert total is not negative or 0!!"
	^self new of: aTotal withDetail: aDetail ! !


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'carts catalog clientDatabase salesBook clientForCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'private' stamp: 'MI 6/17/2018 16:52:34'!
getCart: aCartID

	^ carts at: aCartID ifAbsent: [ self error: self class invalidCartIdErrorMessage ]! !

!Store methodsFor: 'private' stamp: 'MI 6/17/2018 18:40:37'!
getClientForCart: aCartID

	^  clientForCart at: aCartID! !

!Store methodsFor: 'private' stamp: 'MI 6/17/2018 19:42:54'!
updateClient: clientID withSaleInformation: aSale

	| clientTotalSale |
	
	clientTotalSale _ salesBook at: clientID ifAbsent: [  ]! !


!Store methodsFor: 'initialization' stamp: 'MI 6/17/2018 18:42:02'!
withCatalog: aCatalog andClientDatabase: aClientDatabase

	carts _ OrderedCollection new.
	catalog _ aCatalog.
	clientDatabase _ aClientDatabase.
	salesBook _ Dictionary new.
	clientForCart _ Dictionary new.! !


!Store methodsFor: 'store protocol' stamp: 'MI 6/17/2018 17:06:58'!
add: aQuantity of: aProduct toCart: aCartID

	| cart |
	
	cart _ self getCart: aCartID.
	cart add: aQuantity of: aProduct.
	! !

!Store methodsFor: 'store protocol' stamp: 'MI 6/17/2018 19:42:01'!
checkOutCart: aCartID charging: aCreditCard through: aMerchantProcessor on: aDate

	| cart cashier cashierSalesBook clientID |
	
	cart _ self getCart: aCartID.
	cashierSalesBook _ OrderedCollection new.
	
	cashier _ Cashier toCheckout: cart
		charging: aCreditCard 
		throught: aMerchantProcessor
		on: aDate
		registeringOn: cashierSalesBook.
		
	cashier checkOut.
		
	clientID _ clientForCart at: aCartID.
	^ self updateClient: clientID withSaleInformation: (cashierSalesBook at: 1)
	
	
	
	! !

!Store methodsFor: 'store protocol' stamp: 'MI 6/17/2018 18:40:19'!
createCartWithClientId: aClientID andPassword: aPassword

	| newCart newCartID |

	clientDatabase validateClientId: aClientID withPassword: aPassword.
	newCart _ Cart 	acceptingItemsOf: catalog.
	carts add: newCart.
	newCartID _ carts size.
	clientForCart at: newCartID put: aClientID.
	^ newCartID 
	! !

!Store methodsFor: 'store protocol' stamp: 'MI 6/17/2018 17:28:48'!
listCartWithId: aCartID

	| cart cartList |

	 cart _ self getCart: aCartID.
	cartList _ Dictionary new.
	
	cart itemsDo: [ :item | cartList at: item put: (cartList at: item ifAbsent: 0) + 1 ].
	
	^ cartList
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'error messages' stamp: 'MI 6/17/2018 16:50:25'!
invalidCartIdErrorMessage
	
	^ 'Invalid cart ID'! !

!Store class methodsFor: 'error messages' stamp: 'MI 6/17/2018 16:41:08'!
invalidClientCredentialsErrorMessage

	^ 'Invalid client credentials'! !


!Store class methodsFor: 'instance creation' stamp: 'MI 6/17/2018 17:57:03'!
withCatalog: aCatalog andClientDatabase: aClientDataBase

	^ self new withCatalog: aCatalog andClientDatabase: aClientDataBase ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'MI 6/17/2018 18:24:01'!
clientID

	^ 9000! !
