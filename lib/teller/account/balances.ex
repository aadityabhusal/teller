defmodule TellerWeb.Account.Balances do
  @api_url "http://localhost:4000"
  alias TellerWeb.Account.Transactions

  def get_balances(number, account_id) do
    transactions = Transactions.get_transactions(number, account_id)
    today = Date.utc_today()
    start = Date.add(today, -1)

    available = get_min_amount(transactions, today)
    ledger = get_min_amount(transactions, start)

    if account_id === "acc_#{number}" do
      %{
        account_id: account_id,
        available: "#{available}",
        ledger: "#{ledger}",
        links: %{
          account: "#{@api_url}/accounts/#{account_id}",
          self: "#{@api_url}/accounts/#{account_id}/balances"
        }
      }
    else
      %{error: "Invalid Account Id"}
    end
  end

  defp get_min_amount(transactions, date) do
    transactions
    |> Enum.filter(fn txn -> txn.date === date end)
    |> Enum.map(fn txn -> txn.running_balance end)
    |> Enum.min()
  end
end
