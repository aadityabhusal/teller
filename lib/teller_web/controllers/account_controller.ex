defmodule TellerWeb.AccountController do
  use TellerWeb, :controller
  alias TellerWeb.Account

  def index(conn, _params) do
    render(conn, "index.json", data: Account.Accounts.get_accounts(conn.assigns.token))
  end

  def get_account(conn, %{"account_id" => account_id}) do
    render(conn, "get_account.json",
      data: Account.Accounts.get_account(conn.assigns.token, account_id)
    )
  end

  def get_details(conn, %{"account_id" => account_id}) do
    render(conn, "get_details.json",
      data: Account.Details.get_details(conn.assigns.token, account_id)
    )
  end

  def get_balances(conn, %{"account_id" => account_id}) do
    render(conn, "get_balances.json",
      data: Account.Balances.get_balances(conn.assigns.token, account_id)
    )
  end

  def get_transactions(conn, _params) do
    render(conn, "get_transactions.json", data: Account.Transactions.get_transactions())
  end

  def get_transaction(conn, _params) do
    render(conn, "get_transaction.json", data: Account.Transactions.get_transaction())
  end
end
