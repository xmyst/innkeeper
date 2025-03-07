defmodule InnkeeperTest do
  use ExUnit.Case
  doctest Innkeeper

  test "greets the world" do
    assert Innkeeper.hello() == :world
  end
end
