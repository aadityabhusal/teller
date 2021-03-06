defmodule TellerWeb.Router do
  use TellerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {TellerWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(TellerWeb.Plugs.Auth)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TellerWeb do
    pipe_through(:browser)
    # get("/", PageController, :index)
    live("/", DashboardLive)

    scope "/accounts" do
      pipe_through(:api)
      get("/", AccountController, :index)

      scope "/:account_id" do
        get("/", AccountController, :get_account)
        get("/details", AccountController, :get_details)
        get("/balances", AccountController, :get_balances)
        get("/transactions", AccountController, :get_transactions)
        get("/transactions/:transaction_id", AccountController, :get_transaction)
      end
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through(:browser)
  #     live_dashboard("/dashboard", metrics: TellerWeb.Telemetry)
  #   end
  # end
end
