defmodule TellerWeb.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    with {username, _password} <- Plug.BasicAuth.parse_basic_auth(conn) do
      {:ok, "test_" <> decoded} = Base.decode64(username)
      {token, _} = decoded |> Base.encode16() |> String.split_at(21)
      assign(conn, :token, String.to_integer(token))
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end
end
