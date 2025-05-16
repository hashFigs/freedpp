defmodule FreedppWeb.AuthController do
  import Plug.Conn

  def register(%Plug.Conn{params: %{"username" => username, "email" => email, "password" => password}} = conn) do
    hashed_password = Bcrypt.hash_pwd_salt(password)

    IO.puts("[AuthController] Registering user...")

    {:ok, binary_uuid} = Ecto.UUID.dump(Ecto.UUID.generate())


    cmd = %Freedpp.Accounts.Commands.RegisterUser{
      user_uuid: binary_uuid,
      username: username,
      email: email,
      hashed_password: hashed_password
    }

    IO.puts("[AuthController] Registering 2 user...")

    result =
      case Freedpp.App.dispatch(cmd) do
        :ok ->
          send_resp(conn, 201, "User registered successfully")

        {:error, reason} ->
          send_resp(conn, 400, "Failed to register user: #{inspect(reason)}")
      end

    IO.puts("[AuthController] Registering 3 user...")
    result
  end

  def register(conn) do
    send_resp(conn, 400, "Missing fields: username, email, and password are required")
  end
end
