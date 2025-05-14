defmodule Freedpp.Accounts.Aggregates.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Jason.Encoder, only: [:uuid, :username, :email, :hashed_password]}
  schema "users" do
    field :username, :string
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uuid, :username, :email, :hashed_password])
    |> validate_required([:uuid, :username, :email, :hashed_password])
    |> unique_constraint(:email)
  end

  # command handler
  def execute(%__MODULE__{uuid: nil}, %Freedpp.Accounts.Commands.RegisterUser{} = cmd) do
    %Freedpp.Accounts.Events.UserRegistered{
      user_uuid: cmd.user_uuid,
      username: cmd.username,
      email: cmd.email,
      hashed_password: cmd.hashed_password
    }
  end

  # event applier
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
