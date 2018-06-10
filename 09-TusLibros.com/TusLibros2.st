!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 18:51:35'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 20:21:23'!
createExpiredCreditCard

	^ CreditCard withNumber: 79927398713 expiration: (GregorianMonthOfYear current next: -2 * month) owner: 'Nombre Apellido'.! !

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 20:20:54'!
createValidCreditCard

	^ CreditCard withNumber: 79927398713 expiration: (GregorianMonthOfYear current next: 2 * month) owner: 'Nombre Apellido'.! !

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 18:51:51'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 18:52:07'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'MI 6/10/2018 18:52:22'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CartTest category: #TusLibros!
TusLibrosTest subclass: #CartTest
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


!classDefinition: #CashierTest category: #TusLibros!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'MI 6/10/2018 18:34:36'!
createCashierWithEmptyList

	^ Cashier withPriceList: Dictionary new.! !

!CashierTest methodsFor: 'support' stamp: 'MI 6/10/2018 19:30:54'!
createCashierWithInvalidItemList
	
	| priceList |
	
	priceList _ Dictionary new.
	priceList at: (self itemSellByTheStore) put: (-10 * peso).
	
	^ Cashier withPriceList: priceList.! !

!CashierTest methodsFor: 'support' stamp: 'MI 6/10/2018 19:31:00'!
createCashierWithValidItemList
	
	| priceList |
	
	priceList _ Dictionary new.
	priceList at: (self itemSellByTheStore) put: (10 * peso).
	
	^ Cashier withPriceList: priceList.! !


!CashierTest methodsFor: 'tests' stamp: 'MI 6/10/2018 19:33:06'!
test01EmptyCartCanNotBeCheckedOut

	| cashier cart card |
	
	card _ self createValidCreditCard.
	cashier _ self createCashierWithEmptyList.
	cart _ self createCart.
	
	self should: [ cashier checkout: cart withCard: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = cashier emptyCartErrorMessage ].! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/10/2018 19:32:28'!
test02CheckoutReturnsTotalAmountToPay

	| cashier cart total card |
	
	card _ self createValidCreditCard.
	cashier _ self createCashierWithValidItemList.
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	total _ cashier checkout: cart withCard: card.
	
	self assert: total = (10 * peso).! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/10/2018 19:32:58'!
test03CanNotCheckoutIfACartItemHasNoPriceListed

	| cashier cart card |
	
	card _ self createValidCreditCard.
	cashier _ self createCashierWithEmptyList.
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	
	self should: [ cashier checkout: cart withCard: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = cashier itemWithoutPriceErrorMessage ].! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/10/2018 19:36:56'!
test04CanNotPayWithAnExpiredCreditCard
	| cashier cart card |
	card _ self createExpiredCreditCard.
	cashier _ self createCashierWithValidItemList.
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	self should: [ cashier checkout: cart withCard: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = cashier expiredCreditCardErrorMessage ].! !

!CashierTest methodsFor: 'tests' stamp: 'MI 6/10/2018 19:33:59'!
test05CanNotDebitANonPositiveAmount

	| cashier cart card |
	
	card _ self createValidCreditCard.
	cashier _ self createCashierWithInvalidItemList.
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	
	self should: [ cashier checkout: cart withCard: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = cashier negativeAmountToDebitErrorMessage ].! !


!classDefinition: #CreditCardTest category: #TusLibros!
TusLibrosTest subclass: #CreditCardTest
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'MI 6/10/2018 20:16:49'!
test01CanNotCreateInvalidNumberCreditCard

	self should: [ CreditCard withNumber: 1 expiration: GregorianMonthOfYear current owner: 'Nombre Apellido' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCreditCardNumberErrorMessage ].! !

!CreditCardTest methodsFor: 'tests' stamp: 'MI 6/10/2018 20:22:21'!
test02NotExpiredCardShowsAsNotExpired

	| card |
	
	card _ self createValidCreditCard.
	
	self deny: card isExpired.! !

!CreditCardTest methodsFor: 'tests' stamp: 'MI 6/10/2018 20:22:40'!
test03ExpiredCardShowsAsExpired

	| card |
	
	card _ self createExpiredCreditCard.
	
	self assert: card isExpired.! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'iterating' stamp: 'MI 6/10/2018 19:24:59'!
