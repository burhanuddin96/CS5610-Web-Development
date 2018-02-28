defmodule Tasktracker2.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.Work.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :name, :string
    belongs_to :user, Tasktracker2.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :desc, :completed, :user_id])
    |> validate_required([:name, :desc, :completed, :user_id])
    |> foreign_key_constraint(:user_id, message: "User ID does not exist. Please refer users table to get appropriate UserID.")
  end
end
