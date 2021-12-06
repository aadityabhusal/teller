defmodule TellerWeb.Account.Transactions do
  @api_url "http://localhost:4000"

  def get_transactions do
    [get_transaction()]
  end

  def get_transaction do
    account_id = "acc_nmfff743stmo5n80t4000"
    amount = 90.54
    date = "2021-08-12"
    running_balance = 33648.09

    organization = get_merchant(0)
    counterparty_name = organization |> String.upcase() |> String.replace("-", " ")
    category = get_merchant_category(0)

    transaction_id = "txn_nmfo2gtnstmo5n80t4004"
    account_id = "acc_nmfff743stmo5n80t4000"

    %{
      account_id: account_id,
      amount: amount,
      date: date,
      description: organization,
      details: %{
        category: category,
        counterparty: %{
          name: counterparty_name,
          type: "organization"
        },
        processing_status: "complete"
      },
      id: transaction_id,
      links: %{
        account: "#{@api_url}/accounts/#{account_id}",
        self: "#{@api_url}/accounts/#{account_id}/transactions/#{transaction_id}"
      },
      running_balance: running_balance,
      status: "posted",
      type: "ach"
    }
  end

  defp get_merchant(at) do
    merchants = [
      "Uber",
      "Uber Eats",
      "Lyft",
      "Five Guys",
      "In-N-Out Burger",
      "Chick-Fil-A",
      "AMC Metreon",
      "Apple",
      "Amazon",
      "Walmart",
      "Target",
      "Hotel Tonight",
      "Misson Ceviche",
      "The Creamery",
      "Caltrain",
      "Wingstop",
      "Slim Chickens",
      "CVS",
      "Duane Reade",
      "Walgreens",
      "Rooster & Rice",
      "McDonald's",
      "Burger King",
      "KFC",
      "Popeye's",
      "Shake Shack",
      "Lowe's",
      "The Home Depot",
      "Costco",
      "Kroger",
      "iTunes",
      "Spotify",
      "Best Buy",
      "TJ Maxx",
      "Aldi",
      "Dollar General",
      "Macy's",
      "H.E. Butt",
      "Dollar Tree",
      "Verizon Wireless",
      "Sprint PCS",
      "T-Mobile",
      "Kohl's",
      "Starbucks",
      "7-Eleven",
      "AT&T Wireless",
      "Rite Aid",
      "Nordstrom",
      "Ross",
      "Gap",
      "Bed, Bath & Beyond",
      "J.C. Penney",
      "Subway",
      "O'Reilly",
      "Wendy's",
      "Dunkin' Donuts",
      "Petsmart",
      "Dick's Sporting Goods",
      "Sears",
      "Staples",
      "Domino's Pizza",
      "Pizza Hut",
      "Papa John's",
      "IKEA",
      "Office Depot",
      "Foot Locker",
      "Lids",
      "GameStop",
      "Sephora",
      "MAC",
      "Panera",
      "Williams-Sonoma",
      "Saks Fifth Avenue",
      "Chipotle Mexican Grill",
      "Exxon Mobil",
      "Neiman Marcus",
      "Jack In The Box",
      "Sonic",
      "Shell"
    ]

    Enum.at(merchants, at)
  end

  defp get_merchant_category(at) do
    merchant_categories = [
      "accommodation",
      "advertising",
      "bar",
      "charity",
      "clothing",
      "dining",
      "education",
      "electronics",
      "entertainment",
      "fuel",
      "groceries",
      "health",
      "home",
      "income",
      "insurance",
      "investment",
      "loan",
      "office",
      "phone",
      "service",
      "shopping",
      "software",
      "sport",
      "tax",
      "transport",
      "transportation",
      "utilities"
    ]

    Enum.at(merchant_categories, at)
  end
end
