defmodule TripPlanner.JourneysPlace do
  use Ecto.Schema
  import Ecto.Changeset
  alias TripPlanner.Journey
  alias TripPlanner.Place

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "journeys_places" do
    belongs_to :journey, Journey
    belongs_to :place, Place

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(journeys_place, attrs) do
    fields = [:place_id, :journey_id]

    journeys_place
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> unique_constraint(fields)
  end
end
