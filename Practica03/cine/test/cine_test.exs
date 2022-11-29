defmodule CineTest do
  use ExUnit.Case
  doctest Cine

  test "greets the world" do
    assert Cine.hello() == :world
  end
end
