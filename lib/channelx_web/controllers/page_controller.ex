defmodule ChannelxWeb.PageController do
  use ChannelxWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
