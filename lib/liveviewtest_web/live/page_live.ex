defmodule LiveviewtestWeb.PageLive do

  use LiveviewtestWeb, :live_view


  #@time_update_message :update_time

  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    if connected?(socket) do
      LiveviewtestWeb.Endpoint.subscribe("time_updates")
    end

    {:ok, assign(socket, time: DateTime.utc_now())}
  end

  def render(assigns) do
    ~H"""
    <%= @time %>
    """
  end

  def handle_info(%Phoenix.Socket.Broadcast{event: "new_time", payload: time}, socket) do
    # Update the socket's assigns with the new time
    {:noreply, assign(socket, time: time)}
  end



end
