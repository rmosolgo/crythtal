require "../spec_helper"

global_binding = Lisp::Binding.new(Lisp::GLOBAL)

describe "Lisp::Functions" do
  describe "If" do
    it "doesnt evaluate the alternate if the test is true" do
      expressions = Lisp::Parser.new.parse("
        (if (= 5.0 5)
            (+ 2 2)
            (go crazy)
        )
      ")
      expr_eval = Lisp::Evaluation.new(expressions, global_binding)
      expr_eval.return_expression.value.should eq(4)
    end

    it "doesnt evaluate the consequence if the test is false" do
      expressions = Lisp::Parser.new.parse("
        (if (= onestr twostr)
            (go crazy)
            (+ combined strings)
        )
      ")
      expr_eval = Lisp::Evaluation.new(expressions, global_binding)
      expr_eval.return_expression.value.should eq("combinedstrings")
    end

    it "doesnt require an alternate" do
      expressions = Lisp::Parser.new.parse("
        (if (< a b) 1)
      ")
      expr_eval = Lisp::Evaluation.new(expressions, global_binding)
      expr_eval.return_expression.value.should eq(1)
    end
  end

  describe "Define" do
    it "modifies the current binding" do
      expressions = Lisp::Parser.new.parse("(define ten 10)")
      expr_eval = Lisp::Evaluation.new(expressions, global_binding)
      expr_eval.return_expression # force it to run

      expressions = Lisp::Parser.new.parse("(= ten 10)")
      expr_eval = Lisp::Evaluation.new(expressions, global_binding)
      expr_eval.return_expression.value.should eq(true)
    end
  end

  describe "Quote" do
    it "returns the arguments as a list" do
      expressions = Lisp::Parser.new.parse("(quote ten 10 true)")
      list_expressions = Lisp::Expression.express(["ten",  10, true])
      first_result = expressions.return_expression(global_binding)
      first_result.should eq(list_expressions)
    end
  end
end
