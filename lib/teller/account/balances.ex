defmodule TellerWeb.Account.Balances do
  @api_url "http://localhost:4000"

  def get_balances(number, account_id) do
    {available, ledger} = {33648.09, 33803.48}

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
end
