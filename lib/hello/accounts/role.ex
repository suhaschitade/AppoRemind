defmodule Hello.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.Role


  schema "roles" do
    field :active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
