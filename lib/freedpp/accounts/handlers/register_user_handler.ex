defmodule Freedpp.Accounts.Handlers.RegisterUserHandler do
  alias Freedpp.Accounts.Aggregates.User
  alias Freedpp.Accounts.Commands.RegisterUser
  alias Freedpp.Accounts.Events.UserRegistered
  alias Freedpp.Repo

  def handle(%RegisterUser{} = cmd) do
    # First, we execute the command which results in an event
    event = User.execute(%User{}, cmd)

    # Store the event (you would store the event in an Event Store here)
    store_event(event)

    # Now, apply the event to update the aggregate state
    user = %User{}
    updated_user = User.apply(user, event)

    # Optionally, persist the updated state of the user in the database (not mandatory for event sourcing)
    Repo.insert(updated_user)
  end

  defp store_event(event) do
    # This function is where you would store events, likely in an Event Store
    IO.inspect(event, label: "Stored Event:")
    # In a real implementation, this would save the event to the event store or event stream
  end
end
