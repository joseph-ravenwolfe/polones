defmodule Mix.Tasks.Calculator do
  use Mix.Task

  @shortdoc "Start an instance of Polones"

  def run(_) do
    {:ok, _pid} = Polones.History.start_link([])
    {:ok, _pid} = Polones.Stack.start_link([])
    Polones.ConsoleAdapter.start
  end
end
