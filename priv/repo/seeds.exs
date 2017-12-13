# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hello.Repo.insert!(%Hello.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Hello.Repo.delete_all Hello.Accounts.User

Hello.Accounts.User.changeset(%Hello.Accounts.User{}, %{first_name: "Test User", username: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> Hello.Repo.insert!