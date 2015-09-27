require "../spec_helper"

global_binding = Lisp::Binding.new(Lisp::GLOBAL)

describe "Lisp::Evaluation" do
  it "Gets a return value from a simple expression" do
    string_exp = Lisp::Expression.new("MyString")
    string_eval = Lisp::Evaluation.new(string_exp, global_binding)
    string_eval.return_expression.value.should eq("MyString")
  end

  it "Gets a return value from a function call" do
    addition_call = Lisp::Expression.new([
      Lisp::Expression.new("+"),
      Lisp::Expression.new(5),
      Lisp::Expression.new(6),
    ])
    addition_eval = Lisp::Evaluation.new(addition_call, global_binding)
    addition_eval.return_expression.value.should eq(11)
  end

  it "Makes nested calls" do
    addition_call = Lisp::Expression.new([
      Lisp::Expression.new("+"),
      Lisp::Expression.new(5),
      Lisp::Expression.new(6),
    ])

    test_call = Lisp::Expression.new([
      Lisp::Expression.new("="),
      Lisp::Expression.new(11),
      addition_call,
    ])
    expr_eval = Lisp::Evaluation.new(test_call, global_binding)
    expr_eval.return_expression.value.should eq(true)
  end

  it "Lets functions evaluate their own argument expressions" do
    # The "else" condition would raise an error
    expressions = Lisp::Parser.new.parse("
      (if (>= 6 5)
          (+ 2 2)
          (go crazy)
      )
    ")
    expr_eval = Lisp::Evaluation.new(expressions, global_binding)
    expr_eval.return_expression.value.should eq(4)
  end

  it "Executes recursive functions" do
    repl = Lisp::Repl.new
    repl.eval("
      (define sum-to (lambda(n) (begin
        (if (= n 0)
            0
            (+ n (sum-to (- n 1)))))))
    ")
    result = repl.eval("(sum-to 10)")
    result.value.should eq(55)
  end
end
