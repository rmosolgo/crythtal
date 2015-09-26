require "../spec_helper"

global_binding = Lisp::Binding.new(Lisp::GLOBAL)

describe "Lisp::Functions" do
  describe "If" do
    it "doesnt evaluate the alternate if the test is true" do
      expressions = Lisp::Parser.new.parse("
        (if (= 5 5)
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
  end

  describe "Define" do
    pending "modifies the current binding" do
    end
  end

  describe "Quote" do
    pending "returns the arguments as a list" do
    end
  end
end
