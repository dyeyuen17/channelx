defmodule Channelx.Auth do
	alias Channelx.Repo
	alias Channelx.Auth.User

	def sign_in(email, password) do
		user = Repo.get_by(User, email: email)

		cond do
			user && user.password == password ->
				{:ok, user}
			true ->
				{:error, :unauthorized}
		end
	end


end
