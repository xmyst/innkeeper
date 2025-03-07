defmodule Innkeeper do
  @moduledoc """
  Declarative ETS tables with a touch of magic.
  """

  @doc """
  Declares an ETS table.

  For the options, see `:ets.new/2`.
  """
  defmacro ets_table(name, options \\ []) do
    quote do
      @innkeeper_ets_tables {unquote(name), {__ENV__.file, __ENV__.line}, unquote(options)}
    end
  end

  @doc false
  defmacro __using__(_) do
    quote do
      import Innkeeper, only: [ets_table: 1, ets_table: 2]

      @before_compile Innkeeper

      Module.register_attribute(__MODULE__, :innkeeper_ets_tables, accumulate: true)
    end
  end

  @doc false
  defmacro __before_compile__(_) do
    quote do
      def __ets_tables__() do
        @innkeeper_ets_tables
      end
    end
  end
end
