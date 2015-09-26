require "./expression"
require "./binding"

module Lisp::Functions
  alias SystemFunction = Proc(Lisp::Expression::List, Lisp::Binding, Lisp::Expression)
  If = SystemFunction.new { |args, binding|
    test_expr = args[0]
    test_result = test_expr.return_expression(binding)
    if test_result.value
      args[1].return_expression(binding)
    else
      args[2].return_expression(binding)
    end
  }

  Define = SystemFunction.new { |args, binding|

  }
end
