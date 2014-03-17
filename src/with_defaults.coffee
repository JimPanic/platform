module.exports = (object, defaults) ->
  f = (previous, current) ->
    unless Object.hasOwnProperty(previous, current)
      previous[current] = object[current]

    previous

  Object.keys(object).reduce f, defaults
