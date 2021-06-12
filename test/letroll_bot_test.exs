defmodule LetrollBotTest do
  use ExUnit.Case
  doctest LetrollBot

  test "greets the world" do
    assert LetrollBot.hello() == :world
  end
end
