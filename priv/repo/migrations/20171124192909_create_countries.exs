defmodule Hello.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string
      add :twolettercode, :string
      add :threelettercode, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
