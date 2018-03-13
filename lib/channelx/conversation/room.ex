defmodule Channelx.Conversation.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Channelx.Auth.User
  alias Channelx.Conversation.Message

  schema "rooms" do
    field :description, :string
    field :name, :string
    field :topic, :string
    belongs_to :user, User
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 3, max: 25)
    |> validate_length(:topic, min: 5, max: 153)
  end
end
