(defmacro stringify (arg)
  `(symbol-name (quote ,arg)))
