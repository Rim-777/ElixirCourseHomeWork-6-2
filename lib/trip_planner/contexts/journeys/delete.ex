defmodule TripPlanner.Contexts.Journeys.Delete do
  @moduledoc """
  The Journeys.Delete context.
  """

  import Ecto.Query, warn: false
  alias TripPlanner.Repo
  alias TripPlanner.Journey

  @doc """
  Deletes a journey.

  ## Examples

      iex> delete_journey(journey)
      {:ok, %Journey{}}

      iex> delete_journey(journey)
      {:error, %Ecto.Changeset{}}

  """
  def delete_journey(%Journey{} = journey) do
    Repo.delete(journey)
  end
end
