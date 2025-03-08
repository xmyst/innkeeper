defmodule Innkeeper.KeeperTest do
  use ExUnit.Case
  import TestMacroTools

  @keeper_mod_spec {Innkeeper.Keeper, name: __MODULE__}

  doctest Innkeeper.Keeper

  test "no tables" do
    compiler_options ignore_module_conflict: true do
      defmodule M do
        use Innkeeper
      end
    end

    start_link_supervised!(@keeper_mod_spec)
  end

  test "single table" do
    compiler_options ignore_module_conflict: true do
      defmodule M do
        use Innkeeper
        ets_table(__MODULE__)
      end
    end

    start_link_supervised!(@keeper_mod_spec)

    assert M in :ets.all()
  end

  test "duplicate table" do
    compiler_options ignore_module_conflict: true do
      defmodule M do
        use Innkeeper

        ets_table(__MODULE__)
        ets_table(__MODULE__)
      end
    end

    %{message: message} =
      assert_raise RuntimeError, fn ->
        start_link_supervised!(@keeper_mod_spec)
      end

    assert String.contains?(message, "** (ArgumentError)")
  end
end
