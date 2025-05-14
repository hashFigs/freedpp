defmodule Freedpp.Repo do
  use Ecto.Repo,
    otp_app: :freedpp,
    adapter: Ecto.Adapters.Postgres
end
