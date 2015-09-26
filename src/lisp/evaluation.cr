class Lisp::Evaluation
  def initialize(@expression, @binding)
  end

  def return_expression : Lisp::Expression
    evaluate(@expression.value)
  end

  private def evaluate(value : Lisp::Expression::SingularType)
    @expression
  end

  private def evaluate(value : Array(Lisp::Expression))
    function_name = value[0].value as String
    function_def = @binding[function_name].value as Lisp::Expression::Function
    function_args = value[1..-1]
    evaluated_function_args = function_args.map do |arg_expression|
      evaluation = Lisp::Evaluation.new(arg_expression, @binding)
      evaluation.return_expression
    end
    function_def.call(evaluated_function_args)
  end
end
