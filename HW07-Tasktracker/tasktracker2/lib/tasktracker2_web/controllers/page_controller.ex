defmodule Tasktracker2Web.PageController do
  use Tasktracker2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
