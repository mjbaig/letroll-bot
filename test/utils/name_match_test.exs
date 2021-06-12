defmodule PlayerNameMatchTest do
  @moduledoc false

  use ExUnit.Case
  doctest PlayerNameMatch

  test "returns the correct stats" do

    player_1 = %{"first_name" => "Steph", "last_name" => "Curry", "correct" => true}

    player_2 = %{"first_name" => "Seth", "last_name" => "Curry", "correct" => false}

    players_stats = [player_1, player_2]

    {code, player_stats} = PlayerNameMatch.player_stats_match(players_stats, "Steph Curry")

    assert(code == :ok)

    assert(player_stats["correct"])

  end

  test "returns error due to empty list" do

    players_stats = []

    {code, result} = PlayerNameMatch.player_stats_match(players_stats, "Steph Curry")

    assert(code == :error)

  end

  test "returns error due to nil list" do

    players_stats = nil

    {code, result} = PlayerNameMatch.player_stats_match(players_stats, "Steph Curry")

    assert(code == :error)

  end

  test "all maps dont have required keys" do

    player_1 = %{"first_name" => "Steph", "last_name" => "Curry", "correct" => true}

    player_2 = %{"last_name" => "Curry", "correct" => false}

    players_stats = [player_1, player_2]

    {code, result} = PlayerNameMatch.player_stats_match(players_stats, "Steph Curry")

    assert(code == :error)

  end

end
