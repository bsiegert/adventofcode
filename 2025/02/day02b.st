String extend [
	* times [
		^ String streamContents: [ :s |
			times timesRepeat: [ s nextPutAll: self ].
		 ].
	]
]

Object subclass: Day02 [
	| sumInvalid |

	init [
		sumInvalid := 0.
	]

	sumInvalid [ ^sumInvalid ]

	isInvalid: id [
		| ids n |

		ids := id asString.
		n := ids size.
		1 to: (n // 2) do: [ :substrLen |
			(n \\ substrLen = 0) ifTrue: [
				(ids = ((ids first: substrLen) * (n // substrLen))) ifTrue: [
					^ true.
				].
			].
		].
		^ false.
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
