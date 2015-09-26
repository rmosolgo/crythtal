require "../spec_helper"

describe "Lisp::Expression" do
  describe "#return_expression" do
    it "evaluates the expression in the given binding" do
      addition_call = Lisp::Expression.express(["+", 5, 6])
      binding = Lisp::Binding.new(Lisp::GLOBAL)
      result = addition_call.return_expression(binding)
      result.value.should eq(11)
    end
  end
end
