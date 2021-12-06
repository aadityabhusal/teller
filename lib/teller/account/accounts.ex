defmodule TellerWeb.Account.Accounts do
  @api_url "http://localhost:4000"

  def get_accounts(%{token: token}) do
    [get_account(%{token: token})]
  end

  def get_account(%{token: token}) do
    enrollment_id = "enr_nmf3f7758gpc7b5cd6000"
    account_id = "acc_nmfff743stmo5n80t4000"
    account_number = "891824333836"
    account_name = get_account_name(0)

    institution_name = get_institution_name(0)
    institution_id = institution_name |> String.downcase() |> String.replace(" ", "-")

    %{
      token: token,
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
      name: account_name,
      subtype: "checking",
      type: "depository"
    }
  end

  defp get_account_name(at) do
    account_names = [
      "My Checking",
      "Jimmy Carter",
      "Ronald Reagan",
      "George H. W. Bush",
      "Bill Clinton",
      "George W. Bush",
      "Barack Obama",
      "Donald Trump"
    ]

    Enum.at(account_names, at)
  end

  defp get_institution_name(at) do
    institution_names = ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]

    Enum.at(institution_names, at)
  end
end
