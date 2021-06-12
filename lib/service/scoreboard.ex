defmodule LeTrollBot.Service.Scoreboard do
  @moduledoc false

#  https://github.com/seemethere/nba_py/wiki/stats.nba.com-Endpoint-Documentation


  @spec get_team_metadata(String.t) :: []
  def get_team_metadata(team_name) do

    {:ok, scoreboard_data} = LeTrollBot.Data.Scoreboard.get_scoreboard()

    western_conference = scoreboard_data["WestConfStandingsByDay"]

    Enum.filter(western_conference, fn (team_object) -> String.upcase(team_object["TEAM"]) == String.upcase(team_name) end)

  end

  @spec get_game_score(String.t) :: any
  def get_game_score(team_name) do



  end


end
