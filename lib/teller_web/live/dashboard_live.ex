defmodule TellerWeb.DashboardLive do
  use TellerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Teller.PubSub, "update_requests")
    {:ok, assign(socket, :requests, %{})}
  end

  def render(assigns) do
    ~L"""
    <div class="container">
      <h1>Teller API Sandbox</h1>
        <a href="https://github.com/aadityabhusal/teller" target="_blank">GitHub</a>
      <div class="table">
        <div class="table-row bold">
          <div>Request Path</div>
          <div>Request Count</div>
        </div>
    
        <%= if length(Map.keys(@requests)) < 1 do %>
          <div class="table-row">
            <div>No Data to Display</div>
          </div>
        <%= end %>
    
        <%= for {req_path, req_count} <- @requests do %>
        <div class="table-row">
          <div><%= req_path %></div>
          <div><%= req_count %></div>
        </div>
        <%= end %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_info({:update_requests, path}, socket) do
    {:noreply, socket |> update(:requests, fn reqs -> Map.update(reqs, path, 1, &(&1 + 1)) end)}
  end
end
