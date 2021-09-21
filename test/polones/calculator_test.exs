defmodule CalculatorTest do
  use ExUnit.Case
  doctest Polones.Calculator

  alias Polones.{Calculator, History}

  describe "Calculator.push" do
    test "adds a token to History" do
      History.clear
      Calculator.push("2")
      assert History.all |> List.last |> Map.get(:value) == 2
    end
  end
end
