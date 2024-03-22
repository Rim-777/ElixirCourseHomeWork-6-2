defmodule TripPlanner.JourneysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Context.Journeys` context.
  """

  @doc """
  Generate a journey.
  """
  def journey_fixture(attrs \\ %{}) do
    {:ok, journey} =
      attrs
      |> Enum.into(%{
        date: ~N[2024-03-14 19:13:00],
        places: attrs.places
      })
      |> TripPlanner.Contexts.Journeys.Create.create_journey()

    journey
  end
end
