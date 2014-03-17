A = require './array'

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

  # TODO: DOCS
  every: (fn, object) ->
    wrapped = (fn, object) ->
      (value, index, array) -> fn(object[value], value, object)

    A.every(wrapped(fn, object), Object.keys(object))

  # Filter the contents of an object by its keys and return a new object with
  # all the keys matching the filter.
  #
  # This is /probably/ only useful for primitive objects only holding data.
  filter: (fn, object) ->
    wrapped = (object) ->
      (new_object, key) ->
        new_object[key] = object[key]
        new_object

    A.reduce(wrapped(object), {}, A.filter(fn, Object.keys(object)))

  # TODO: DOCS
  has_value: (value, object) ->
    wrapped = (value) -> (v) -> v == value

    O.some(wrapped(value), object)

  # TODO: DOCS
  has_key: (key, object) ->
    A.has_element(key, Object.keys(object))

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

    wrapped = (fn) ->
      (element, index, array) -> results[index] = fn(element, index, array)

    O.each(wrapped(fn), object)

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
