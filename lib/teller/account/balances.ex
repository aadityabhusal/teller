defmodule TellerWeb.Account.Balances do
  @api_url "http://localhost:4000"
  alias TellerWeb.Account.Transactions

  def get_balances(token, account_id) do
    transactions = Transactions.get_transactions(token, account_id)

    if account_id === "acc_#{token}" and transactions do
      {available, ledger} = get_min_amount(transactions)

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

  defp get_min_amount(transactions) do
    txn_by_date =
      transactions
      |> Enum.group_by(fn txn -> txn.date end, fn txn -> txn.running_balance end)

    [start, today] =
      transactions
      |> Enum.uniq_by(fn x -> x.date end)
      |> Enum.take(-2)
      |> Enum.map(fn x -> x.date end)

    available = txn_by_date |> Map.get(today) |> Enum.min()

    if Date.utc_today() == today do
      ledger = txn_by_date |> Map.get(start) |> Enum.min()
      {available, ledger}
    else
      {available, available}
    end
  end
end
