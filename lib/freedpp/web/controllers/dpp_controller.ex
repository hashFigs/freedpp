defmodule Freedpp.DPPController do
  use Plug.Router

  plug :match
  plug :dispatch

  alias Freedpp.Repo
  alias Freedpp.DPP.Projections.Passport

  get "/dpp/:product_id" do
    case Repo.get(Passport, product_id) do
      nil -> send_resp(conn, 404, Jason.encode!(%{error: "passport not found"}))
      p   -> send_resp(conn, 200, Jason.encode!(p))
    end
  end
end
