defmodule Freedpp.Accounts.Commands.RegisterUser do
  defstruct [
    :user_uuid,
    :username,
    :email,
    :hashed_password,

  ]

  def new(user_uuid, username, email, hashed_password) do
    %__MODULE__{
      user_uuid: Ecto.UUID.cast!(user_uuid),  # Convert to binary
      username: username,
      email: email,
      hashed_password: hashed_password
    }
  end
end
