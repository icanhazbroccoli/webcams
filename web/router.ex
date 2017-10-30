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
    get "/", PageController, :index
  end

  scope "/dashboard", Whitebox do
    pipe_through [:browser, :authenticate_user]
    resources "/webcams", WebcamController
  end

  scope "/auth", Whitebox do
    pipe_through :browser
    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Whitebox do
  #   pipe_through :api
  # end
end
