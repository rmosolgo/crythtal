class Lisp::Binding
  def initialize(@values)
  end

  def [](key)
    @values[key]
  end
end
