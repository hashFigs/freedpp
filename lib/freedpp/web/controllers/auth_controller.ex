defmodule FreedppWeb.AuthController do
  import Plug.Conn
  alias Freedpp.Accounts

  def register(%Plug.Conn{params: %{"username" => username, "email" => email, "password" => password}} = conn) do
    hashed_password = Bcrypt.hash_pwd_salt(password)

    cmd = %Freedpp.Accounts.Commands.RegisterUser{
      user_uuid: UUID.uuid4(),
      username: username,
      email: email,
      hashed_password: hashed_password
    }

    case Freedpp.App.dispatch(cmd) do
      :ok ->
        send_resp(conn, 201, "User registered successfully")

      {:error, reason} ->
        send_resp(conn, 400, "Failed to register user: #{inspect(reason)}")
    end
  end

  def register(conn) do
    send_resp(conn, 400, "Missing fields: username, email, and password are required")
  end
end
