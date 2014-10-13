var A, F, T, Test;

A = require('../src/array');

F = require('../src/functions');

T = require('../src/types');

Test = {
  assert: function(fn, description) {
    var error, result;
    if (description == null) {
      description = fn.toString();
    }
    try {
      result = true === fn.call();
    } catch (_error) {
      error = _error;
      result = error;
    }
    return {
      expression: fn,
      description: description,
      result: result
    };
  },
  expect: function(fn, input, expected, description) {
    var expression;
    if (description == null) {
      description = void 0;
    }
    expression = function(input, expected) {
      return function() {
        var result;
        result = fn.apply(null, input);
        if (T.is_object(expected) && T.is_object(result)) {
          return O.equals(expected, result);
        }
        if (T.is_array(expected) && T.is_array(result)) {
          return A.equals(expected, result);
        }
        return expected === result;
      };
    };
    return Test.assert(expression(input, expected), description);
  },
  run: function(tests) {
    return A.map(F.args_from_array(Test.expect), tests);
  },
  print: function(result) {
    var default_print_fn;
    return default_print_fn = function(_arg) {
      var description, expression, result;
      expression = _arg.expression, description = _arg.description, result = _arg.result;
      return console.log(("" + description + ": ") + (result ? 'success' : 'failed'));
    };
  }
};

module.exports = Test;
