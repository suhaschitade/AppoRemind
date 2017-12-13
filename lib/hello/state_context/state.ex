defmodule Hello.StateContext.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.StateContext.State


  schema "states" do
    field :active, :boolean, default: false
    field :name, :string
    field :twolettercode, :string
    field :country_id, :id

    timestamps()
  end

  @doc false
  def changeset(%State{} = state, attrs) do
    state
    |> cast(attrs, [:name, :twolettercode, :active, :country_id])
    |> validate_required([:name, :twolettercode, :active, :country_id])
  end
end
