defmodule TellerWeb.Account.Balances do
  @api_url "http://localhost:4000"

  def get_balances do
    account_id = "acc_nmfff743stmo5n80t4000"
    {available, ledger} = {33648.09, 33803.48}

    %{
      account_id: account_id,
      available: available,
      ledger: ledger,
      links: %{
        account: "#{@api_url}/accounts/#{account_id}",
        self: "#{@api_url}/accounts/#{account_id}/balances"
      }
    }
  end
end
