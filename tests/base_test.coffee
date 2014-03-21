O                = require '../src/object'
{assert, expect} = require '../tests/base'

a = {a:1, b:2}
b = {c:1, d:2}

map_fn = (value, key) -> "#{key} = #{value}"

[
  [ O.equals,    [a, a],   true  ],
  [ O.equals,    [a, b],   false ],
  [ O.has_value, [1, a],   true  ],
  [ O.has_value, [3, a],   false ],
  [ O.has_key,   ['a', a], true  ],
  [ O.has_key,   ['c', a], false ],
  [ O.map
