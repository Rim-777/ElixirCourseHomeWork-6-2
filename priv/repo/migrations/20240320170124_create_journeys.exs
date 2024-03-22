defmodule TripPlanner.Repo.Migrations.CreateJourneys do
  use Ecto.Migration

  def change do
    create table(:journeys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
