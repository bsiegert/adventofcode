TestCase subclass: Day02Test [
	| d |

	setUp [
		d := Day02 new init.
	]

	testOddLength [
		#( 1 123 121 12321 ) do: [ :n |
			self deny: (d isInvalid: n).
		].
	]

	testExpectedInvalid [
		#( 55 6464 123123 ) do: [ :n |
			self assert: (d isInvalid: n).
		].
	]

	testExpectedValid [
		#( 32 1024 1234123 ) do: [ :n |
			self deny: (d isInvalid: n).
		].
	]
]
