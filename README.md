# platform.coffee

A set of modules aiming to provide a state of the art *platform* to build
libraries and applications with. It incorporates building block features of
other libraries and frameworks with the goal to reduce code duplication
throughout different projects.

*platform* embraces functional programming and provides composable wrappers for
most of the standard types' methods as well as functions for function
composition.

All of the code is usable in any kind of environment, be it NodeJS, the browser
or any other ES5 compliant runtime.

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

## Higher-order functions

 * `args_from_array(Function) -> Function`: Return a function that takes arguments as array instead of an argument list.
 * `compose(Function...) -> Function`: Compose a list of functions (`compose(f, g, h) == h(g(f(...)))`)
 * `sequence(Function...) -> Function`: The same as `compose` but arguments are reversed (`sequence(f, g, h) == f(g(h(...)))`)
 * `partial(Function, Any...) -> Function`: Partially apply given arguments to a function (`partial(fn, 1, 2, 3) == fn(1, 2, 3, ...)`)
 * `partial_right(Function, Any...) -> Function`: Partially apply given arguments to a function, but start with the last arguments (`partial_right(fn, 1, 2, 3) == fn(..., 1, 2, 3)`)
 * `partial_reverse(Function, Any...) -> Function`: Partially apply given arguments to a function, but start with the last arguments in reversed order (`partial_reverse(fn, 1, 2, 3) == fn(..., 3, 2, 1)`)
