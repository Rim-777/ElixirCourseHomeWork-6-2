defmodule TripPlanner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TripPlannerWeb.Telemetry,
      TripPlanner.Repo,
      {DNSCluster, query: Application.get_env(:trip_planner, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TripPlanner.PubSub},
      # Start a worker by calling: TripPlanner.Worker.start_link(arg)
      # {TripPlanner.Worker, arg},
      # Start to serve requests, typically the last entry
      TripPlannerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TripPlanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TripPlannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
