defmodule Polones.Token do
  @moduledoc """

  Tokens can be used as an interface between a Calculator and string
  expressions. Strings can be parsed into multiple tokens and provide
  conveniences like the ability to distinguish values from operators.

  """
  defstruct [:operator?, :division?, :arity, :value]

  def parse(expression) do
    expression |> String.split(" ") |> Enum.map(&new(&1))
  end

  def new(exp) do
    %Polones.Token{
      operator?: operator?(exp),
      division?: division?(exp),
      arity: arity(exp),
      value: value(exp)
    }
  end

  defp operator?(value), do: maths() |> Enum.member?(value)

  defp division?(value), do: value == "/"

  defp maths, do: ["+", "-", "*", "/"]

  # Returns the arity of the math function given. Currently we are
  # only supporting basic arithmetic operators provided by the Elixir
  # Kernel. Unfortunately, it is not as easy to pull all possible
  # Math functions together into a single dynamic check via Elixir
  # as it is in other programming languages. (it is trivial in Ruby)
  # For this reason, it is hardcoded to 2.
  #
  # Ideally, this could be expanded in the future by storing the
  # function heads of many different math functions from different
  # modules and allowing the arity to be custom defined per function.
  # For example, sqrt only has an arity of 1, Pi has an arity of 0,
  # and greatest common divisor has an arity of 2.
  #
  defp arity(_value), do: 2

  defp value(exp), do: operator?(exp) |> value(exp)
  defp value(true, exp), do: String.to_atom(exp)
  defp value(false, exp), do: operand_value(exp)

  defp operand_value(val) when is_binary(val), do: Float.parse(val) |> operand_value()
  defp operand_value(:error), do: :error
  defp operand_value({val, _}), do: val
  defp operand_value(val), do: val
end