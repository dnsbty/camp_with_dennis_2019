defmodule CampWithDennis2019Web.PageController do
  use CampWithDennis2019Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
