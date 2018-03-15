defmodule Channelx.Conversation.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Channelx.Auth.User
  alias Channelx.Conversation.Room

  schema "messages" do
    field(:message, :string)
    belongs_to(:user, User)
    belongs_to(:room, Room)

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
