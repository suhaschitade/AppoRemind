defmodule Hello.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
