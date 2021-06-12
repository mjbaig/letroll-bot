defmodule LeTrollBot.Controller.PlayerStats do
  @moduledoc false

  require Logger

  @spec get_player_stats(String.t) :: %Nostrum.Struct.Embed{}
  def get_player_stats(player_stats_request) do

    player_name = Regex.replace(~r/Player\ Stats/, player_stats_request, "", global: false) |> String.trim()

    {:ok, player_stats} = LetrollBot.DAO.PlayerStats.get_player_stats(player_name)

    [common_player_info|_] = player_stats["CommonPlayerInfo"]

    [player_headline_stats|_] = player_stats["PlayerHeadlineStats"]

    import Nostrum.Struct.Embed

    %Nostrum.Struct.Embed{}
      |> put_title(player_headline_stats["PLAYER_NAME"])
      |> put_description("Stats for #{player_headline_stats["TimeFrame"]}
         Points Per Game: #{player_headline_stats["PTS"]}
         Assists Per Game: #{player_headline_stats["AST"]}
         Rebounds Per Game: #{player_headline_stats["REB"]}
      ")

  end


end
