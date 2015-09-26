class Lisp::Binding
  def initialize(@values)
  end

  def [](key)
    @values[key]
  end

  def []?(key)
    @values[key]?
  end

  def []=(key, value)
    new_values = @values.merge({key => value})
    @values = new_values
  end
end
