defmodule Tasktracker3Web.TokenController do
  use Tasktracker3Web, :controller
  alias Tasktracker3.Accounts.User

  action_fallback Tasktracker3Web.FallbackController

  def create(conn, %{"email" => email, "password" => pass}) do
    with {:ok, %User{} = user} <- Tasktracker3.Accounts.get_and_auth_user(email, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end