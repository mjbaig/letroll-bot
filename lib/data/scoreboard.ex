defmodule LeTrollBot.Data.Scoreboard do
  @moduledoc false

  require Logger

  def get_scoreboard() do

    {:ok, scoreboard_data} = Cachex.get(:letroll_cache, "scoreboard")

    if scoreboard_data == nil do

      update_scoreboard()

    else

      Logger.debug("Using cached scoreboard data")

      {:ok, scoreboard_data}

    end

  end

  def update_scoreboard() do

    Logger.debug("Updating Scoreboard Cache")

    {:ok, date_string} = Timex.format(Timex.now("America/Chicago"), "%F", :strftime)

    date_string = String.replace(date_string, "-", "/", [])

    scoreboard_data = Nba.Stats.scoreboard(%{"gameDate" => date_string})

    Cachex.put(:letroll_cache, "scoreboard", scoreboard_data)

    {:ok, scoreboard_data}

  end

end
