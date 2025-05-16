defmodule Freedpp.Accounts.Aggregates.User do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [ :username, :email, :hashed_password]}

IO.puts("aqui no peta")
  schema "users" do
    field :username, :string
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end

  # Handle command
  def execute(%__MODULE__{uuid: nil}, %Freedpp.Accounts.Commands.RegisterUser{} = cmd) do

    IO.puts("[Aggregate] Handling RegisterUser command")

    %Freedpp.Accounts.Events.UserRegistered{
      user_uuid: cmd.user_uuid,
      username: cmd.username,
      email: cmd.email,
      hashed_password: cmd.hashed_password
    }
  end

  # Apply event
  def apply(%__MODULE__{} = user, %Freedpp.Accounts.Events.UserRegistered{} = evt) do
    %__MODULE__{
      user |
      uuid: evt.user_uuid,
      username: evt.username,
      email: evt.email,
      hashed_password: evt.hashed_password
    }
  end
end
