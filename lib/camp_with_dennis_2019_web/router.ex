defmodule CampWithDennis2019Web.Router do
  use CampWithDennis2019Web, :router

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

  scope "/", CampWithDennis2019Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/register", RegistrationController, :index
    post "/register", RegistrationController, :create
  end
end
