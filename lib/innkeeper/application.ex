defmodule Innkeeper.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [Innkeeper.Keeper]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
