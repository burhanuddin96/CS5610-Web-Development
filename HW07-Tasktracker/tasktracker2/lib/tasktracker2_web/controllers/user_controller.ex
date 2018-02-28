defmodule Tasktracker2Web.UserController do
  use Tasktracker2Web, :controller

  alias Tasktracker2.Accounts
  alias Tasktracker2.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    manager_list = Accounts.get_manager_id_list() 
    render(conn, "new.html", changeset: changeset, man_list: manager_list)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully. Please Log In to continue.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  def managers(conn, _params) do
    users = Accounts.list_managers()
    render(conn, "managers.html", users: users)
  end

  def underlings(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Accounts.get_user!(user_id)
    users = Accounts.list_underlings(user_id)
    render(conn, "underlings.html", users: users, manager: user)
  end

  def homepage(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Accounts.get_user!(user_id)
    if user.manager do
      underlings = Accounts.list_underlings(user_id)
      tasks = Tasktracker2.Work.list_tasks();
      render(conn, "homepage.html", user: user, underlings: underlings, tasks: tasks) 
    else
      underlings = Accounts.list_underlings(user.manager_id)
      tasks = Tasktracker2.Work.list_tasks_current_user(user_id)
      tblocks = Tasktracker2.Work.list_half_timeblocks()
      render(conn, "homepage.html", user: user, underlings: underlings, tasks: tasks, timeblocks: tblocks)  
    end
  end
end
