defmodule Channelx.Auth do
  alias Channelx.Repo
  alias Channelx.Auth.User

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Comeonin.Bcrypt.checkpw(password, user.password) ->
        {:ok, user}

      true ->
        {:error, :unauthorized}
    end
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

  def register(params) do
    User.registration_changeset(%User{}, params) |> Repo.insert()
  end

  def get_user!(id), do: User |> Repo.get!(id)
end
