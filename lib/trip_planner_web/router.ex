defmodule TripPlannerWeb.Router do
  use TripPlannerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TripPlannerWeb do
    pipe_through :api
  end
end
