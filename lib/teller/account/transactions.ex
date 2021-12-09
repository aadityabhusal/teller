defmodule TellerWeb.Account.Transactions do
  @api_url "http://localhost:4000"

  def get_transaction(token, account_id, transaction_id) do
    transactions = get_transactions(token, account_id)

    if is_list(transactions) do
      result = Enum.find(transactions, fn txn -> txn.id == transaction_id end)

      if is_map(result) do
        result
      else
        %{error: "Invalid Transaction Id"}
      end
    else
      %{error: "Invalid Account Id"}
    end
  end

  def get_transactions(token, account_id, from_id \\ nil, count \\ nil) do
    if account_id === "acc_#{token}" do
      today = Date.utc_today()
      start = Date.add(today, -90)
      range = Date.range(start, today)

      range
      |> get_date_transactions(token, account_id)
      |> get_from_id_transactions(from_id)
      |> get_count_transactions(count)
    else
      %{error: "Invalid Account Id"}
    end
  end

  defp get_date_transactions(date_range, token, account_id) do
    initial_amount = token |> Integer.mod(500_000) |> then(fn x -> x + 400_000 end)

    {result, _total} =
      Enum.flat_map_reduce(date_range, initial_amount, fn date, outer_acc ->
        0..Integer.mod(:erlang.phash2(Date.to_string(date)), 5)
        |> Enum.drop(1)
        |> Enum.map_reduce(outer_acc, fn i, acc ->
          create_transaction(i, token, account_id, date, acc)
        end)
      end)

    result
  end

  defp get_from_id_transactions(transactions, from_id) do
    if from_id do
      index = Enum.find_index(transactions, fn txn -> txn.id === from_id end)
      {_, result} = Enum.split(transactions, index)
      result
    else
      transactions
    end
  end

  defp get_count_transactions(transactions, count) do
    if count do
      Enum.slice(transactions, 0, String.to_integer(count))
    else
      transactions
    end
  end

  defp create_transaction(index, token, account_id, date, previous) do
    transaction_number = :erlang.phash2("#{token}#{Date.to_string(date)}n#{index}")

    amount = transaction_number |> Integer.mod(100_000) |> then(fn x -> -x / 100 end)
    running_balance = (previous + amount) |> Float.floor(2)

    organization = get_merchant(transaction_number)
    counterparty_name = organization |> String.upcase() |> String.replace("-", " ")
    category = get_merchant_category(transaction_number)

    transaction = %{
      account_id: account_id,
      amount: "#{amount}",
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
      id: "txn_#{transaction_number}",
      links: %{
        account: "#{@api_url}/accounts/#{account_id}",
        self: "#{@api_url}/accounts/#{account_id}/transactions/txn_#{transaction_number}"
      },
      running_balance: "#{running_balance}",
      status: "posted",
      type: "card_payment"
    }

    {transaction, running_balance}
  end

  defp get_merchant(token) do
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

    at = Integer.mod(token, length(merchants))
    Enum.at(merchants, at)
  end

  defp get_merchant_category(token) do
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

    at = Integer.mod(token, length(merchant_categories))
    Enum.at(merchant_categories, at)
  end
end
