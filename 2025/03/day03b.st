Object subclass: Day03 [
	| sum |

	init [ sum := 0 ]
	sum  [ ^sum ]

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
		| joltage n remainder digits |

		digits := line.
		joltage := 0.
		11 to: 0 by: -1 do: [ :i |
			n := self findHighestDigit: (digits allButLast: i).
			joltage := joltage + ((10 raisedToInteger: i) * ((digits at: n) asString asNumber)).
			digits := digits allButFirst: n.
		].
		
		Transcript show: '       '; show: (joltage asString); cr.
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
