defmodule Hello.Accounts.User_Attribute do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User_Attribute


  schema "user_attributes" do
    field :active, :boolean, default: true
    field :user_id, :id
    field :company_id, :id
    field :role_id, :id

    timestamps()
  end

  @doc false
  def changeset(%User_Attribute{} = user_attribute,attr) do
    user_attribute
    |> cast(attr, [:active, :user_id, :company_id, :role_id])
    |> validate_required([:active, :user_id, :company_id, :role_id])
  end
end
