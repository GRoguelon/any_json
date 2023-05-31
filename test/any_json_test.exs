defmodule AnyJsonTest do
  use ExUnit.Case
  doctest AnyJson

  test "greets the world" do
    assert AnyJson.hello() == :world
  end
end
