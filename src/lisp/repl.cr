require "./parser"
require "./global"

class Lisp::Repl
  def initialize
    @binding = Lisp::Binding.new(Lisp::GLOBAL)
    @parser = Lisp::Parser.new
  end

  def run
    puts "Lisp REPL (cntl-d to quit): "
    buffer = ""
    depth = 0
    indent = 0
    while true
      STDOUT.print("> " + (" " * indent))
      STDOUT.flush
      raw_input = gets
      if raw_input.is_a?(String) && raw_input.size > 1
        buffer += raw_input
        begin
          result = eval(buffer)
          buffer = ""
          indent = 0
          depth = 0
          puts result.to_s
        rescue nf : Lisp::Parser::NotFinishedException
          if nf.depth > depth
            indent += 1
          elsif nf.depth < depth
            indent -= 1
          end
          depth = nf.depth
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
