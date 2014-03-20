type_of = (x) -> x.constructor.name

is_a_uncurried = (t, x) ->
  unless type_of(t) is "String"
    console.log 'WARNING: Given type must be a string as in: is_a("Object", obj)'
    console.log 'Given: ', type_of(t)

    return false

  return false unless x?

  type_of(x) is t

is_a = (type, x) ->
  if 1 is arguments.length
    return (x) -> is_a_uncurried type, x

  if 0 == arguments.length
    console.log "WARNING: No arguments given. Expecting String, expression"
    return false

  is_a_uncurried.call x, type, x

module.exports =
  is_a: is_a

  # Utility functions is_* for builtin instantiable types.
  is_object   : is_a "Object"
  is_array    : is_a "Array"
  is_function : is_a "Function"
  is_string   : is_a "String"
  is_regexp   : is_a "RegExp"
  is_bool     : is_a "Boolean"
  is_error    : is_a "Error"
  is_number   : is_a "Number"
  is_date     : is_a "Date"

  is_null      : (x) -> x is null
  is_undefined : (x) -> x is undefined
  is_nan       : (x) -> x is NaN

  type_of      : type_of
