require "../spec_helper"

global_binding = Lisp::Binding.new(Lisp::GLOBAL)

describe "Lisp::Procedure" do
  describe "#call" do
    it "uses the given arguments" do
      params = [
        Lisp::Expression.express("first"),
        Lisp::Expression.express("second")
      ]
      body = Lisp::Expression.express(["+", "first", ["*", "second", 5]])
      scope = global_binding
      procedure = Lisp::Lambda.new(params, body, scope)
      arguments = [Lisp::Expression.express(8), Lisp::Expression.express(3)]
      result = procedure.call(arguments, scope)
      result.value.should eq(23)
    end

    it "uses the given binding" do
      params = [] of Lisp::Expression
      body = Lisp::Expression.express(["+", "first",  5])
      scope = global_binding.append({"first" => Lisp::Expression.express(10)})
      procedure = Lisp::Lambda.new(params, body, scope)
      arguments = [] of Lisp::Expression
      result = procedure.call(arguments, scope)
      result.value.should eq(15)
    end

    it "can be called after defining" do
      repl = Lisp::Repl.new
      repl.eval("
        (define make-account
          (lambda (balance)
            (lambda (amt)
              (begin (define balance (+ balance amt))
                     balance))))
      ")
      repl.eval("(define account1 (make-account 100.00))")
      result = repl.eval("(account1 -20.00)")
      result.value.should eq(80.0)
    end
  end
end
