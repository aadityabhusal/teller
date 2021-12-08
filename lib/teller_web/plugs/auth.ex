defmodule TellerWeb.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    with {username, _password} <- Plug.BasicAuth.parse_basic_auth(conn) do
      {:ok, decoded_token} = Base.decode64(username)

      if String.trim(username) != "" and String.starts_with?(decoded_token, "test_") do
        "test_" <> decoded = decoded_token
        token = :erlang.phash2(decoded)
        broadcast_requests(conn)
        assign(conn, :token, token)
      else
        conn
        |> put_resp_content_type("json")
        |> send_resp(401, "{error: \"Invalid Token\"}")
      end
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
