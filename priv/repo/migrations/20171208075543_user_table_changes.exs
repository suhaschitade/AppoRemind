defmodule Hello.Repo.Migrations.UserTableChanges do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :crypted_password
    end
  end
end
