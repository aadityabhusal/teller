defmodule TellerWeb.PageController do
  use TellerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
