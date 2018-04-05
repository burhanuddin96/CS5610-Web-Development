defmodule Tasktracker3.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :name, :string, null: false
      add :desc, :string, null: false
      add :timeHRS, :integer, null: false, default: 0
      add :timeMIN, :integer, null: false, default: 0
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:task, [:user_id])
  end
end
