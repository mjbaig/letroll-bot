defmodule LeTrollBot.Data.PlayerStats do
  @moduledoc false

  require Logger

  def get_player_stats(player_name) do
    player_name
    |> get_player_id()
    |> get_player_stats_by_id()
  end

  defp get_player_id(player_name) do

    {:ok, player_stats} = Nba.Data.find_player(player_name) |> PlayerNameMatch.player_stats_match(player_name)

    player_stats["player_id"]

  end

  defp get_player_stats_by_id(player_id) do

    {:ok, player_stats} = Cachex.get(:letroll_cache, "player_stats")

    if player_stats == nil do

      update_player_stats_by_id(player_id)

    else

      {:ok, player_stats}

    end

  end

  defp update_player_stats_by_id(player_id) do

    Logger.debug("Updating Player Stats")

    Logger.debug("Player ID: #{player_id}")
    player_stats = Nba.Stats.player_info(%{ "PlayerID" => player_id })

    Cachex.put(:letroll_cache, "player_stats#{player_id}}", player_stats)

    {:ok, player_stats}

  end


end
