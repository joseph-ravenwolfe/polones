defmodule Polones do
  @moduledoc """

  Polones provides an Elixir interface to configure and spawn calculator
  sessions in Reverse Polish Notation.

  """

  alias Polones.ConsoleAdapter

  @doc """
  Start a new session with Polones for a given Adapter. Defaults to the
  Console adapter.
  """
  def start_session(adapter \\ ConsoleAdapter) do
    adapter.start
  end

  def main(args \\ []) do
    start_session()
  end
end
