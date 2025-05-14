defmodule Freedpp.Accounts.Repo.UserRepo do
  alias Freedpp.Accounts.Aggregates.User
  alias Freedpp.Repo

  # Insert a new user into the database
  def insert_user(%User{} = user) do
    %User{}
    |> Ecto.Changeset.change(user)
    |> Repo.insert()
  end

  # Get a user by UUID
  def get_user_by_uuid(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  # Get a user by email
  def get_user_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
