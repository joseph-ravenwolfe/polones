defmodule TokenTest do
  use ExUnit.Case
  doctest Polones.Token

  describe "Token.parse" do
    test "parses a string into several tokens" do
      tokens = Polones.Token.parse("2 4 +")
      assert length(tokens) == 3
    end
  end

  describe "Token.new" do
    test "sets operator? true a basic operator" do
      token = Polones.Token.new("+")
      assert token.operator? == true
    end

    test "sets operator? false for an unrecognized operator" do
      token = Polones.Token.new("noop")
      assert token.operator? == false
    end

    test "sets division? true for a division symbol" do
      token = Polones.Token.new("/")
      assert token.division? == true
    end

    test "sets division? false for a non-division symbol" do
      token = Polones.Token.new("+")
      assert token.division? == false
    end

    test "casts number input and sets as value" do
      token = Polones.Token.new("2")
      assert token.value == 2
    end

    test "symbolizes operators and sets as value" do
      token = Polones.Token.new("*")
      assert token.value == :*
    end

    test "sets value to :error for invalid input" do
      token = Polones.Token.new("invalid")
      assert token.value == :error
    end
  end
end
