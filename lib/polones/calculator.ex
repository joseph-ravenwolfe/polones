defmodule Polones.Calculator do
  @moduledoc """

  Calculator provides a Reverse Polish Notation interface to perform
  calculations while maintaining all input history.

  Calendar is used indirectly by an Adapter. A custom Adapter will interact
  with the Calculator by calling `push` and `result` functions.

  """

  alias Polones.{Token, Calculation, Stack, History}

  @doc """

  Adds a Token to the stack. Performs universal commands such as `rewind`
  and `fast_forward` when provided.

  """
  def push("rw"), do: History.rewind
  def push("ff"), do: History.fast_forward
  def push("c"), do: History.clear
  def push(expression) do
    expression |> Token.parse |> History.add
  end

  @doc """

  Evaluates all token expressions and yields a calculated result using
  a stack concept. Both Stack and History are stored using GenServers
  to facilitate the possibility of 'mob-calculating' over a network in
  the future.

  """
  def result do
    History.all |> Enum.each(fn token -> process(token) end)
    Stack.result
  end

  def process(%{operator?: true} = operator) do
    Stack.pop(operator.arity)
    |> Calculation.apply(operator)
    |> Token.new
    |> Stack.push
  end

  def process(%{value: :error}), do: :noop
  def process(token), do: token |> Stack.push
end
