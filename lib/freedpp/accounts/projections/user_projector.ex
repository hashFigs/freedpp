defmodule Freedpp.Accounts.Projectors.UserProjector do
  use Commanded.Projections.Ecto,
    name: "UserProjector",
    repo: Freedpp.Repo

  alias Freedpp.Accounts.Events.UserRegistered
  alias Freedpp.Accounts.Aggregates.User

  project %UserRegistered{} = evt, _metadata do
    Ecto.Multi.insert(multi, :user, %User{
      uuid: evt.user_uuid,
      username: evt.username,
      email: evt.email,
      hashed_password: evt.hashed_password
    })
  end
end
