defmodule Freedpp.MixProject do
  use Mix.Project

  def project do
    [
      app: :freedpp,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {Freedpp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ecto_sql, "~> 3.11"},
      {:postgrex, ">= 0.0.0"},
      {:commanded, "~> 1.4"},
      {:commanded_ecto_projections, "~> 1.2"},
      {:commanded_eventstore_adapter, "~> 1.2"},
      {:eventstore, "~> 1.4"},
      {:jason, "~> 1.4"},
      {:bcrypt_elixir, "~> 3.0"},
      {:uuid, "~> 1.1"},
      {:plug_cowboy, "~> 2.6"},
      {:plug, "~> 1.14"}
    ]
  end
end
