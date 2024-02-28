defmodule LiveviewtestWeb.TimeServer do
  use GenServer

  # Starts the GenServer
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # Initializes the GenServer
  def init(:ok) do
    schedule_tick()
    {:ok, nil}
  end

  # Handles the :tick message
  def handle_info(:tick, _state) do
    # Broadcast the current time
    current_time = DateTime.utc_now() |> DateTime.to_string()
    LiveviewtestWeb.Endpoint.broadcast("time_updates", "new_time", current_time)

    # Schedule the next tick
    schedule_tick()

    {:noreply, nil}
  end

  # Helper function to schedule the next tick
  defp schedule_tick do
    Process.send_after(self(), :tick, 1)
  end
end
