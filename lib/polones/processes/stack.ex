defmodule Polones.Stack do
  use GenServer

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  def init(_opts), do: {:ok, []}

  def push(v), do: GenServer.call(__MODULE__, {:push, v})

  def pop(n), do: GenServer.call(__MODULE__, {:pop, n})

  def result, do: GenServer.call(__MODULE__, :result)

  def clear, do: GenServer.call(__MODULE__, :clear)

  def handle_call({:push, v}, _, stack), do: {:reply, :ok, stack ++ [v]}

  def handle_call({:pop, n}, _, stack) do
    {st, operands} = Enum.split(stack, -n)
    {:reply, operands, st}
  end

  def handle_call(:result, _, stack) do
    res = stack |> List.last |> case do
      nil -> 0.0
      token -> Map.get(token, :value)
    end
    {:reply, res, []}
  end

  def handle_call(:clear, _, _), do: {:reply, :ok, []}
end