defmodule Hello.Accounts.User do
  use Ecto.Schema
  use Coherence.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User


  schema "users" do
    field :active, :boolean, default: false
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    coherence_schema()
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :active] ++ coherence_fields())
    |> validate_required([:first_name, :last_name, :username, :active])
    |> validate_format(:username, ~r/@/)
    |> validate_coherence(attrs)
    |> unique_constraint(:username)   
  end

  def changeset(%User{}= user, attrs, :password) do
    user
      |> cast(attrs, ~w(password password_confirmation reset_password_token reset_password_sent_at))
      |> validate_coherence_password_reset(attrs)
  end
end
