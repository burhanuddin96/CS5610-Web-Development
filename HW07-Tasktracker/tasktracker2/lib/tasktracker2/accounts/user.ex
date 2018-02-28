defmodule Tasktracker2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.Accounts.User


  schema "users" do
    field :email, :string
    field :manager, :boolean, default: false
    field :name, :string
    belongs_to :user, User, foreign_key: :manager_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager, :manager_id])
    |> validate_required([:email, :name, :manager])
    |> foreign_key_constraint(:manager_id, message: "User ID does not exist. Please refer users table to get appropriate UserID.")
  end
end
