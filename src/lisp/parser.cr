require "./expression.cr"

class Lisp::Parser
  def parse(source_string)
    tokens = tokenize(source_string)
    expression = build_ast(tokens)
  end

  private def tokenize(source_string)
    tokens = source_string
      .gsub("(", " ( ")
      .gsub(")", " ) ")
      .split(" ")
    return tokens
  end

  private def build_ast(tokens)
    if tokens.size == 0
      raise("unexpected EOF while reading")
    end
    next_token = tokens[0]
    tokens.shift(1)
    if next_token == "("
      expression = [] of Lisp::Expression
      while tokens[0] != ")"
        expression.push(build_ast(tokens))
      end
      tokens.shift(1) # remove )
      Lisp::Expression.new(expression)
    elsif next_token == ")"
      raise("unexpected )")
    else
      atomize(next_token)
    end
  end

  private def atomize(token : String) : Lisp::Expression
    if /^-?\d+$/ =~ token
      Lisp::Expression.new(token.to_i)
    elsif /^-?\d+\.\d+$/ =~ token
      Lisp::Expression.new(token.to_f)
    elsif token == "true"
      Lisp::Expression.new(true)
    elsif token == "false"
      Lisp::Expression.new(false)
    else
      Lisp::Expression.new(token)
    end
  end
end
