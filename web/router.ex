defmodule Whitebox.Router do
  use Whitebox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Whitebox.Auth, repo: Whitebox.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Whitebox do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/webcams", WebcamController
    get "/", PageController, :index
  end

  scope "/auth" do
    pipe_through :browser
  end

  # Other scopes may use custom stacks.
  # scope "/api", Whitebox do
  #   pipe_through :api
  # end
end
