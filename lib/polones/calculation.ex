defmodule Polones.Calculation do
  @moduledoc """

  Calculation stores mathematical expressions and yields the result of those
  expressions when commanded.

  """

  defstruct [:target, :operator, :operands]

  @doc """

  Performs a calculation based on the supplied operators and operands then
  yields the result.

  """
  def apply(values, operator) do
    operands = operands_for(values)
    if operator.division? && List.last(operands) == 0 do
      IO.puts(:stderr, "Can't divide by zero. Consider rewinding.")
      0
    else
      apply(Kernel, operator.value, operands)
    end
  end

  defp operands_for(operands) do
    Enum.map(operands, fn op -> op.value end)
  end
end
