# platform.coffee


A set of JavaScript modules and functions to work with builtin types in a functional manner.

It aims to provide a platform to build other libraries upon as opposed to all-in-one library beasts.

## Type functions

 * `is_a(String, Any) -> Boolean`
 * `type_of(Any)      -> String`
 * `is_object(Any)    -> Boolean`
 * `is_array(Any)     -> Boolean`
 * `is_function(Any)  -> Boolean`
 * `is_string(Any)    -> Boolean`
 * `is_regexp(Any)    -> Boolean`
 * `is_bool(Any)      -> Boolean`
 * `is_error(Any)     -> Boolean`
 * `is_number(Any)    -> Boolean`
 * `is_date(Any)      -> Boolean`
 * `is_null(Any)      -> Boolean`
 * `is_undefined(Any) -> Boolean`
 * `is_nan(Any)       -> Boolean`

## Array functions

 * `clone(Array)                 -> Array`: Create an shallow copy of the array.
 * `concat(Array, Array)         -> Array` Composable wrapper for `Array.prototype.concat`
 * `each(Function, Array)        -> undefined`: Composable wrapper for `Array.prototype.each`
 * `equals(Array, Array)         -> Boolean`: Compare length, order & value equality of two arrays
 * `every(Function, Array)       -> Boolean`: Composable wrapper for `Array.prototype.every` that always returns a `Boolean`.
 * `filter(Function, Array)      -> Array`: Composable wrapper for `Array.prototype.filter`
 * `has_element(Any, Array)      -> Boolean`: Find out whether the array holds a given value
 * `index_of(Any, Array)         -> Boolean`: Composable wrapper for `Array.prototype.indexOf`
 * `join(String, Array)          -> String`: Composable wrapper for `Array.prototype.join`
 * `last_index_of(Any, Array)    -> Number`: Composable wrapper for `Array.prototype.lastIndexOf`
 * `map(Function, Array)         -> Array`: Composable wrapper for `Array.prototype.map`
 * `reduce(Function, Any, Array) -> Any`: Composable wrapper for `Array.prototype.reduce`
 * `reduce_right(Function, Any, Array) -> Any`: Composable wrapper for `Array.prototype.reduceRight`
 * `reverse(Array)               -> Array`: A wrapper for `Array.prototype.reverse` without side-effects (clones before reversing)
 * `slice(Number, [Number], Array) -> Array`: Composable wrapper for `Array.prototype.slice`
 * `some(Function, Array) ->     -> Boolean`: Composable wrapper for `Array.prototype.some`
 * `sort(Array)                  -> Array`: A wrapper for `Array.prototype.sort` without side-effects (clones before sorting)
 * `sort_by(Function, Array)     -> Array`: A wrapper for `Array.prototype.sort` without side-effects (clones before sorting)
 * `replace(Number, Number, Array, Array) -> Array`: A wrapper for `Array.prototype.replace` without side-effects (clones before replacing)
