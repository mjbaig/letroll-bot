defmodule LeTrollConsumer do
  @moduledoc false

  use Nostrum.Consumer

  alias Nostrum.Api

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, ws_state}) do

    Logger.info("MSG: " <> msg.content)
    Logger.info(msg.channel_id)

    cond do
      String.contains?(msg.content, "<:Kanna:352957310160601089>") ->
        Api.create_message(msg.channel_id, "<:letroll:263514241078657026>")

      String.contains?(msg.content, "<@263507712699138050>") ->
        Api.create_message(msg.channel_id, "<:letroll:263514241078657026>")

      String.contains?(msg.content, "Player Stats") ->
        embed = LeTrollBot.Controller.PlayerStats.get_player_stats(msg.content)
        Logger.debug("Creating Message")
        Api.create_message(msg.channel_id, embed: embed)

      String.contains?(msg.content, "Team Standings") ->
        team_name = Regex.replace(~r/Team\ Standings/, msg.content, "", global: false) |> String.trim()
        Api.create_message(msg.channel_id, LeTrollBot.Service.Scoreboard.get_team_metadata(team_name) |> Poison.encode!)

      true ->
        :ignore

    end

  end


  def handle_event(_) do
    :poop
  end

end
