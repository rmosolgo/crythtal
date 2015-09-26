require "./parser"
require "./global"

class Lisp::Repl
  def initialize
    @binding = Lisp::Binding.new(Lisp::GLOBAL)
    @parser = Lisp::Parser.new
  end

  def run
    puts "Lisp REPL (cntl-d to quit): "
    while true
      STDOUT.print("> ")
      STDOUT.flush
      raw_input = gets
      if raw_input.is_a?(String)
        begin
          expression = @parser.parse(raw_input)
          result = expression.return_expression(@binding)
          puts result.to_s
        rescue err : Exception
          puts err.to_s
        end
      elsif raw_input.nil?
        break
      end
    end
  end
end
