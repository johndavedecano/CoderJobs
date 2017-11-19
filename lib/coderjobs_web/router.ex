defmodule CoderjobsWeb.Router do
  use CoderjobsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated, handler: CoderjobsWeb.Auth.AuthHandler
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # controllers_web/controllers
  scope "/", CoderjobsWeb do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    post "/contact", PageController, :contact_post
    get "/terms", PageController, :terms

    get "/login", Auth.LoginController, :new
    post "/login", Auth.LoginController, :create
    get "/logout", Auth.LoginController, :delete

    get "/register/:code", Auth.RegisterController, :verify
    get "/register", Auth.RegisterController, :new
    post "/register", Auth.RegisterController, :create
    get "/forgot", Auth.ForgotController, :new
    post "/forgot", Auth.ForgotController, :create
    get "/reset/:code", Auth.ResetController, :new
    post "/reset/:code", Auth.ResetController, :create

    scope "/" do
      pipe_through [:login_required]
      get "/account", AccountController, :index
      put "/account", AccountController, :update
      get "/post", AccountController, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoderjobsWeb do
  #   pipe_through :api
  # end
end
