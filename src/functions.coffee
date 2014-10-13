A = require './array'

# TODO: Evaluate how the functions in this module affect the context (this) of
#       passed functions.

F = {
  # Identity function
  #
  # Example:
  #   F.id(10)
  #   #=> 10
  id: (arg) -> arg

  # Apply an array as arguments to a function
  #
  # NOTE: Composable wrapper for Function.apply
  args_from_array: (fn) -> (args) -> fn.apply @, args

  # Compose a list of functions to a new function.
  #
  # Example:
  #   number = compose Math.round, parseFloat
  #   number '72.5'
  #   # => Math.round(parseFloat('72.5'))
  compose: (fns...) ->
    (args...) ->
      args = [fn.apply @, args] for fn in fns
      args[0]

  # Compose a list of functions sequentially to a new function
  #
  # This method calls F.compose with reversed arguments.
  #
  # Example:
  #   number = sequence parseFloat, Math.round
  #   number '72.5'
  #   # => Math.round(parseFloat('72.5'))
  sequence: (fns...) -> F.compose(A.reverse(fns))

  # Partially apply arguments to a function
  #
  # Example:
  #   f = (a, b, c) -> console.log a, b, c
  #   g = partial f, 'partially applied'
  #   #=> g == (b, c) -> f 'partially applied', b, c
  partial: (fn, bound...) -> (args...) -> fn.apply @, A.concat(bound, args)

  # Partially apply arguments to a function, but on the right hand side of the
  # list
  #
  # Example:
  #   f = (a, b, c, d) -> console.log a, b, c, d
  #   g = partial_right f, 'yadda', 'foo'
  #   #=> g == (a, b) -> f a, b, 'yadda', 'foo'
  partial_right: (fn, bound...) -> (args...) -> fn.apply @, A.concat(args, bound)

  # Partially apply arguments to a function, starting with the last argument
  #
  # Example:
  #   f = (a, b, c) -> console.log a, b, c
  #   g = partial_reverse f, 'yadda', 'foo'
  #   #=> g == (a) -> f a, 'foo', 'yadda'
  partial_reverse: (fn, bound...) ->
    (args...) -> fn.apply @, A.concat(args, A.reverse(bound))
}

module.exports = F
