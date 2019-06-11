defmodule CampWithDennis2019Web.RegistrationController do
  use CampWithDennis2019Web, :controller

  alias CampWithDennis2019.Registration

  def index(conn, _) do
    changeset = Registration.Registrant.registration_changeset(%Registration.Registrant{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"registrant" => params}) do
    case Registration.register(params) do
      {:ok, registrant} ->
        render(conn, "pay.html")

      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def share(conn, _) do
    render(conn, "share.html")
  end
end
