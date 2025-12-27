Object subclass: Day02 [
	| sumInvalid |

	init [
		sumInvalid := 0.
	]

	sumInvalid [ ^sumInvalid ]

	isInvalid: id [
		| ids halfLen |

		ids := id asString.
		"has to be an even length."
		(ids size \\ 2 = 1) ifTrue: [ ^false ].
		
		halfLen := ids size // 2.
		"first half = second half"
		^((ids first: halfLen) = (ids allButFirst: halfLen))
	]

	parseLine: line [
		| parts |

		parts := line subStrings: ','.
		^(parts collect: [ :part | self parseInterval: part ])
	]

	parseInterval: str [
		| nums |

		nums := str subStrings: '-'.
		(nums size = 2) ifFalse: [
			self error: 'wrong interval'
		].
		^(((nums at: 1) asNumber) to: ((nums at: 2) asNumber)).
	]

	run: intervals [
		intervals do: [ :interval |
			interval do: [ :i |
				(self isInvalid: i) ifTrue: [
					i printOn: Transcript.
					Transcript show: ' invalid'; cr.
					sumInvalid := sumInvalid + i.
				].
			].
		].
	]
]

d := Day02 new init.

filename := Smalltalk arguments at: 1 ifAbsent: [
	self error: 'input file is required'.
].
input_file := FileDescriptor open: filename.

[ input_file atEnd ] whileFalse: [
	| line |
	line := d parseLine: ((input_file nextLine) asString).
	d run: line.
].

Transcript cr; show: (d sumInvalid asString); show: ' total'; cr.

input_file close.
