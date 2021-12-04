defmodule TellerWeb.Account do
  def index do
    %{data: "accounts"}
  end

  def get_account do
    %{data: "get_account"}
  end

  def get_details do
    %{data: "get_details"}
  end

  def get_balances do
    %{data: "get_balances"}
  end

  def get_transactions do
    %{data: "get_transactions"}
  end

  def get_transaction do
    %{data: "get_transaction"}
  end
end
