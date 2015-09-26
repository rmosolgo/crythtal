class Lisp::Binding
  def initialize(values)
    @values = values.dup
  end

  def [](key)
    @values[key]
  end

  def []?(key)
    @values[key]?
  end

  def []=(key, value)
    new_values = @values[key] = value
  end

  def values
    @values
  end

  def merge(other_binding : Lisp::Binding)
    new_values = @values.merge(other_binding.values)
    self.class.new(new_values)
  end

  def merge(other_values : Hash)
    new_values = @values.merge(other_values)
    self.class.new(new_values)
  end
end
