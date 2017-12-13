defmodule Hello.Repo.Migrations.CreateUserAttribute do
  use Ecto.Migration

  def change do
    create table(:user_attributes) do
      add :active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:user_attribute, [:user_id])
    create index(:user_attribute, [:company_id])
    create index(:user_attribute, [:role_id])
  end
end
