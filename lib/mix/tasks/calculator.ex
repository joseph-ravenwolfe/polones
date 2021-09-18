defmodule Mix.Tasks.Calculator do
  use Mix.Task

  @shortdoc "Start an instance of Polones"

  def run(_) do
    Polones.start()
  end
end