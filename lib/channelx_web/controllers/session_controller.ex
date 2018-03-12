defmodule ChannelxWeb.SessionController do
	use ChannelxWeb, :controller

	def new(conn, _params) do
		render(conn, "new.html")
	end
end
