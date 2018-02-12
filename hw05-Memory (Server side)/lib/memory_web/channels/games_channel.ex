defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
    	game = Memory.GameBackup.load(name) || Game.new()
    	socket = socket
    	|> assign(:game, game)
    	|> assign(:name, name)
      {:ok, %{"join" => name, "game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
 	 def handle_in("tileClick", %{"tileID" => tileID, "letter" => letter}, socket) do
 	  game = Game.client_view_after_click(socket.assigns[:game], tileID, letter)
 	  Memory.GameBackup.save(socket.assigns[:name], game)
 	  socket = assign(socket, :game, game)
  	{:reply, {:ok, %{"game" => game}}, socket}
 	 end


  def handle_in("newGame", %{}, socket) do
    newGame = Game.client_view_for_new_game(socket.assigns[:game])
    Memory.GameBackup.save(socket.assigns[:name], newGame)
    socket = assign(socket, :game, newGame)
    {:reply, {:ok, %{"game" => newGame}}, socket}
  end


  def handle_in("timeout", %{}, socket) do
    game = Game.client_view_after_timeout(socket.assigns[:game])
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{"game" => game}}, socket}
  end
  
  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
