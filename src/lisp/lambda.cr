class Lisp::Lambda
  def initialize(params, @body, @scope)
    @param_names = params.map { |v| v.value as String }
  end

  def call(args, caller_binding)
    parent_binding = @scope
      .merge(caller_binding)
      .merge(bind_arguments(@param_names, args))

    @body.return_expression(parent_binding)
  end

  # Make a new hash of bound values based on params & arguments
  private def bind_arguments(param_names, argument_values)
    new_values = {} of String => Lisp::Expression
    param_names.each_with_index do |param_name, idx|
      if param_name.is_a?(String)
        value = argument_values[idx]
        new_values[param_name] = value
      end
    end
    new_values
  end

end
