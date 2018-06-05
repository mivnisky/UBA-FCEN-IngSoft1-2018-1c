!classDefinition: #Cart category: #Library!
Object subclass: #Cart
	instanceVariableNames: 'books timestamp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!Cart methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:18:58'!
books
	
	^books! !

!Cart methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:14:35'!
initialize
	
	timestamp := Time now.
	books := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:27:14'!
serialize
	
	^self! !

!Cart methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:19:07'!
timestamp
	
	^timestamp! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #Library!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:53:51'!
deserializeCart: aSerializedCart
	
	^aSerializedCart copy.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:28:41'!
newEmprtyCart
	
	^self new initialize.! !


!classDefinition: #CartsApi category: #Library!
Object subclass: #CartsApi
	instanceVariableNames: 'DBPlugin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!CartsApi methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 20:05:31'!
addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity

    | cart oldQuantity |
	
    cart := self fetchCart: aCartId.
    oldQuantity := cart books at: aBookIsbn ifAbsent: 0.
    cart books at: aBookIsbn put: oldQuantity + aQuantity.
    DBPlugin put: cart serialize atKey: aCartId.
    ^0@'OK'.! !

!CartsApi methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:46:32'!
createCartWithClientId: aClientId andPassword: aPassword
	
    ^DBPlugin createRecordWith: Cart newEmprtyCart serialize.! !

!CartsApi methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 20:02:59'!
fetchCart: aCartId
	
    ^Cart deserializeCart: (DBPlugin getValueOfKey: aCartId).! !

!CartsApi methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 20:06:06'!
listCart: aCartId

    | cart |
	
    cart := self fetchCart: aCartId.
    ^0@(cart books printString).! !

!CartsApi methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:41:40'!
withDb: aDb
	
	
    DBPlugin := aDb createPluginOf: 'carts'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartsApi class' category: #Library!
CartsApi class
	instanceVariableNames: ''!

!CartsApi class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:40:14'!
attachedToDb: aDb
	
	^self new withDb: aDb.! !


!classDefinition: #Database category: #Library!
Object subclass: #Database
	instanceVariableNames: 'DB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!Database methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:03:03'!
createPluginOf: aCluster
	
	^DatabasePlugin initializeWithCluster: (DB at: aCluster ifAbsentPut: (OrderedCollection new)).! !

!Database methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:42:43'!
initialize
	
	DB := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Database class' category: #Library!
Database class
	instanceVariableNames: ''!

!Database class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:42:20'!
initialize
	
	^self new initialize.! !


!classDefinition: #DatabasePlugin category: #Library!
Object subclass: #DatabasePlugin
	instanceVariableNames: 'map cluster'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!DatabasePlugin methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:34:03'!
createRecordWith: data

	cluster add: (data storeString).
	^cluster size.! !

!DatabasePlugin methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:55:44'!
getValueOfKey: aKey

	^cluster at: aKey.! !

!DatabasePlugin methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:50:00'!
initializeWithCluster: aDBCluster

	cluster := aDBCluster.! !

!DatabasePlugin methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:57:25'!
put: data atKey: aKey

	^cluster at: aKey put: data.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DatabasePlugin class' category: #Library!
DatabasePlugin class
	instanceVariableNames: ''!

!DatabasePlugin class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:49:48'!
initializeWithCluster: aDBCluster
	
	^self new initializeWithCluster: aDBCluster.! !


!classDefinition: #Library category: #Library!
Object subclass: #Library
	instanceVariableNames: 'carts db'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!Library methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:18:03'!
addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity
	
	^carts addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity.! !

!Library methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:14:41'!
createCartWithClientId: aClientId andPassword: aPassword
	
	^carts createCartWithClientId: aClientId andPassword: aPassword.! !

!Library methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 19:12:58'!
initialize
	db _ Database initialize.
	carts _ CartsApi attachedToDb: db.! !

!Library methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:19:26'!
listCart: aCartId
	
	^carts listCart: aCartId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Library class' category: #Library!
Library class
	instanceVariableNames: ''!

!Library class methodsFor: 'as yet unclassified' stamp: 'NDC 6/5/2018 18:28:07'!
initialize
	
     ^self new initialize.! !

Database initialize!
Library initialize!