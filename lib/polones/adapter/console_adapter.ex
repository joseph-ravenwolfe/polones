defmodule Polones.ConsoleAdapter do
  @moduledoc """

  The Console Adapter acts as a Console interface to the Polones calculator.
  It utilizes STDIN and STDOUT to parse input and provides helpers such
  as the ability to quit.

  Note: Elixir doesn't like EOF/EOL inputs, so unlike many other programming
  languages, it is fairly difficult to write code to detect and handle these
  cases.

  """

  def start(calc \\ Polones.Calculator) do
    expression = IO.gets("> ") |> String.trim |> String.downcase
    evaluate(calc, expression)
  end

  def evaluate(_, "q"), do: exit()
  def evaluate(_, "quit"), do: exit()
  def evaluate(_, "exit"), do: exit()
  def evaluate(_, ""), do: start()

  def evaluate(calc, expression) do
    calc.push(expression)
    calc.result |> IO.puts
    start()
  end

  def exit(msg \\ "Bye!") do
    IO.puts(msg)
    System.halt
  end
end
