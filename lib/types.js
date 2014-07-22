var is_a, is_a_uncurried, type_of;

type_of = function(x) {
  return x.constructor.name;
};

is_a_uncurried = function(t, x) {
  if (type_of(t) !== "String") {
    console.log('WARNING: Given type must be a string as in: is_a("Object", obj)');
    console.log('Given: ', type_of(t));
    return false;
  }
  if (x == null) {
    return false;
  }
  return type_of(x) === t;
};

is_a = function(type, x) {
  if (1 === arguments.length) {
    return function(x) {
      return is_a_uncurried(type, x);
    };
  }
  if (0 === arguments.length) {
    console.log("WARNING: No arguments given. Expecting String, expression");
    return false;
  }
  return is_a_uncurried.call(x, type, x);
};

module.exports = {
  is_a: is_a,
  is_object: is_a("Object"),
  is_array: is_a("Array"),
  is_function: is_a("Function"),
  is_string: is_a("String"),
  is_regexp: is_a("RegExp"),
  is_bool: is_a("Boolean"),
  is_error: is_a("Error"),
  is_number: is_a("Number"),
  is_date: is_a("Date"),
  is_null: function(x) {
    return x === null;
  },
  is_undefined: function(x) {
    return x === void 0;
  },
  is_nan: function(x) {
    return x === NaN;
  },
  type_of: type_of
};
