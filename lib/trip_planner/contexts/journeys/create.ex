defmodule TripPlanner.Contexts.Journeys.Create do
  @moduledoc """
  The Journeys.Create context.
  """

  import Ecto.Query, warn: false
  alias TripPlanner.Repo
  alias TripPlanner.Journey
  alias TripPlanner.Place

  @doc """
  Creates a journey with associated places.

  ## Examples

     iex>attrs = %{
        date: ~N[2024-03-14 19:13:00],
        places: %{
          0 => %{name: "Valencia"},
          1 => %{name: "Malaga"}
        }
      }

      iex> create_journey(attrs)
      {:ok, %Journey{date: ~N[2024-03-14 19:13:00],
                     places: [%Place{name: "Valencia"}, %Place{name: "Malaga"}]}}

      iex> create_journey(%{})
      {:error, %Ecto.Changeset{}}

  """
  def create_journey(attrs \\ %{}) do
    new_attrs = build_attrs(attrs)

    %Journey{}
    |> Journey.changeset(new_attrs)
    |> Repo.insert()
  end

  def build_attrs(attrs) do
    attrs |> Map.replace(:places, parse_places(attrs))
  end

  defp parse_places(%{places: %{} = places}) do
    Map.values(places)
    |> add_timestamps()
    |> insert_and_get_all()
  end

  defp add_timestamps(place_attrs) do
    datetime = DateTime.utc_now() |> DateTime.truncate(:second)

    place_attrs
    |> Enum.map(
      &(&1
        |> Map.put_new(:inserted_at, datetime)
        |> Map.put_new(:updated_at, datetime))
    )
  end

  defp insert_and_get_all(place_attrs) do
    names = place_attrs |> Enum.map(& &1.name)
    Repo.insert_all({"places", Place}, place_attrs, on_conflict: :nothing)
    Repo.all(from place in Place, where: place.name in ^names)
  end
end
