defmodule TellerWeb.Account.Details do
  @api_url "https://tellerapi.herokuapp.com"

  def get_details(token, account_id) do
    account_number = :erlang.phash2(token)
    routing_number = :erlang.phash2(account_number)

    if account_id === "acc_#{token}" do
      %{
        account_id: account_id,
        account_number: "#{account_number}",
        links: %{
          account: "#{@api_url}/accounts/#{account_id}",
          self: "#{@api_url}/accounts/#{account_id}/details"
        },
        routing_numbers: %{
          ach: "#{routing_number}"
        }
      }
    else
      %{error: "Invalid Account Id"}
    end
  end
end
