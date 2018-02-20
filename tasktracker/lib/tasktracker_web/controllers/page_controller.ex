defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def taskfeed(conn, _params) do
  	user_id = get_session(conn, :user_id)
  	tasks = Tasktracker.Work.list_tasks_current_user(user_id)
    render conn, "feed.html",tasks: tasks
  end
end
