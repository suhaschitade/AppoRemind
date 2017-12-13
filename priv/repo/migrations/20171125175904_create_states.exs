defmodule Hello.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string
      add :twolettercode, :string
      add :active, :boolean, default: false, null: false
      add :country_id, references(:countries, on_delete: :delete_all)

      timestamps()
    end

    create index(:states, [:country_id])
  end
end
