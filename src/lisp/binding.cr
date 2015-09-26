require "./expression.cr"

class Lisp::Binding
  alias VariablesTable = Hash(String, Lisp::Expression)

  macro binary_operation(name)
    Lisp::Expression.new(-> (args : Lisp::Expression::List) {
      left = args[0].value as Int32
      right = args[1].value as Int32
      result = left {{name.id}} right
      Lisp::Expression.new(result)
    })
  end
  GLOBALS = {
    "+" => binary_operation(:+),
    "-" => binary_operation(:-),
    "*" => binary_operation(:*),
    "/" => binary_operation(:/),
  }
  def initialize(@values : VariablesTable)
  end

  def [](key)
    @values[key]
  end
end
