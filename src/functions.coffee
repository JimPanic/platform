A = require './array'

F = {
  compose: (fns...) ->
    (args...) ->
      args = [fn.apply @, args] for fn in fns
      args[0]

  sequence: (fns...) -> F.compose(A.reverse(fns))

  partial: (fn, bound...) ->
    (args...) -> fn.apply @, A.concat(bound, args)

  partial_right: (fn, bound...) ->
    (args...) -> fn.apply @, A.concat(args, bound)

  partial_reverse: (fn, bound...) ->
    (args...) -> fn.apply @, A.concat(args, A.reverse(bound))
}

module.exports = F
