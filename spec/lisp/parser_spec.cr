require "../spec_helper"

def get_plain_values(lisp_values)
  Lisp::Expression.unexpress(lisp_values)
end

describe "Parser" do
  describe "#parse" do
    it "returns tokenized expressions" do
      parser = Lisp::Parser.new
      expression = parser.parse("(+ 1 2 ) ")
      get_plain_values(expression).should eq(["+", 1, 2])
    end

    it "returns nested tokenized expressions" do
      parser = Lisp::Parser.new
      expression = parser.parse("
        (if
          (= 5 5)
          (do ok)
          (do 11)
        )")
      get_plain_values(expression).should eq(
        ["if",
          ["=", 5, 5],
          ["do", "ok"],
          ["do", 11],
        ]
      )
    end
  end
end
