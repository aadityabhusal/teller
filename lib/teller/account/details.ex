defmodule TellerWeb.Account.Details do
  @api_url "http://localhost:4000"

  def get_details(number, account_id) do
    account_number = String.slice("#{number}", -4..-1)
    routing_number = Base.encode16("#{account_number}")

    if account_id === "acc_#{number}" do
      %{
        account_id: account_id,
        account_number: account_number,
        links: %{
          account: "#{@api_url}/accounts/#{account_id}",
          self: "#{@api_url}/accounts/#{account_id}/details"
        },
        routing_numbers: %{
          ach: routing_number
        }
      }
    else
      %{error: "Invalid Account Id"}
    end
  end
end
