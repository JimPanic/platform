A = {
  # Create a clone of given array and return it.
  clone: (array) -> array.slice(0)

  # Concatinate multiple values and arrays. The last argument must be an array
  # and is considered the base to concatinate to.
  #
  # NOTE: This is a composable wrapper for `Array.concat`
  concat: (args..., array) -> array.concat.apply(null, args)

  # Iterate over all elements of given array.
  #
  # The callback parameters are the same as for `Array.forEach`:
  #  * value
  #  * index
  #  * array
  #
  # NOTE: This is just a composable wrapper for `Array.each`.
  each: (fn, array) ->
    array.forEach(fn)
    
    return undefined

  # Composable wrapper for `Array.every`
  every: (fn, array) -> array.every(fn)

  # Composable wrapper for `Array.filter`
  filter: (fn, array) -> array.filter(fn)

  # Find out whether the array holds a given value.
  has_element: (element, array) -> -1 != array.indexOf(element)

  # Composable wrapper for `Array.indexOf`
  index_of: (element, array) -> array.indexOf(element)

  # Composable wrapper for `Array.join`
  join: (seperator, array) -> array.join(seperator)

  # Composable wrapper for `Array.lastIndexOf`
  last_index_of: (element, array) -> array.lastIndexOf(element)

  # Composable wrapper for `Array.map`
  map: (fn, array) -> array.map(fn)

  # Composable wrapper for `Array.reduce`
  reduce: (fn, initial_value, array) -> array.reduce(fn, initial_value)

  # Composable wrapper for `Array.reduceRight`
  reduce_right: (fn, initial_value, array) -> array.reduceRight(fn, initial_value)

  # Create a reversed version of the array and return it.
  # 
  # NOTE: This is just a wrapper for `Array.reverse`, which reverses the array
  #       in-place.
  reverse: (array) -> A.clone(array).reverse()

  # Composable wrapper for `Array.slice`
  slice: (begin_end..., array) -> array.slice.apply(null, begin_end)

  # Composable wrapper for `Array.some`
  some: (fn, array) -> array.some(fn)

  # Create a sorted copy of given array.
  #
  # NOTE: This is a composable wrapper for `Array.sort`, which sorts the array
  #       in-place.
  sort: (array) -> A.clone(array).sort()

  # Create a copy and sort given array by given sort function.
  #
  # NOTE: This is a composable wrapper for `Array.sort`, which sorts the array
  #       in-place.
  sort_by: (fn, array) -> A.clone(array).sort(fn)

  # Create a copy and replace `n` elements with given `replace_with` array
  # at a given `index`.
  #
  # NOTE: This is a composable wrapper for `Array.splice`, which replaces items
  #       in-place. The names deliberately differ.
  replace: (index, n, replace_with, array) ->
    A.clone(array).splice(index, n, replace_with)
}

module.exports = A
