defmodule Polones.StringAdapter do
  @moduledoc """

  The String Adapter acts as a String interface to the Polones calculator
  using a custom sigil. It provides push functionality to the calculator and
  returns calculated results using an interface similar to defining a Regex
  in Elixir, but with ~a instead of ~r. e.g. ~a/2 2 +/

  Passing no expression returns the result. Example usage:

      > ~a/2 2 +/
      4.0
      > ~a//
      4.0

  In order to use the StringAdapter, you must `import Polones.StringAdapter`

  """

  def sigil_a(expression, []), do: evaluate(expression)
  def sigil_a("", []), do: result()

  def evaluate(expression, calc \\ Polones.Calculator) do
    calc.push(expression)
    calc.result
  end

  def result(calc \\ Polones.Calculator) do
    calc.result
  end
end
