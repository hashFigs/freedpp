defmodule Freedpp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Freedpp.Repo,
      Freedpp.App,
      {Plug.Cowboy, scheme: :http, plug: FreedppWeb.Router, options: [port: 4000]}

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Freedpp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
