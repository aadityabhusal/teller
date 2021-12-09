# Teller

## Features
  The Teller API Sandbox the following features and functionalities:

  * User authentication with HTTP Basic Auth in the username field.
  * Given the same API token, returns the same information.
  * Returns 0-5 transactions per day going back 90 days.
  * Transaction displays a negative amount and running balance
  * The application doesn't use a database/genserver/agent/file system or any persistence.
  * The application has a Phoenix LiveView dashboard to display the request count of API paths.
  * Transactions can be paginated using 'count' and 'from_id' query parameters.

## Usage

API Token Format - test_ <> token of any length. (The token will be Base64 encoded.)

Example Token (for test_user123) - `dGVzdF91c2VyMTIz`

Example Routes for above token:

  * /accounts
  * /accounts/acc_42978146
  * /accounts/acc_42978146/details
  * /accounts/acc_42978146/balances
  * /accounts/acc_42978146/transactions
  * /accounts/acc_42978146/transactions/txn_11221497

## Setup
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Run automated tests using `mix test` command

Visit [`localhost:4000`](http://localhost:4000) from your browser.