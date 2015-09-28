class Lisp::Lambda
  def initialize(params, @body, @scope)
    @param_names = params.map { |v| v.value as String }
  end

  def call(args, caller_binding)

    evaluted_arguments = args.map do |arg|
      arg.return_expression(caller_binding) as Lisp::Expression
    end

    parent_binding = @scope
      .append(caller_binding)
      .append(bind_arguments(@param_names, evaluted_arguments))

    @body.return_expression(parent_binding)
  end

  # Make a new hash of bound values based on params & arguments
  private def bind_arguments(param_names, argument_values)
    new_values = {} of String => Lisp::Expression
    param_names.each_with_index do |param_name, idx|
      new_values[param_name] = argument_values[idx]
    end
    new_values
  end

end
