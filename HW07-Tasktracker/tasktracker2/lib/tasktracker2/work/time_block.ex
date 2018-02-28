defmodule Tasktracker2.Work.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.Work.TimeBlock
  alias Tasktracker2.Work.Task


  schema "timeblocks" do
    field :etime, :string
    field :stime, :string
    belongs_to :task, Task
    #field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:stime, :etime, :task_id])
    |> validate_required([:stime])
  end
end