itemsDo: aBlock
	
	^ (items copy) do: aBlock
	
	"Agregamos este método para iterar los elementos del carrito sin romper el encapsulamiento."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'pricelist'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error messages' stamp: 'MI 6/7/2018 19:08:19'!
emptyCartErrorMessage
	
	^ 'The cart to checkout is empty'! !

!Cashier methodsFor: 'error messages' stamp: 'MI 6/10/2018 18:15:47'!
expiredCreditCardErrorMessage
	
	^ 'Cannot pay with expired card'! !

!Cashier methodsFor: 'error messages' stamp: 'MI 6/7/2018 19:59:09'!
itemWithoutPriceErrorMessage
	
	^ 'Item without price'! !

!Cashier methodsFor: 'error messages' stamp: 'MI 6/10/2018 18:20:42'!
negativeAmountToDebitErrorMessage
	
	^ 'Cannot debit a negative amount of money'! !


!Cashier methodsFor: 'paying' stamp: 'MI 6/10/2018 19:22:53'!
debit: anAmountOfMoney from: aCard 

	^ self
	
	"En futuras iteraciones este método se comunicará con el Merchant Processor."
	! !


!Cashier methodsFor: 'assertions' stamp: 'MI 6/10/2018 19:09:13'!
assertAmountToPayIsPositive: anAmountToPay

	anAmountToPay <= 0 ifTrue: [ self error: self negativeAmountToDebitErrorMessage ]! !

!Cashier methodsFor: 'assertions' stamp: 'MI 6/10/2018 19:06:47'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self emptyCartErrorMessage ]! !

!Cashier methodsFor: 'assertions' stamp: 'MI 6/10/2018 19:06:52'!
assertCreditCardIsNotExpired: aCreditCard

	aCreditCard isExpired ifTrue: [ self error: self expiredCreditCardErrorMessage ]! !


!Cashier methodsFor: 'initialization' stamp: 'MI 6/7/2018 19:16:24'!
withPriceList: aPriceList

	pricelist _ aPriceList! !


!Cashier methodsFor: 'checkout' stamp: 'MI 6/10/2018 19:09:40'!
checkout: aCart withCard: aCreditCard
	
	| amountToPay |

	self assertCreditCardIsNotExpired: aCreditCard.
	self assertCartIsNotEmpty: aCart.
	
	amountToPay _ 0.
	aCart itemsDo: [ :item | amountToPay _ amountToPay + pricelist at: item ifAbsent: [ self error: self itemWithoutPriceErrorMessage ] ].
	
	self assertAmountToPayIsPositive: amountToPay.
	
	self debit: amountToPay from: aCreditCard.
	
	^ amountToPay! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MI 6/7/2018 19:15:54'!
withPriceList: aPriceList

	^ self new withPriceList: aPriceList 
! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'MI 6/10/2018 17:35:32'!
isExpired
	
	^ expiration < GregorianMonthOfYear current! !


!CreditCard methodsFor: 'initialization' stamp: 'MI 6/10/2018 20:14:56'!
withNumber: aCreditCardNumber expiration: anExpirationDate owner: ownersNameAndSurname
	
	number _ aCreditCardNumber.
	expiration _ anExpirationDate.
	owner _ ownersNameAndSurname.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MI 6/10/2018 20:15:06'!
withNumber: aCreditCardNumber expiration: anExpirationDate owner: ownersNameAndSurname
	
	self assertIsValidCreditCardNumber: aCreditCardNumber.
	
	^ self new withNumber: aCreditCardNumber expiration: anExpirationDate owner: ownersNameAndSurname	! !


!CreditCard class methodsFor: 'assertions' stamp: 'MI 6/10/2018 20:15:21'!
assertIsValidCreditCardNumber: aCreditCardNumber

	"Algoritmo de Luhn"
	
	(((0 to: 10) inject: 0 into: [ :subtotal :index | 
		| digitToSum |
		digitToSum _ (aCreditCardNumber // (10 raisedTo: index) mod: 10) * (index even ifTrue: [ 1 ] ifFalse: [ 2 ]).
		digitToSum > 9 ifTrue: [ digitToSum _ digitToSum - 9 ].
		subtotal + digitToSum ]) mod: 10) = 0 ifFalse: [ self error: self invalidCreditCardNumberErrorMessage]! !


!CreditCard class methodsFor: 'error messages' stamp: 'MI 6/10/2018 20:15:51'!
invalidCreditCardNumberErrorMessage

	^ 'The credit card number provided is not valid'! !
