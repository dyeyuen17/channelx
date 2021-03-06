defmodule Channelx.Conversation.Room do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rooms" do
    field :description, :string
    field :name, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 3, max: 40)
    |> validate_length(:topic, min: 5, max: 150)
  end
end
