defmodule TellerWeb.Account.Accounts do
  @api_url "http://localhost:4000"

  def get_accounts(token) do
    [get_account(token, "acc_#{token}")]
  end

  def get_account(token, account_id) do
    institution_name = get_institution_name(token)
    institution_id = institution_name |> String.downcase() |> String.replace(" ", "-")
    account_number = :erlang.phash2(token)

    if account_id === "acc_#{token}" do
      %{
        currency: "USD",
        enrollment_id: "enr_#{token}",
        id: account_id,
        institution: %{
          id: institution_id,
          name: institution_name
        },
        last_four: String.slice("#{account_number}", -4..-1),
        links: %{
          balances: "#{@api_url}/accounts/#{account_id}/balances",
          details: "#{@api_url}/accounts/#{account_id}/details",
          self: "#{@api_url}/accounts/#{account_id}",
          transactions: "#{@api_url}/accounts/#{account_id}/transactions"
        },
        name: get_account_name(token),
        subtype: "checking",
        type: "depository"
      }
    else
      %{error: "Invalid Account Id"}
    end
  end

  defp get_account_name(token) do
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

    at = Integer.mod(token, length(account_names))
    Enum.at(account_names, at)
  end

  defp get_institution_name(token) do
    institution_names = ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]
    at = Integer.mod(token, length(institution_names))
    Enum.at(institution_names, at)
  end
end
