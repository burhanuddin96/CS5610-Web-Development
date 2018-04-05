defmodule Tasktracker3Web.TaskController do
  use Tasktracker3Web, :controller

  alias Tasktracker3.Work
  alias Tasktracker3.Work.Task

  action_fallback Tasktracker3Web.FallbackController

  def index(conn, _params) do
    task = Work.list_task()
    IO.inspect task
    render(conn, "index.json", task: task)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Work.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Work.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"token" => token, "task" => task}) do

    {:ok, user_id} = Phoenix.Token.verify(conn, "auth token", token, max_age: 86400)
    task = Work.get_task(task["id"])

    if task == nil || task.user.id != user_id do
      IO.inspect({:bad_match, task_params["user_id"], user_id})
      raise "hax!"
    end

    with {:ok, %Task{} = task} <- Work.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Work.get_task!(id)
    with {:ok, %Task{}} <- Work.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
