defmodule Channelx.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Channelx.Auth.User
  alias Channelx.Conversation.Room
  alias Channelx.Conversation.Message

  schema "users" do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    field :username, :string
    has_many :rooms, Room
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_length(:username, min: 3, max: 30)
    |> validate_format(:email, ~r/\S+@\S+\.\S{1,4}+/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_format(:email, ~r/\S+@\S+\.\S{1,4}+/)
    |> validate_confirmation(:password)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 128)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
