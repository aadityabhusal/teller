defmodule TellerWeb.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    with {username, _password} <- Plug.BasicAuth.parse_basic_auth(conn) do
      {:ok, "test_" <> decoded} = Base.decode64(username)
      token = :erlang.phash2(decoded)
      broadcast_requests(conn)
      assign(conn, :token, token)
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end

  defp broadcast_requests(conn) do
    Phoenix.PubSub.broadcast!(
      Teller.PubSub,
      "update_requests",
      {:update_requests, conn.request_path}
    )
  end
end
