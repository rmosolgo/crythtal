require "./expression"
require "./binding"

module Lisp::Functions
  alias Function = Lisp::Expression::Function
  If = Function.new { |args, binding|
    test_expr = args[0]
    test_result = test_expr.return_expression(binding)
    if test_result.value
      args[1].return_expression(binding)
    else
      args[2].return_expression(binding)
    end
  }

  Define = Function.new { |args, binding|
    var_name = args[0].value
    if var_name.is_a?(String)
      var_value = args[1].return_expression(binding)
      binding[var_name] = var_value
    else
      var_value = Lisp::Expression.new(false)
    end
    var_value
  }

  Quote = Function.new { |args, binding|
    return_expression = Lisp::Expression.new(args)
  }

  Lambda = Function.new { |args, binding|
    params = args[0].value
    if params.is_a?(Array)
      body = args[1]
      procedure = Lisp::Lambda.new(params, body, binding)
      call_proc = Function.new { |inner_args, inner_binding|
        procedure.call(inner_args, inner_binding)
      }
      Lisp::Expression.new(call_proc)
    else
      Lisp::Expression.new(false)
    end
  }

  Begin = Function.new { |args, binding|
    return_expression = Lisp::Expression.new(false)
    args.map { |expr|
      return_expression = expr.return_expression(binding)
    }
    return_expression
  }

end
