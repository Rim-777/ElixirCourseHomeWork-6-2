defmodule TripPlanner.Journey do
  use Ecto.Schema
  import Ecto.Changeset
  alias TripPlanner.JourneysPlace
  alias TripPlanner.Place

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "journeys" do
    field :date, :naive_datetime

    many_to_many :places, Place, join_through: JourneysPlace

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(journey, attrs) do
    journey
    |> cast(attrs, [:date])
    |> put_assoc(:places, attrs.places, required: true)
    |> validate_required([:date])
    |> validate_length(:places, min: 1)
  end
end
