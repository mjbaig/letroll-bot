defmodule PlayerNameMatch do
  @moduledoc false

  @spec player_stats_match(list(map()), String.t) :: map()
  def player_stats_match(players_stats, player_name) do

    player_stats = %{"first_name" => "", "last_name" => ""}

    is_valid = player_stats_list_is_valid(players_stats)

    cond do

      !is_valid -> {:error, nil}

      player_name == nil -> {:error, nil}

      player_name == "" -> {:error, nil}

      true -> players_stats_match_helper(players_stats, player_name, player_stats)

    end

  end

  @spec players_stats_match_helper(list(map()), String.t, map()) :: map()
  defp players_stats_match_helper(players_stats, player_name, player_stats) do

    [head|tail] = players_stats

    head_distance = "#{head["first_name"]} #{head["last_name"]}" |> get_string_distance(player_name)

    current_distance = "#{player_stats["first_name"]} #{player_stats["last_name"]}" |> get_string_distance(player_name)

    cond do

      head_distance > current_distance && tail == [] -> {:ok, head}

      head_distance <= current_distance && tail == [] -> {:ok, player_stats}

      head_distance > current_distance -> players_stats_match_helper(tail, player_name, head)

      head_distance <= current_distance -> players_stats_match_helper(tail,player_name, player_stats)

    end

  end

  @spec player_stats_list_is_valid(list(map())) :: boolean
  defp player_stats_list_is_valid(players_stats) do

    cond do

      players_stats == [] -> false

      players_stats == nil -> false

      true ->  Enum.all?(
                 players_stats,
                 fn player_stats -> ["first_name", "last_name"] |> Enum.all?(&(Map.has_key?(player_stats, &1))) end
               )
    end

  end


  @spec get_string_distance(String.t, String.t) :: number
  defp get_string_distance(string_1, string_2) do
    String.jaro_distance(String.upcase(string_1), String.upcase(string_2))
  end

end
