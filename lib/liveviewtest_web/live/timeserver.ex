defmodule Liveviewtest.TimeServer do
  use GenServer

  # Starting the GenServer
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  # Initializing the GenServer
  def init(:ok) do
    send(self(), :tick)
    {:ok, %{}}
  end

  # Handling the :tick message
  def handle_info(:tick, state) do
    LiveviewtestWeb.Endpoint.broadcast("time_updates", "new_time", DateTime.utc_now())
    Process.send_after(self(), :tick, 1000) # Send :tick every 1000ms
    {:noreply, state}
  end
end
