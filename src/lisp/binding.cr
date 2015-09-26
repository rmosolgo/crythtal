require "./expression.cr"

class Lisp::Binding
  alias VariablesTable = Hash(String, Lisp::Expression)

  macro binary_operation(name)
    Lisp::Expression.new(-> (arg_exp : Lisp::Expression) {
      args = arg_exp.value as Array(Lisp::Expression)
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
