defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Licenses
  import Number.Currency

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 3, amount: Licenses.calculate(3), user_name: "")
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg">
            <span>
              Your license is currently for
              <strong><%= @seats %></strong> seats.
            </span>
          </div>

          <form phx-change="update">
            <input type="range" min="1" max="10"
                  name="seats" value="<%= @seats %>" />
          </form>

          <div class="amount">
            <%= number_to_currency(@amount) %>
          </div>
        </div>
      </div>
      <form phx-change="newuser">
          <input type="text" name="user_name" value="<%= @user_name %>" placeholder="Name">
          <button type="submit">
              Save
          </button>
      </form>
      <div>
        <%= inspect @user_name %>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licenses.calculate(seats)
      )
    {:noreply, socket}
  end
  def handle_event("newuser", %{"user_name" => user}, socket) do
    socket =
      assign(socket,
        user_name: user
      )

    {:noreply, socket}
  end
end
