defmodule Tasktracker2Web.TaskController do
  use Tasktracker2Web, :controller

  alias Tasktracker2.Work
  alias Tasktracker2.Work.Task

  def index(conn, _params) do
    tasks = Work.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Work.change_task(%Task{})
    user_id = get_session(conn, :user_id)
    u_list = Tasktracker2.Accounts.get_underlings_id_list(user_id);
    render(conn, "new.html", changeset: changeset, u_list: u_list)
  end

  def create(conn, %{"task" => task_params}) do
    case Work.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: user_path(conn, :homepage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timeblocks = Work.list_task_timeblocks(id)
    task = Work.get_task!(id)
    render(conn, "show.html", task: task, timeblocks: timeblocks)
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_session(conn, :user_id)
    user = Tasktracker2.Accounts.get_user!(user_id)
    u_list = Tasktracker2.Accounts.get_underlings_id_list(user_id);
    task = Work.get_task!(id)
    changeset = Work.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, u_list: u_list, user: user)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Work.get_task!(id)

    case Work.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: user_path(conn, :homepage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Work.get_task!(id)
    {:ok, _task} = Work.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: user_path(conn, :homepage))
  end
end
