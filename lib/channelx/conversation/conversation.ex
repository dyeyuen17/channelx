defmodule Channelx.Conversation do
  alias Channelx.Repo
  alias Channelx.Conversation.Room
  alias Channelx.Conversation.Message
  import Ecto.Query

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

  def create_message(user, room, attrs \\ %{}) do
    user
      |> Ecto.build_assoc(:messages, room_id: room.id)
      |> Message.changeset(attrs)
      |> Repo.insert()
  end

  def list_messages(room_id, limit \\ 15) do
    Repo.all(
    from msg in Message,
    join: user in assoc(msg, :user),
    where: msg.room_id == ^room_id,
    order_by: [desc: msg.inserted_at],
    limit: ^limit,
    select: %{content: msg.content, user: %{username: user.username}}
    )
  end
end
