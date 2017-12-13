defmodule Hello.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :crypted_password, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
