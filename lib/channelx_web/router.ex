defmodule ChannelxWeb.Router do
  use ChannelxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChannelxWeb do
    pipe_through :browser # Use the default browser stack

    get "/", RoomController, :index
    resources "/rooms", RoomController
    resources "/sessions", SessionController, only: [:new, :create]
    delete "/sign out", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]
    
  end

end
