defmodule Tasktracker2Web.TimeBlockView do
  use Tasktracker2Web, :view
  alias Tasktracker2Web.TimeBlockView

  def render("index.json", %{timeblocks: timeblocks}) do
    %{data: render_many(timeblocks, TimeBlockView, "time_block.json")}
  end

  def render("show.json", %{time_block: time_block}) do
    %{data: render_one(time_block, TimeBlockView, "time_block.json")}
  end

  def render("time_block.json", %{time_block: time_block}) do
    %{id: time_block.id,
      stime: time_block.stime,
      etime: time_block.etime}
  end
end
