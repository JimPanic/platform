A        = require '../src/array'
O        = require '../src/object'
{assert,
 expect,
 run}    = require '../tests/base'

# Some test data
a = {a:1, b:2}
b = {c:1, d:2}

map_fn = (value, key) -> "#{key} = #{value}"


# The list of tests (arguments to expect)
tests = [
  [ O.equals,    [a, a],   true,  'O.equals(a, a)\t\t== true\t\t'     ],
  [ O.equals,    [a, b],   false, 'O.equals(a, b)\t\t== false\t'    ],
  [ O.has_value, [1, a],   true,  'O.has_value(1, a)\t== true\t\t'  ],
  [ O.has_value, [3, a],   false, 'O.has_value(3, a)\t== false\t' ],
  [ O.has_key,   ['a', a], true,  "O.has_key('a', a)\t== true\t\t"  ],
  [ O.has_key,   ['c', a], false, "O.has_key('c', a)\t== false\t" ]
]

console.log "Testdata:\na = {a:1, b:2}, b = {c:1, d:2}\n\n"

print =  ({expression, description, result}) ->
  console.log "#{description}: " + (if result then 'success' else 'failed')

A.each print, run(tests)
