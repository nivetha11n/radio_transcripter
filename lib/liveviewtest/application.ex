defmodule Liveviewtest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveviewtestWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:liveviewtest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Liveviewtest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Liveviewtest.Finch},
      # Start a worker by calling: Liveviewtest.Worker.start_link(arg)
      # {Liveviewtest.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveviewtestWeb.TimeServer,
      LiveviewtestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Liveviewtest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveviewtestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
