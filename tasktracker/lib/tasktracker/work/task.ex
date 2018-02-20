defmodule Tasktracker.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Work.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :name, :string
    belongs_to :user, Tasktracker.Accounts.User
    field :timeHRS, :integer, default: 0
    field :timeMIN, :integer, default: 0
    #field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :desc, :timeHRS, :timeMIN, :completed, :user_id])
    |> validate_required([:name, :desc, :timeHRS, :timeMIN, :completed, :user_id])
    |> foreign_key_constraint(:user_id, message: "User ID does not exist. Please refer users table to get appropriate UserID.")
  end
end
