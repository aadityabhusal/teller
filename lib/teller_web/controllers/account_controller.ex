defmodule BankWeb.AccountController do
  use BankWeb, :controller
  alias BankWeb.Account

  def index(conn, _params) do
    render(conn, "index.json", data: Account.index())
  end
end
