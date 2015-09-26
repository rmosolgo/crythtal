require "../spec_helper"

describe "Lisp::Binding" do
  describe "#[]" do
    it "gets values from the binding" do
      binding = Lisp::Binding.new({"name" => Lisp::Expression.new("Crystal") })
      binding["name"].value.should eq("Crystal")
    end

    pending "raises errors on missing keys" do
      binding = Lisp::Binding.new({} of String => Lisp::Expression)
      binding["missingKey"]
    end

    it "gets & sets values from parent binding" do
      parent = Lisp::Binding.new(Lisp::GLOBAL)
      child = parent.append({"new" => Lisp::Expression.express(1) })
      # Gets from parent
      child["+"].value.should be_a(Lisp::Expression::Function)
      # Sets into parent
      child["+"] = Lisp::Expression.express("newValue")
      parent["+"].should eq(Lisp::Expression.express("newValue"))
    end
  end

  describe "GLOBALS" do
    it "contains binary operations" do
      binding = Lisp::Binding.new(Lisp::GLOBAL)
      args = Lisp::Expression.express([2,2]).value as Array

      add_fn = binding["+"].value as Lisp::Expression::Function
      add_fn.call(args, binding).value.should eq(4)

      div_fn = binding["/"].value as Lisp::Expression::Function
      div_fn.call(args, binding).value.should eq(1)
    end
  end
end
