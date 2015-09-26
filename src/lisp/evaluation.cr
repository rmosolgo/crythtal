class Lisp::Evaluation
  def initialize(@expression, @binding)
  end

  def return_expression : Lisp::Expression
    evaluate(@expression.value)
  end

  private def evaluate(value : Lisp::Expression::SingularType)
    binding = @binding
    if value.is_a?(String) && binding[value]?
      binding[value]
    else
      @expression
    end
  end

  private def evaluate(value : Array(Lisp::Expression))
    function_name = value[0].value as String
    function_def = @binding[function_name].value as Lisp::Expression::Function
    function_args = value[1..-1]
    function_def.call(function_args, @binding) as Lisp::Expression
  end
end
