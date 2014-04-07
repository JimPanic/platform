A = require './array'
T = require './types'

O = {
  # Iterate over all key-value pairs one by one.
  #
  # The callback parameters are analogue to Array.forEach callback parameters:
  #  * value
  #  * key (index)
  #  * object
  #
  # `each` always returns undefined.
  #
  # NOTE: There is no way to stop/break an iteration done with `each`. Use
  #       `Array.some` or `Array.every` if that is needed.
  each: (fn, object) ->
    wrapped = (object) ->
      (element, index, array) ->
        fn.apply(null, [ object[element], element, object ])

    A.each(wrapped(object), Object.keys(object))

    return undefined

  # Compare (simple, one-level) equality of two objects.
  #
  # NOTE: This only compares keys & values on the first level.
  #       - Arrays are compared with `A.equals`,
  #       - Object values are not compared at all, it is just ensured that both
  #         values are objects.
  #
  #       The above seems like a reasonable choice in theory. If practice shows
  #       otherwise, we need to adapt to provide more (or even less)
  #       sophisticated equality checks.
  equals: (a, b) ->
    return false unless T.is_object(a) && T.is_object(b)

    keys_a = Object.keys(a)
    keys_b = Object.keys(b)

    return false if keys_a.length != keys_b.length
    return false unless A.equals(keys_a, keys_b)

    fn = (previous, value, key, obj) ->
      return false unless T.type_of(value) == T.type_of(b[key])

      return previous && A.equals(value, b[key]) if T.is_array(value)
      return previous if T.is_object(value)

      return previous && b[key] == value

    O.reduce(fn, true, a)

  # Test whether all elements pass given function.
  every: (fn, object) ->
    wrapped = (fn, object) ->
      (value, index, array) -> fn(object[value], value, object)

    A.every(wrapped(fn, object), Object.keys(object))

  # Filter the contents of an object by its keys and return a new object with
  # all the keys matching the filter.
  filter: (fn, object) ->
    wrapped = (object) ->
      (new_object, key) ->
        new_object[key] = object[key]
        new_object

    A.reduce(wrapped(object), {}, A.filter(fn, Object.keys(object)))

  # Check whether given object's keys include the passed key.
  has_key: (key, object) ->
    A.has_element(key, Object.keys(object))

  # Check whether given object holds the passed value.
  has_value: (value, object) ->
    wrapped = (value) -> (v) -> v == value

    O.some(wrapped(value), object)

  # Iterate over all key-value pairs one by one, store the result in a new
  # object and return it.
  #
  # The callback parameters are analogue to Array.forEach callback parameters:
  #  * value
  #  * key (index)
  #  * object
  #
  # NOTE: There is no way to stop/break an iteration done with `map`. Use
  #       `Array.some` or `Array.every` if that is needed.
  map: (fn, object) ->
    results = {}

    wrapped = (results, fn) ->
      (element, index, array) ->
        result = fn(element, index, array)

        # TODO: Test and verify this is common practice.
        #       Look at Ruby/Python map code for that.
        if T.is_array(result) && result.length == 2
          results[result[0]] = results[result[1]]
          return

        results[index] = result

    O.each(wrapped(results, fn), object)

    results

  # TODO: DOCS
  reduce: (fn, initial_value, object) ->
    wrapped = (fn, object) ->
      (previous, current, key, array) ->
        # Invoke givne callback and give it:
        #
        #  * previous value
        #  * value for current key
        #  * current key as index
        #  * the original object
        fn(previous, object[current], current, object)

    A.reduce(wrapped(fn, object), initial_value, Object.keys(object))

  # TODO: DOCS
  some: (fn, object) ->
    wrapped = (fn, object) ->
      (value, index, array) -> fn(object[value], value, object)

    A.some(wrapped(fn, object), Object.keys(object))
}

module.exports = O
