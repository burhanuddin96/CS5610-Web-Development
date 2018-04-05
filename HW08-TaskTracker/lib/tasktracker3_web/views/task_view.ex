defmodule Tasktracker3Web.TaskView do
  use Tasktracker3Web, :view
  alias Tasktracker3Web.TaskView
  alias Tasktracker3Web.UserView

  def render("index.json", %{task: task}) do
    %{data: render_many(task, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      name: task.name,
      desc: task.desc,
      timeHRS: task.timeHRS,
      timeMIN: task.timeMIN,
      completed: task.completed,
      user: render_one(task.user, UserView, "user.json")
    }
  end
end
