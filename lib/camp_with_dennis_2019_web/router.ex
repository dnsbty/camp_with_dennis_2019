defmodule CampWithDennis2019Web.Router do
  use CampWithDennis2019Web, :router
  import CampWithDennis2019Web.Context, only: [get_registrant: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :get_registrant
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CampWithDennis2019Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/register", RegistrationController, :index
    post "/register", RegistrationController, :create
    get "/share", RegistrationController, :share
    post "/verify-phone", RegistrationController, :verify_phone
    post "/new-verification", RegistrationController, :new_verification
  end
end
