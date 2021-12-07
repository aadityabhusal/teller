defmodule TellerWeb.Account.Details do
  @api_url "http://localhost:4000"

  def get_details(number, account_id) do
    if account_id === "acc_#{number}" do
      %{
        account_id: account_id,
        account_number: String.slice("#{number}", -4..-1),
        links: %{
          account: "#{@api_url}/accounts/#{account_id}",
          self: "#{@api_url}/accounts/#{account_id}/details"
        },
        routing_numbers: %{
          ach: "acc_#{number}"
        }
      }
    else
      %{error: "Invalid Account Id"}
    end
  end
end
