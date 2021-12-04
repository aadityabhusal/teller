defmodule TellerWeb.AccountController do
  use TellerWeb, :controller
  alias TellerWeb.Account

  def index(conn, _params) do
    render(conn, "index.json", data: Account.index())
  end
end
