defmodule ChannelxWeb.Services.Plugs.CurrentUser do
	import Plug.Conn

	alias Channelx.Auth
	alias Channelx.Auth.User

	def init(_)do

	end

	def call(conn, _) do
		user_id = Plug.Conn.get_session(conn, :current_user_id)

		cond do
			current_user = user_id && Auth.get_user!(user_id) ->
				token = Phoenix.Token.sign(conn, "user_token", user_id)
				conn
        |> assign(:current_user, current_user)
        |> assign(:user_signed_in?, true)
				|> assign(:user_token, token)
      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
			end
	end

end
