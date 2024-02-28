defmodule LiveviewtestWeb.PageLive do

  use LiveviewtestWeb, :live_view

    def mount(_params, _session, socket) do
        {:ok, socket}
    end

    def render(assigns) do
     ~H"""

     <strong>Hello World!</strong>
     """
    end

end
