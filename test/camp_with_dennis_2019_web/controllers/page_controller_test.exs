defmodule CampWithDennis2019Web.PageControllerTest do
  use CampWithDennis2019Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Americamping 2019"
  end
end
