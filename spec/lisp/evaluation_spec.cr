require "../spec_helper"

global_binding = Lisp::Binding.new(Lisp::Binding::GLOBALS)

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

    subtraction_call = Lisp::Expression.new([
      Lisp::Expression.new("-"),
      Lisp::Expression.new(20),
      addition_call,
    ])
    expr_eval = Lisp::Evaluation.new(subtraction_call, global_binding)
    expr_eval.return_expression.value.should eq(9)
  end
end
