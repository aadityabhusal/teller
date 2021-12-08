defmodule TellerWeb.AccoountControllerTest do
  use TellerWeb.ConnCase

  describe "All routes for account related endpoints when valid username token is provided " do
    setup %{conn: conn} do
      {:ok,
       conn:
         Plug.Conn.put_req_header(
           conn,
           "authorization",
           Plug.BasicAuth.encode_basic_auth(Base.encode64("test_user123:"), "")
         )}
    end

    test "GET /accounts", %{conn: conn} do
      response =
        conn
        |> get("/accounts")
        |> json_response(200)

      assert response == [
               %{
                 "currency" => "USD",
                 "enrollment_id" => "enr_42978146",
                 "id" => "acc_42978146",
                 "institution" => %{"id" => "bank-of-america", "name" => "Bank of America"},
                 "last_four" => "7200",
                 "links" => %{
                   "balances" => "http://localhost:4000/accounts/acc_42978146/balances",
                   "details" => "http://localhost:4000/accounts/acc_42978146/details",
                   "self" => "http://localhost:4000/accounts/acc_42978146",
                   "transactions" => "http://localhost:4000/accounts/acc_42978146/transactions"
                 },
                 "name" => "Ronald Reagan",
                 "subtype" => "checking",
                 "type" => "depository"
               }
             ]
    end

    test "GET /accounts/acc_42978146", %{conn: conn} do
      response =
        conn
        |> get("/accounts/acc_42978146")
        |> json_response(200)

      assert response == %{
               "currency" => "USD",
               "enrollment_id" => "enr_42978146",
               "id" => "acc_42978146",
               "institution" => %{"id" => "bank-of-america", "name" => "Bank of America"},
               "last_four" => "7200",
               "links" => %{
                 "balances" => "http://localhost:4000/accounts/acc_42978146/balances",
                 "details" => "http://localhost:4000/accounts/acc_42978146/details",
                 "self" => "http://localhost:4000/accounts/acc_42978146",
                 "transactions" => "http://localhost:4000/accounts/acc_42978146/transactions"
               },
               "name" => "Ronald Reagan",
               "subtype" => "checking",
               "type" => "depository"
             }
    end

    test "GET /accounts/acc_42978146/details", %{conn: conn} do
      response =
        conn
        |> get("/accounts/acc_42978146/details")
        |> json_response(200)

      assert response == %{
               "account_id" => "acc_42978146",
               "account_number" => "119847200",
               "links" => %{
                 "account" => "http://localhost:4000/accounts/acc_42978146",
                 "self" => "http://localhost:4000/accounts/acc_42978146/details"
               },
               "routing_numbers" => %{"ach" => "64376558"}
             }
    end

    test "GET /accounts/acc_42978146/balances", %{conn: conn} do
      response =
        conn
        |> get("/accounts/acc_42978146/balances")
        |> json_response(200)

      assert response == %{
               "account_id" => "acc_42978146",
               "available" => "781686.96",
               "ledger" => "783612.83",
               "links" => %{
                 "account" => "http://localhost:4000/accounts/acc_42978146",
                 "self" => "http://localhost:4000/accounts/acc_42978146/balances"
               }
             }
    end
  end

  describe "All routes when username token is not provided " do
    test "GET /accounts", %{conn: conn} do
      conn
      |> get("/accounts")
      |> response(401)
    end

    test "GET /accounts/acc_42978146", %{conn: conn} do
      conn
      |> get("/accounts/acc_42978146")
      |> response(401)
    end

    test "GET /accounts/acc_42978146/details", %{conn: conn} do
      conn
      |> get("/accounts/acc_42978146/details")
      |> response(401)
    end

    test "GET /accounts/acc_42978146/balances", %{conn: conn} do
      conn
      |> get("/accounts/acc_42978146/balances")
      |> response(401)
    end

    test "GET /accounts/acc_42978146/transactions", %{conn: conn} do
      conn
      |> get("/accounts/acc_42978146/transactions/")
      |> response(401)
    end

    test "GET /accounts/acc_42978146/transactions/txn_120410193", %{conn: conn} do
      conn
      |> get("/accounts/acc_42978146/transactions/txn_120410193")
      |> response(401)
    end
  end

  describe "All routes when invalid account id provided " do
    setup %{conn: conn} do
      {:ok,
       conn:
         Plug.Conn.put_req_header(
           conn,
           "authorization",
           Plug.BasicAuth.encode_basic_auth(Base.encode64("test_user123:"), "")
         )}
    end

    test "GET /accounts/invalid_id", %{conn: conn} do
      response =
        conn
        |> get("/accounts/invalid_id")
        |> response(200)

      assert response == "{\"error\":\"Invalid Account Id\"}"
    end

    test "GET /accounts/invalid_id/details", %{conn: conn} do
      response =
        conn
        |> get("/accounts/invalid_id/details")
        |> response(200)

      assert response == "{\"error\":\"Invalid Account Id\"}"
    end

    test "GET /accounts/invalid_id/balances", %{conn: conn} do
      response =
        conn
        |> get("/accounts/invalid_id/balances")
        |> response(200)

      assert response == "{\"error\":\"Invalid Account Id\"}"
    end

    test "GET /accounts/invalid_id/transactions", %{conn: conn} do
      response =
        conn
        |> get("/accounts/invalid_id/transactions/")
        |> response(200)

      assert response == "{\"error\":\"Invalid Account Id\"}"
    end

    test "GET /accounts/invalid_id/transactions/txn_120410193", %{conn: conn} do
      response =
        conn
        |> get("/accounts/invalid_id/transactions/txn_120410193")
        |> response(200)

      assert response == "{\"error\":\"Invalid Account Id\"}"
    end
  end
end
