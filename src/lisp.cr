require "./lisp/expression.cr"
require "./lisp/binding.cr"
require "./lisp/parser.cr"
require "./lisp/evaluation.cr"
require "./lisp/global.cr"
require "./lisp/functions.cr"
require "./lisp/repl.cr"


# To start a REPL
# `crystal src/lisp.cr -- run`
if ARGV[0]? == "run"
  repl = Lisp::Repl.new
  repl.run
end
