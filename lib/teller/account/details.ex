defmodule TellerWeb.Account.Details do
  @api_url "http://localhost:4000"

  def get_details do
    account_id = "acc_nmfff743stmo5n80t4000"
    account_number = "891824333836"
    routing_number = "581559698"

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
  end
end
