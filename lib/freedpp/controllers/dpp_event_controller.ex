defmodule Freedpp.DPPEventController do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  plug :match
  plug :dispatch

  alias Freedpp.DPP.Handlers.CaptureEventHandler

  post "/dpp/events" do
    case Jason.decode(conn.body_params) do
      {:ok, params} ->
        case params["eventType"] do
          eventType when is_binary(eventType) ->
            event_module = Module.concat([Freedpp, DPP, Events, eventType])
            event = struct!(event_module, params)
            CaptureEventHandler.handle(event)
            send_resp(conn, 202, Jason.encode!(%{status: "#{String.downcase(eventType)} accepted"}))
          _ ->
            send_resp(conn, 400, Jason.encode!(%{error: "unknown or missing eventType"}))
        end
      {:error, _} ->
        send_resp(conn, 400, Jason.encode!(%{error: "invalid JSON payload"}))
    end
  end
end
