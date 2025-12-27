TestCase subclass: Day02Test [
	| d |

	setUp [
		d := Day02 new init.
	]

	testExpectedInvalid [
		#( 99 111 824824824 ) do: [ :n |
			self assert: (d isInvalid: n).
		].
	]

	testExpectedValid [
		#( 32 1024 1234123 ) do: [ :n |
			self deny: (d isInvalid: n).
		].
	]
]
