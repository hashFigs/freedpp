defmodule Freedpp.App do
  use Commanded.Application,
    otp_app: :freedpp,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Freedpp.EventStore
    ]

    router Freedpp.Accounts.Router
end
