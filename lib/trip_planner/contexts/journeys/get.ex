defmodule TripPlanner.Contexts.Journeys.Get do
  @moduledoc """
  The Journeys.Get context.
  """

  import Ecto.Query, warn: false
  alias TripPlanner.Repo
  alias TripPlanner.Journey

  @doc """
  Gets a single journey by its id.

  Raises `Ecto.NoResultsError` if the Journey does not exist.

  ## Examples

      iex> get_journey!(123)
      %Journey{}

      iex> get_journey!(456)
      ** (Ecto.NoResultsError)

  """
  def get_journey!(id) do
    Journey
    |> preload([:places])
    |> Repo.get!(id)
  end

  @doc """
    Gets a list of journeys by a list of associated place names or a single name.

    Returns an empty list if Journeys not found 

     ## Examples

        iex> get_by_place_names!(["Malaga", "Valencia"])
        [%Journey{places: [%TripPlanner.Place{}]

        iex> get_by_place_names!("Malaga")
        [%Journey{places: [%TripPlanner.Place{}]

        iex> get_by_place_names!(["Abracadabra"])
        []
  """

  def get_by_place_names(place_names) when is_list(place_names) do
    query =
      from journey in Journey,
        join: place in assoc(journey, :places),
        preload: [:places],
        where: place.name in ^place_names

    Repo.all(query)
  end

  def get_by_place_names(place_name) when is_bitstring(place_name) do
    get_by_place_names([place_name])
  end
end
