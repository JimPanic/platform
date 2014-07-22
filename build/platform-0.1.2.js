(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var A,
  __slice = [].slice;

A = {
  clone: function(array) {
    return array.slice(0);
  },
  concat: function() {
    var args, array, _i;
    args = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), array = arguments[_i++];
    return array.concat.apply(null, args);
  },
  each: function(fn, array) {
    array.forEach(fn);
    return void 0;
  },
  equals: function(a, b) {
    if (a.length !== b.length) {
      return false;
    }
    return a.reduce(function(previous, current, i) {
      return previous && b[i] === current;
    });
  },
  every: function(fn, array) {
    return true === array.every(fn);
  },
  filter: function(fn, array) {
    return array.filter(fn);
  },
  has_element: function(element, array) {
    return -1 !== array.indexOf(element);
  },
  index_of: function(element, array) {
    return array.indexOf(element);
  },
  join: function(seperator, array) {
    return array.join(seperator);
  },
  last_index_of: function(element, array) {
    return array.lastIndexOf(element);
  },
  map: function(fn, array) {
    return array.map(fn);
  },
  reduce: function(fn, initial_value, array) {
    return array.reduce(fn, initial_value);
  },
  reduce_right: function(fn, initial_value, array) {
    return array.reduceRight(fn, initial_value);
  },
  reverse: function(array) {
    return A.clone(array).reverse();
  },
  slice: function() {
    var array, begin_end, _i;
    begin_end = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), array = arguments[_i++];
    return array.slice.apply(null, begin_end);
  },
  some: function(fn, array) {
    return array.some(fn);
  },
  sort: function(array) {
    return A.clone(array).sort();
  },
  sort_by: function(fn, array) {
    return A.clone(array).sort(fn);
  },
  replace: function(index, n, replace_with, array) {
    return A.clone(array).splice(index, n, replace_with);
  }
};

module.exports = A;

},{}],2:[function(require,module,exports){
var A, O, T;

A = require('./array');

T = require('./types');

O = {
  each: function(fn, object) {
    var wrapped;
    wrapped = function(object) {
      return function(element, index, array) {
        return fn.apply(null, [object[element], element, object]);
      };
    };
    A.each(wrapped(object), Object.keys(object));
    return void 0;
  },
  equals: function(a, b) {
    var fn, keys_a, keys_b;
    if (!(T.is_object(a) && T.is_object(b))) {
      return false;
    }
    keys_a = Object.keys(a);
    keys_b = Object.keys(b);
    if (keys_a.length !== keys_b.length) {
      return false;
    }
    if (!A.equals(keys_a, keys_b)) {
      return false;
    }
    fn = function(previous, value, key, obj) {
      if (T.type_of(value) !== T.type_of(b[key])) {
        return false;
      }
      if (T.is_array(value)) {
        return previous && A.equals(value, b[key]);
      }
      if (T.is_object(value)) {
        return previous;
      }
      return previous && b[key] === value;
    };
    return O.reduce(fn, true, a);
  },
  every: function(fn, object) {
    var wrapped;
    wrapped = function(fn, object) {
      return function(value, index, array) {
        return fn(object[value], value, object);
      };
    };
    return A.every(wrapped(fn, object), Object.keys(object));
  },
  filter: function(fn, object) {
    var wrapped;
    wrapped = function(object) {
      return function(new_object, key) {
        new_object[key] = object[key];
        return new_object;
      };
    };
    return A.reduce(wrapped(object), {}, A.filter(fn, Object.keys(object)));
  },
  has_key: function(key, object) {
    return A.has_element(key, Object.keys(object));
  },
  has_value: function(value, object) {
    var wrapped;
    wrapped = function(value) {
      return function(v) {
        return v === value;
      };
    };
    return O.some(wrapped(value), object);
  },
  map: function(fn, object) {
    var results, wrapped;
    results = {};
    wrapped = function(results, fn) {
      return function(element, index, array) {
        var result;
        result = fn(element, index, array);
        if (T.is_array(result) && result.length === 2) {
          results[result[0]] = results[result[1]];
          return;
        }
        return results[index] = result;
      };
    };
    O.each(wrapped(results, fn), object);
    return results;
  },
  reduce: function(fn, initial_value, object) {
    var wrapped;
    wrapped = function(fn, object) {
      return function(previous, current, key, array) {
        return fn(previous, object[current], current, object);
      };
    };
    return A.reduce(wrapped(fn, object), initial_value, Object.keys(object));
  },
  some: function(fn, object) {
    var wrapped;
    wrapped = function(fn, object) {
      return function(value, index, array) {
        return fn(object[value], value, object);
      };
    };
    return A.some(wrapped(fn, object), Object.keys(object));
  }
};

module.exports = O;

},{"./array":1,"./types":4}],3:[function(require,module,exports){
module.exports = {
  A: require('./array'),
  O: require('./object'),
  T: require('./types'),
  defaults: require('./with_defaults')
};

},{"./array":1,"./object":2,"./types":4,"./with_defaults":5}],4:[function(require,module,exports){
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

},{}],5:[function(require,module,exports){
module.exports = function(object, defaults) {
  var f;
  f = function(previous, current) {
    if (!Object.hasOwnProperty(previous, current)) {
      previous[current] = object[current];
    }
    return previous;
  };
  return Object.keys(object).reduce(f, defaults);
};

},{}]},{},[3]);