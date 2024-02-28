defmodule LiveviewtestWeb.PageLive do

  use LiveviewtestWeb, :live_view


  #@time_update_message :update_time

  def mount(_params, _session, socket) do
    if connected?(socket) do
      LiveviewtestWeb.Endpoint.subscribe("time_updates")
    end

    {:ok, assign(socket, time: DateTime.utc_now())}
  end

  def render(assigns) do
    ~H"""
     <%= DateTime.to_string(@time) %>
    """
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "time_updates", event: "new_time", payload: time}, socket) do
    {:noreply, assign(socket, time: time)}
  end



end
