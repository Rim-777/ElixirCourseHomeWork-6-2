defmodule TripPlanner.Contexts.Journeys.DeleteTest do
  use TripPlanner.DataCase
  import Ecto.Query, warn: false
  import TripPlanner.JourneysFixtures

  alias TripPlanner.Contexts.Journeys.Delete
  alias TripPlanner.Contexts.Journeys.Get
  alias TripPlanner.Journey
  alias TripPlanner.Place
  alias TripPlanner.JourneysPlace

  describe "delete context module" do
    test "delete_journey/1 deletes the journey with intermediate associations" do
      valencia_name = "Valencia"
      malaga_name = "Malaga"

      places = %{
        0 => %{name: valencia_name},
        1 => %{name: malaga_name}
      }

      journey = %Journey{id: journey_id} = journey_fixture(%{places: places})
      assert {:ok, %Journey{id: ^journey_id}} = Delete.delete_journey(journey)
      assert_raise Ecto.NoResultsError, fn -> Get.get_journey!(journey_id) end

      assert JourneysPlace |> where(journey_id: ^journey_id) |> Repo.aggregate(:count, :id) == 0

      assert %Place{name: ^valencia_name} = where(Place, name: ^valencia_name) |> Repo.one()
      assert %Place{name: ^malaga_name} = where(Place, name: ^malaga_name) |> Repo.one()
    end
  end
end
