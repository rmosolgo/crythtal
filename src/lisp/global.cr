require "./expression"
require "./binding"
require "./functions"

module Lisp
  macro binary_operation(name, operand_types)
    %fn_proc = -> (args : Lisp::Expression::List, binding : Lisp::Binding) {
      left = args[0].return_expression(binding).value
      right = args[1].return_expression(binding).value
      result = false
      {% for operand_type in operand_types %}
        if left.is_a?({{operand_type.id}}) && right.is_a?({{operand_type.id}})
          result = left {{name.id}} right
        end
      {% end %}

      Lisp::Expression.new(result)
    }
    Lisp::Expression.new(%fn_proc)
  end

  GLOBAL = {
    "+" => binary_operation(:+, [String, Int32]),
    "-" => binary_operation(:-, [Int32]),
    "*" => binary_operation(:*, [Int32]),
    "/" => binary_operation(:/, [Int32]),
    "=" => binary_operation(:==, [String, Int32]),
    "if" => Lisp::Expression.new(Lisp::Functions::If),
  }
end
