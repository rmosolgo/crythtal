require "./expression"
require "./binding"
require "./functions"

module Lisp
  macro binary_operation(name)
    %fn_proc = -> (args : Lisp::Expression::List, binding : Lisp::Binding) {
      left = args[0].return_expression(binding).value as Int32
      right = args[1].return_expression(binding).value as Int32
      result = left {{name.id}} right
      Lisp::Expression.new(result)
    }
    Lisp::Expression.new(%fn_proc)
  end

  GLOBAL = {
    "+" => binary_operation(:+),
    "-" => binary_operation(:-),
    "*" => binary_operation(:*),
    "/" => binary_operation(:/),
    "=" => binary_operation(:==),
    "if" => Lisp::Expression.new(Lisp::Functions::If),
  }
end
