defmodule Hello.Common.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Common.Country


  schema "countries" do
    field :active, :boolean, default: false
    field :name, :string
    field :threelettercode, :string
    field :twolettercode, :string

    timestamps()
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:name, :twolettercode, :threelettercode, :active])
    |> validate_required([:name, :twolettercode, :threelettercode, :active])
  end
end
