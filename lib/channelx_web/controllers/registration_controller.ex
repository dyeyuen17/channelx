defmodule ChannelxWeb.RegistrationController do
	use ChannelxWeb, :controller
	alias Channelx.Auth

	def new(conn, _) do
		render(conn, "new.html", changeset: conn)
	end

	def create(conn, %{"registration" => registration_params}) do
		case Auth.register(registration_params) do
			{:ok, user} ->
				conn
				|> put_session(:current_user_id, user.id)
				|> put_flash(:info, "You have successfully signed up!")
				|> redirect(to: room_path(conn, :index))

			{:error, changeset} ->
				conn
				|> put_flash(:error, "Registration failed!")
				|> render("new.html", changeset: changeset)
		end
	end
end