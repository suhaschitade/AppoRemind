defmodule Hello.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :logo, :string
      add :weburl, :string
      add :address1, :string
      add :address2, :string
      add :zipcode, :string
      add :city, :string
      add :active, :boolean, default: false, null: false
      add :state_id, references(:states, on_delete: :nothing)
      add :country_id, references(:countries, on_delete: :nothing)

      timestamps()
    end

    create index(:companies, [:state_id])
    create index(:companies, [:country_id])
  end
end
