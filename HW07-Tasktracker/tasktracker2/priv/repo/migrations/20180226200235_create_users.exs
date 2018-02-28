defmodule Tasktracker2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :manager, :boolean, default: false, null: false
      add :manager_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    execute("CREATE INDEX parital_index ON users(manager_id) WHERE manager_id is not null")
  end
end
