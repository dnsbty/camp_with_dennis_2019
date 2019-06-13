defmodule CampWithDennis2019Web.AdminController do
  use CampWithDennis2019Web, :controller
  alias CampWithDennis2019.Admin

  def login(conn, _) do
    render(conn, "login.html", changeset: Admin.phone_changeset())
  end
end
