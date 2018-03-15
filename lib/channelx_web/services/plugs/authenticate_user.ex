defmodule ChannelxWeb.Services.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias ChannelxWeb.Router.Helpers

  def init(_) do
  end

  def call(conn, _) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in to continue")
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end
