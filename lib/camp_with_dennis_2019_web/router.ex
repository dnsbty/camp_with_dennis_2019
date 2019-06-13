defmodule CampWithDennis2019Web.Router do
  use CampWithDennis2019Web, :router
  import CampWithDennis2019Web.Context, only: [get_registrant: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :registrant do
    plug :get_registrant
  end

  pipeline :admin do
  end

  scope "/", CampWithDennis2019Web do
    pipe_through [:browser, :registrant]

    get "/", PageController, :index
    get "/register", RegistrationController, :index
    post "/register", RegistrationController, :create
    get "/share", RegistrationController, :share
    post "/verify-phone", RegistrationController, :verify_phone
    post "/new-verification", RegistrationController, :new_verification
  end

  scope "/admin", CampWithDennis2019Web do
    pipe_through [:browser, :admin]

    get "/login", AdminController, :login
  end
end
