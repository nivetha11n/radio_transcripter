defmodule LiveviewtestWeb.PageLive do

  use LiveviewtestWeb, :live_view

  import DateTime

  @time_update_message :update_time

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, @time_update_message)
    end

    {:ok, assign(socket, time: DateTime.utc_now())}
  end

  def render(assigns) do
    ~H"""
     <%= DateTime.to_string(@time) %>
    """
  end

  def handle_info(@time_update_message, socket) do
    {:noreply, assign(socket, time: DateTime.utc_now())}
  end

end
