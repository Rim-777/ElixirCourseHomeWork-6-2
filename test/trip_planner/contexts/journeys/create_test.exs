defmodule TripPlanner.Contexts.Journeys.CreateTest do
  use TripPlanner.DataCase
  import Ecto.Query, warn: false
  alias TripPlanner.Contexts.Journeys.Create
  alias TripPlanner.Journey
  alias TripPlanner.Place
  alias TripPlanner.JourneysPlace

  describe "create context module" do
    test "create_journey/1 with valid data creates a journey with associations" do
      date = ~N[2024-03-14 19:13:00]
      valencia_name = "Valencia"
      malaga_name = "Malaga"

      valid_attrs = %{
        date: date,
        places: %{
          0 => %{name: valencia_name},
          1 => %{name: malaga_name}
        }
      }

      assert Place |> Repo.all() == []

      assert {:ok, %Journey{id: journey_id, date: ^date, places: places}} =
               Create.create_journey(valid_attrs)

      assert JourneysPlace |> where(journey_id: ^journey_id) |> Repo.aggregate(:count, :id) == 2

      [
        %Place{name: ^valencia_name, id: valencia_id},
        %Place{name: ^malaga_name, id: malaga_id}
      ] =
        places

      assert Place |> Repo.all() == places
      assert where(Place, id: ^valencia_id, name: ^valencia_name) |> Repo.one()
      assert where(Place, id: ^malaga_id, name: ^malaga_name) |> Repo.one()
    end

    test "create_journey/1 with invalid data returns error changeset" do
      invalid_attrs = %{date: nil, places: %{}}

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  places:
                    {"should have at least %{count} item(s)",
                     [count: 1, validation: :length, kind: :min, type: :list]},
                  date: {"can't be blank", [validation: :required]}
                ]
              }} = Create.create_journey(invalid_attrs)
    end
  end
end
