defmodule Polones.History do
  use GenServer

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  def init(_opts), do: {:ok, %{history: [], recall: []}}

  def all, do: GenServer.call(__MODULE__, :all)

  def add(tokens), do: GenServer.call(__MODULE__, {:add, tokens})

  def clear, do: GenServer.call(__MODULE__, :clear)

  def rewind, do: GenServer.call(__MODULE__, :rewind)

  def fast_forward, do: GenServer.call(__MODULE__, :fast_forward)

  def handle_call(:all, _, state), do: {:reply, state.history, state}

  def handle_call({:add, tokens}, _, %{history: history}) do
    {:reply, :ok, %{history: history ++ tokens, recall: []}}
  end

  def handle_call(:clear, _, _),
    do: {:reply, :ok, %{history: [], recall: []}}

  def handle_call(:rewind, _, %{history: []} = state), do: {:reply, :noop, state}

  def handle_call(:rewind, _, %{history: history, recall: recall}) do
    {history, last} = Enum.split(history, -1)
    {:reply, :ok, %{history: history, recall: last ++ recall}}
  end

  def handle_call(:fast_forward, _, %{recall: []} = state), do: {:reply, :noop, state}

  def handle_call(:fast_forward, _, %{history: history, recall: recall}) do
    {first, recall} = Enum.split(recall, 1)
    {:reply, :ok, %{history: history ++ first, recall: recall}}
  end
end