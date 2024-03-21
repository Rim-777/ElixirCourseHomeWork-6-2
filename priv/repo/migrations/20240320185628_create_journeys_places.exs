defmodule TripPlanner.Repo.Migrations.CreateJourneysPlaces do
  use Ecto.Migration

  def change do
    create table(:journeys_places, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :journey_id, references(:journeys, on_delete: :delete_all, type: :binary_id)
      add :place_id, references(:places, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:journeys_places, [:journey_id, :place_id])
  end
end
