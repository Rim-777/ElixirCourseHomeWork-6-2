defmodule TripPlanner.Contexts.Journeys.GetTest do
  use TripPlanner.DataCase
  import Ecto.Query, warn: false
  import TripPlanner.JourneysFixtures

  alias TripPlanner.Contexts.Journeys.Get
  alias TripPlanner.Journey
  alias TripPlanner.Place

  describe "get context module" do
    test "get_by_place_names/1 finds the journey by places inclusion" do
      valencia_name = "Valencia"
      malaga_name = "Malaga"
      amsterdam_name = "Amsterdam"

      places_spain = %{
        0 => %{name: valencia_name},
        1 => %{name: malaga_name}
      }

      places_netherlands = %{
        0 => %{name: amsterdam_name}
      }

      spain_journey =
        %Journey{places: [%Place{name: ^valencia_name}, %Place{name: ^malaga_name}]} =
        journey_fixture(%{places: places_spain})

      netherlands_journey =
        %Journey{places: [%Place{name: ^amsterdam_name}]} =
        journey_fixture(%{places: places_netherlands})

      assert Get.get_by_place_names([valencia_name]) == [spain_journey]
      assert Get.get_by_place_names(malaga_name) == [spain_journey]
      assert Get.get_by_place_names([amsterdam_name, "ufo"]) == [netherlands_journey]

      assert Get.get_by_place_names([valencia_name, amsterdam_name]) == [
               spain_journey,
               netherlands_journey
             ]

      assert Get.get_by_place_names(["Barcelona"]) == []
    end
  end
end
