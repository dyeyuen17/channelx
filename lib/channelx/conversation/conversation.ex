defmodule Channelx.Conversation do
  alias Channelx.Repo
  alias Channelx.Conversation.Room

  def list_rooms do
    Repo.all(Room)
  end

  def create_room(attrs \\ %{}, user) do
    user
    |> Ecto.build_assoc(:rooms)
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end

  def get_room!(id) do
    Repo.get!(Room, id)
  end

  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end
end
