defmodule Hello.UserCompanies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.UserCompanies.Company


  schema "companies" do
    field :active, :boolean, default: false
    field :address1, :string
    field :address2, :string
    field :city, :string
    field :logo, :string
    field :name, :string
    field :weburl, :string
    field :zipcode, :string
    field :state_id, :id
    field :country_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :logo, :weburl, :address1, :address2, :zipcode, :city, :active, :country_id, :state_id])
    |> validate_required([:name, :logo, :weburl, :address1, :address2, :zipcode, :city, :active])
  end
end
