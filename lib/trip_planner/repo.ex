defmodule TripPlanner.Repo do
  use Ecto.Repo,
    otp_app: :trip_planner,
    adapter: Ecto.Adapters.Postgres
end
