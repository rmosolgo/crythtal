require "./expression"
require "./binding"

module Lisp::Functions
  If = Proc(Lisp::Expression::List, Lisp::Binding, Lisp::Expression).new { |args, binding|
    test_expr = args[0]
    true_expr = args[1]
    false_expr = args[2]
    test_result = test_expr.return_expression(binding)
    if test_result.value
      true_expr.return_expression(binding)
    else
      false_expr.return_expression(binding)
    end
  }
end
