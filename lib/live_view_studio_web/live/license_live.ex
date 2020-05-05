defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  import Number.Currency
  alias LiveViewStudio.Licenses
  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 3, amount: Licenses.calculate(3), fullname: "John doe")
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Team Licenses</h1>
      <div id="licenses">
          <div class="card">
              <div class="content">
                  <div class="seats">
                      <img src="images/license.svg">
                      <span>
                          Your license is currently
                          <strong><%= @seats %></strong> seats.
                      </span>
                  </div>

                  <form phx-change="update">
                  <input type="range" min="1" max="10" name="seats" value="<%= @seats %>" />
                  <input type="text" name="fullname" value="<%= @fullname %>" />
                  </form>
                  <div class="amount">
                    <%= number_to_currency(@amount) %>
                    <%= @fullname %>
                  </div>
              </div>
          </div>
      </div>
    """
  end


  def handle_event("update", %{ "seats" => seats, "fullname" => fullname }, socket) do
    seats = String.to_integer(seats)
    socket =
    assign(socket,
      seats: seats,
      amount: Licenses.calculate(seats),
      fullname: fullname
      )
    {:noreply, socket}
  end
end
