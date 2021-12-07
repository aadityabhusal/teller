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

  def get_transactions(conn, %{"account_id" => account_id} = params) do
    from_id = params["from_id"]
    count = params["count"]

    render(conn, "get_transactions.json",
      data: Account.Transactions.get_transactions(conn.assigns.token, account_id, from_id, count)
    )
  end

  def get_transaction(conn, %{"account_id" => account_id, "transaction_id" => transaction_id}) do
    render(conn, "get_transaction.json",
      data: Account.Transactions.get_transaction(conn.assigns.token, account_id, transaction_id)
    )
  end
end
