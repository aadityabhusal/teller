defmodule TellerWeb.AccountView do
  use TellerWeb, :view

  def render("index.json", %{data: data}) do
    %{data: data}
  end
end
