defmodule FreedppWeb.Router do
  use Plug.Router
  IO.puts("estic dins el router")

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  plug :match
  plug :dispatch






  post "/register" do
    FreedppWeb.AuthController.register(conn)
  end

  post "/login" do
    FreedppWeb.AuthController.login(conn)
  end

  # DPP endpoints
  forward "/dpp/events", to: Freedpp.DPPEventController, init_opts: []
  forward "/dpp", to: Freedpp.DPPController, init_opts: []

  # Fallback
  match _ do
    send_resp(conn, 404, "Not found")
  end
end
