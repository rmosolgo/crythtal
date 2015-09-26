class Lisp::Binding
  class NullBinding
    def find_owner(key)
      nil
    end
  end

  def initialize(values)
    @values = values.dup
    @parent = NullBinding.new
  end

  def initialize(values, parent_binding)
    @values = values.dup
    @parent = parent_binding
  end

  def [](key)
    owner = find_owner(key)
    if owner.is_a?(Lisp::Binding)
      owner.values[key]
    else
      raise("No such variable: #{key}")
    end
  end

  def []?(key)
    value = self[key]
  rescue
    nil
  end

  def []=(key, value)
    owner = find_owner(key) || self
    owner.values[key] = value
  end

  def values
    @values
  end

  def append(other_binding : Lisp::Binding)
    new_values = other_binding.values
    append(new_values)
  end

  def append(new_values : Hash)
    self.class.new(new_values, self)
  end

  protected def find_owner(key)
    if @values[key]?
      self
    else
      @parent.find_owner(key)
    end
  end
end
