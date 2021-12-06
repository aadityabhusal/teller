defmodule TellerWeb.Account.Accounts do
  @api_url "http://localhost:4000"

  def get_accounts do
    [get_account()]
  end

  def get_account do
    enrollment_id = "enr_nmf3f7758gpc7b5cd6000"
    account_id = "acc_nmfff743stmo5n80t4000"
    account_number = "891824333836"

    institution_name = "Citibank"
    institution_id = institution_name |> String.downcase() |> String.replace(" ", "-")

    account = %{
      currency: "USD",
      enrollment_id: enrollment_id,
      id: account_id,
      institution: %{
        id: institution_id,
        name: institution_name
      },
      last_four: String.slice(account_number, -4..-1),
      links: %{
        balances: "#{@api_url}/accounts/#{account_id}/balances",
        details: "#{@api_url}/accounts/#{account_id}/details",
        self: "#{@api_url}/accounts/#{account_id}",
        transactions: "#{@api_url}/accounts/#{account_id}/transactions"
      },
      name: "My Checking",
      subtype: "checking",
      type: "depository"
    }

    account
  end
end
