"gst -f day01.st input" 

Object subclass: Day01 [
	| value numZeros |

	init [
		value := 50.
		numZeros := 0.
	]

	main [
		| filename input_file |

		filename := Smalltalk arguments at: 1 ifAbsent: [
			self error: 'input file is required'.
		].
		Transcript show: filename; cr.

		input_file := FileDescriptor open: filename.

		[ input_file atEnd ] whileFalse: [
			| num |
			num := self parseLine: ((input_file nextLine) asString).
			num printOn: Transcript.
			Transcript show: '  |  '.
			value printOn: Transcript.
			(value = 0) ifTrue: [
				Transcript show: '  |  ZERO'.
			].
			Transcript cr.
		].

		Transcript cr; show: (numZeros asString); show: ' zeroes'; cr.

		input_file close.
	]

	parseLine: aLine [
		| letter num |
		letter := aLine at: 1.
		num := (aLine allButFirst: 1) asNumber.
		(letter = $L) ifTrue: [
			num := -1 * num.
		].
		value := (value + num) \\ 100.
		(value = 0) ifTrue: [
			numZeros := numZeros + 1
		].
		^num.
	]
]

((Day01 new) init) main.
