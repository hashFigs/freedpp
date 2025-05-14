defmodule Freedpp.Accounts.Commands.RegisterUser do
  defstruct [
    :user_uuid,
    :username,
    :email,
    :hashed_password,

  ]
end
