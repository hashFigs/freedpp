defmodule Freedpp.Accounts.Router do
  use Commanded.Commands.Router

  alias Freedpp.Accounts.Aggregates.User
  alias Freedpp.Accounts.Commands.RegisterUser

  identify User, by: :user_uuid

  dispatch RegisterUser, to: User, identity: :user_uuid
end
