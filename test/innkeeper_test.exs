defmodule InnkeeperTest do
  use ExUnit.Case
  import TestHelper

  doctest Innkeeper

  test "no declarations" do
    compiler_options ignore_module_conflict: true do
      defmodule M do
        use Innkeeper
      end
    end

    assert [] = M.__ets_tables__()
  end

  describe "declaration" do
    test "w/o options" do
      name = :test
      file = __ENV__.file

      compiler_options ignore_module_conflict: true do
        defmodule M do
          use Innkeeper
          ets_table(name)
        end
      end

      assert [{^name, {^file, _}, []}] = M.__ets_tables__()
    end

    test "w/ options" do
      name = :test
      file = __ENV__.file
      options = [read_concurrency: true, write_concurrency: :auto]

      compiler_options ignore_module_conflict: true do
        defmodule M do
          use Innkeeper
          ets_table(name, options)
        end
      end

      assert [{^name, {^file, _}, ^options}] = M.__ets_tables__()
    end
  end
end
