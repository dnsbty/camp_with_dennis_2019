defmodule CampWithDennis2019.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    CampWithDennis2019.SmsVerification.start()

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      CampWithDennis2019.Repo,
      # Start the endpoint when the application starts
      CampWithDennis2019Web.Endpoint
      # Starts a worker by calling: CampWithDennis2019.Worker.start_link(arg)
      # {CampWithDennis2019.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CampWithDennis2019.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CampWithDennis2019Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
