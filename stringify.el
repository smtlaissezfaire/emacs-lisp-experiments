(defmacro stringify (arg)
  "Tries to stringify an unevaluated argument"
  `(symbol-name (quote ,arg)))

