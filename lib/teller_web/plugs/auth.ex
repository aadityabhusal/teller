defmodule TellerWeb.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    with {"test_" <> username, _password} <- Plug.BasicAuth.parse_basic_auth(conn) do
      # Create token number here
      assign(conn, :temp, username)
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end
end
