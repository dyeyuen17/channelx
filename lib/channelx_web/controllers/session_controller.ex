defmodule ChannelxWeb.SessionController do
	use ChannelxWeb, :controller
	alias Channelx.Auth

	def new(conn, _params) do
		render(conn, "new.html")
	end

	def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
		case Auth.sign_in(email, password) do
			{:ok, user} ->
				conn
					|> put_session(:current_user_id, user.id)
					|> put_flash(:info, "You have successfully signed in!")
					|> redirect(to: room_path(conn, :index))
			{:error, _} ->
				conn
					|> put_flash(:error, "Invalid Email or Password")
					|> render("new.html")
		end
	end


end
