defmodule TasktrackerWeb.SessionController do
  use TasktrackerWeb, :controller

  def create(conn, %{"email" => email}) do
    user = Tasktracker.Accounts.get_user_by_email(email)
    if user do
    	conn
    	|> put_session(:user_id, user.id)
    	|> put_flash(:info, "Logged in successfully as #{user.name}.")
    	|> redirect(to: "/taskfeed")	
    else
    	conn
    	|> put_flash(:error, "Cannot create a session.")
    	|> redirect(to: page_path(conn, :index))
  	end
 end

  def delete(conn, _params) do
  	conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
