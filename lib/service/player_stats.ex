defmodule LetrollBot.DAO.PlayerStats do
  @moduledoc false

  def get_player_stats(player_name) do

    LeTrollBot.Data.PlayerStats.get_player_stats(player_name)

  end

end
