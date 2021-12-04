defmodule TellerWeb.AccountController do
  use TellerWeb, :controller
  alias TellerWeb.Account

  def index(conn, _params) do
    render(conn, "index.json", data: Account.Accounts.get_accounts())
  end

  def get_account(conn, _params) do
    render(conn, "get_account.json", data: Account.Accounts.get_account())
  end

  def get_details(conn, _params) do
    render(conn, "get_details.json", data: Account.Details.get_details())
  end

  def get_balances(conn, _params) do
    render(conn, "get_balances.json", data: Account.Balances.get_balances())
  end

  def get_transactions(conn, _params) do
    render(conn, "get_transactions.json", data: Account.Transactions.get_transactions())
  end

  def get_transaction(conn, _params) do
    render(conn, "get_transaction.json", data: Account.Transactions.get_transaction())
  end
end
