defmodule Tasktracker3.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "task" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :name, :string
    field :timeHRS, :integer
    field :timeMIN, :integer
    belongs_to :user, Tasktracker3.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :desc, :timeHRS, :timeMIN, :completed, :user_id])
    |> validate_required([:name, :desc, :timeHRS, :timeMIN, :completed, :user_id])
    |> foreign_key_constraint(:user_id, message: "User does not exist.")
  end
end
