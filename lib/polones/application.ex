defmodule Polones.Application do
  use Application

  def start(_type, _args) do
    children = [Polones.Stack, Polones.History]
    opts = [strategy: :one_for_one, name: Polones.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
