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
          result = eval(raw_input)
          puts result.to_s
        rescue err : Exception
          puts err.to_s + "\n" + err.backtrace.join("\n")
        end

      elsif raw_input.nil?
        puts
        break
      end
    end
  end

  def eval(raw_input)
    expression = @parser.parse(raw_input)
    expression.return_expression(@binding)
  end
end
