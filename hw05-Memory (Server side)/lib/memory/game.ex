defmodule Memory.Game do
	
	def new do
		%{
			letter_array: ["B", "C", "H", "F", "A", "C", "E", "D", "B", "E", "D", "F", "G", "H", "A", "G"],
			mem_values: [],
			tile_ids: [],
			tileFlips: 0,
			moves: 0,
		}
	end

	def client_view_after_click(game, tileID, letter) do
		{mem_values, tile_ids, tileFlips, moves} = tile_clicked(game, tileID, letter)

		%{
			letter_array: game.letter_array,
			mem_values: mem_values,
			tile_ids: tile_ids,
			tileFlips: tileFlips,
			moves: moves,
		}
	end

	def client_view_after_timeout(game) do
		{mem_values, tile_ids} = wrong_guess(game)

		%{
			letter_array: game.letter_array,
			mem_values: mem_values,
			tile_ids: tile_ids,
			tileFlips: game.tileFlips,
			moves: game.moves,
		}
	end

	def client_view_for_new_game(game) do
		%{
			letter_array: Enum.shuffle(game.letter_array),
			mem_values: [],
			tile_ids: [],
			tileFlips: 0,
			moves: 0,
		}
	end

	def tile_clicked(game, tileID, letter) do
		cond do
			(length(game.mem_values) == 0) ->
				first_guess(game, tileID, letter)

			(length(game.mem_values) == 1) ->
				second_guess(game, tileID, letter)

			true ->
				{game.mem_values, game.tile_ids, game.tileFlips, game.moves}
		end
	end

	def	first_guess(game, tileID, letter) do
		tile_ids = List.insert_at(game.tile_ids, -1, tileID)
		mem_values = List.insert_at(game.mem_values, -1, letter)
		{mem_values, tile_ids, game.tileFlips, game.moves+1}
	end
	
	def second_guess(game, tileID, letter) do
		tile_ids = List.insert_at(game.tile_ids, -1, tileID)
		if(Enum.member?(game.mem_values, letter)) do
			{[], tile_ids, game.tileFlips+2, game.moves+1}
		else
			{[], tile_ids, game.tileFlips, game.moves+1}
		end
	end

	def wrong_guess(game) do
		tile_ids = List.delete_at(game.tile_ids, -1)
		tile_ids = List.delete_at(tile_ids, -1)
		{[], tile_ids}	
	end


end