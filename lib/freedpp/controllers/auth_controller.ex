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

    case Accounts.register_user(cmd) do
      {:ok, _result} ->
        send_resp(conn, 201, "User registered successfully")

      {:error, reason} ->
        send_resp(conn, 400, "Failed to register user: #{inspect(reason)}")
    end
  end


  def register(conn) do
    send_resp(conn, 400, "Missing fields: username, email, and password are required")
  end

  def login(%Plug.Conn{params: %{"email" => email, "password" => password}} = conn) do
    case Accounts.authenticate(email, password) do
      {:ok, user} ->
        json(conn, %{message: "Login successful", user: %{uuid: user.uuid, email: user.email}})

      {:error, reason} ->
        send_resp(conn, 401, "Login failed: #{reason}")
    end
  end

  def login(conn) do
    send_resp(conn, 400, "Missing fields: email and password are required")
  end

  defp json(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(data))
  end
end
