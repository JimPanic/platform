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
