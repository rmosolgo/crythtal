class Lisp::Expression
  alias Function = (Lisp::Expression -> Lisp::Expression)
  alias List = Array(Lisp::Expression)
  alias Type = Int32 | String | Function | List
  alias Expressable = Type | Array(Expressable)

  property :value

  def initialize(@value : Type)
  end

  def self.express(value) : Lisp::Expression
    if value.is_a?(Array)
      self.new(value.map { |v| express(v) })
    else
      self.new(value)
    end
  end

  def self.unexpress(lisp_values) : Expressable
    if lisp_values.is_a?(Lisp::Expression)
      get_plain_values(lisp_values.value)
    elsif lisp_values.is_a?(Array)
      lisp_values.map { |v| get_plain_values(v) as Expressable }
    else
      lisp_values
    end
  end
end
