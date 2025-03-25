defmodule Innkeeper.Keeper do
  @moduledoc false

  use GenServer

  @spec start_link(options :: Keyword.t()) :: GenServer.on_start()
  def start_link(options \\ []) when is_list(options) do
    {name, _} = Keyword.pop(options, :name, __MODULE__)
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  @impl true
  def init(_) do
    for {name, options} <- validate!(all_tables()) do
      :ets.new(name, [:public, :named_table | options])
    end

    {:ok, :ok}
  end

  defp all_tables() do
    :code.all_available()
    |> Enum.map(fn {mod, _file, _load?} -> List.to_atom(mod) end)
    |> Enum.filter(fn mod -> function_exported?(mod, :__ets_tables__, 0) end)
    |> Enum.flat_map(fn mod -> mod.__ets_tables__() end)
  end

  defp validate!(tables) do
    multi_definitions =
      tables
      |> Enum.group_by(
        fn {name, _loc, _opts} -> name end,
        fn {_name, {file, line}, _opts} -> "#{file}:#{line}" end
      )
      # match?([_, _ | _], locs) is a much faster version of length(locs) > 1.
      |> Enum.filter(fn {_name, locs} -> match?([_, _ | _], locs) end)

    case multi_definitions do
      [{name, locations} | _] ->
        raise ArgumentError,
          message:
            "Tables must be defined exactly once, table #{name} is defined at:\n\n" <>
              Enum.join(locations, "\n")

      [] ->
        Enum.map(tables, fn {name, _loc, opts} -> {name, opts} end)
    end
  end
end
