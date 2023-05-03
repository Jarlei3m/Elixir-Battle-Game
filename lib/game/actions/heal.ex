defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @heal_random 10..35

  def heal_life(player) do
    heal = calculate_heal()

    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(heal)
    |> update_player_life(player, heal)
  end

  defp calculate_heal(), do: Enum.random(@heal_random)

  defp calculate_total_life(life, heal) when life + heal > 100, do: 100
  defp calculate_total_life(life, heal), do: life + heal

  defp update_player_life(healed_life, player, heal) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, healed_life)
    |> update_game(player, heal)
  end

  defp update_game(healed_player, player, heal) do
    Game.info()
    |> Map.put(player, healed_player)
    |> Game.update()

    Status.print_move_message(player, :heal, heal)
  end
end
