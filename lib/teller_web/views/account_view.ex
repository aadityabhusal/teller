defmodule TellerWeb.AccountView do
  use TellerWeb, :view

  def render("index.json", %{data: data}) do
    %{data: data}
  end

  def render("get_account.json", %{data: data}) do
    %{data: data}
  end

  def render("get_details.json", %{data: data}) do
    %{data: data}
  end

  def render("get_balances.json", %{data: data}) do
    %{data: data}
  end

  def render("get_transactions.json", %{data: data}) do
    %{data: data}
  end

  def render("get_transaction.json", %{data: data}) do
    %{data: data}
  end
end
