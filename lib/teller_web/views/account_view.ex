defmodule BankWeb.AccountView do
  use BankWeb, :view

  def render("index.json", %{data: data}) do
    %{data: data}
  end
end
