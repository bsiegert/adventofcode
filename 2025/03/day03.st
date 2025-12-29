Object subclass: Day03 [
	| sum |

	init [ sum := 0 ]
	sum  [ ^sum ]

	isInvalid: id [
		| ids halfLen |

		ids := id asString.
		"has to be an even length."
		(ids size \\ 2 = 1) ifTrue: [ ^false ].
		
		halfLen := ids size // 2.
		"first half = second half"
		^((ids first: halfLen) = (ids allButFirst: halfLen))
	]

	findHighestDigit: str [
		| digits n |
		
		digits := #( $9 $8 $7 $6 $5 $4 $3 $2 $1 $0 ).
		digits do: [ :i |
			n := str indexOf: i startingAt: 1.
			(n = 0) ifFalse: [ ^n ]
		].
		self error: 'unreachable'
	]

	run: line [
		| joltage n remainder |


		"Search for the highest number in the first n-1 chars,
		 so that we have space for a 1-digit."
		n := self findHighestDigit: (line allButLast).
		joltage := 10 * ((line at: n) asString asNumber).

		"Now look in the remainder of the string for 1-digits."
		remainder := line allButFirst: n.
		n := self findHighestDigit: remainder.
		joltage := joltage + ((remainder at: n) asString asNumber).
		
		Transcript show: (joltage asString); cr.
		sum := sum + joltage.
	]
]

d := Day03 new init.

filename := Smalltalk arguments at: 1 ifAbsent: [
	self error: 'input file is required'.
].
input_file := FileDescriptor open: filename.

[ input_file atEnd ] whileFalse: [
	| line |
	line := input_file nextLine asString.
	d run: line.
].

Transcript cr; show: (d sum asString); show: ' total'; cr.

input_file close.
