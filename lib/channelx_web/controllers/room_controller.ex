defmodule ChannelxWeb.RoomController do
  use ChannelxWeb, :controller
  alias Channelx.Conversation.Room
  alias Channelx.Conversation
  alias Channelx.Auth.Authorizer

  plug(ChannelxWeb.Services.Plugs.AuthenticateUser when action not in [:index])
  plug(:authorize_user when action in [:edit, :update, :delete])

  def index(conn, _) do
    rooms = Channelx.Conversation.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _) do
    changeset = Room.changeset(%Room{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    case Conversation.create_room(room_params, conn.assigns.current_user) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    changeset = Conversation.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Conversation.get_room!(id)

    case Conversation.update_room(room, room_params) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(_conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    {:ok, _} = Conversation.delete_room(room)
  end

  defp authorize_user(conn, _) do
    %{params: %{"id" => room_id}} = conn
    room = Conversation.get_room!(room_id)

    if Authorizer.can_manage?(conn.assigns.current_user, room) do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: room_path(conn, :index))
      |> halt()
    end
  end
end
