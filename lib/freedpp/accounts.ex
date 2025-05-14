defmodule Freedpp.Accounts do
  alias Freedpp.Accounts.Commands.RegisterUser
  alias Freedpp.App

  def register_user(%RegisterUser{} = command) do
    App.dispatch(command)
  end
end
