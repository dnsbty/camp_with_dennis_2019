defmodule CampWithDennis2019Web.AdminAuth do
  use CampWithDennis2019Web, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    user_token = auth_header(conn) |> IO.inspect()
    token = token() |> IO.inspect()

    if user_token == token do
      assign(conn, :authenticated, true)
    else
      conn
      |> redirect(to: "/")
      |> halt()
    end
  end

  defp auth_header(conn) do
    conn
    |> get_req_header("authorization")
    |> List.first()
  end

  defp token, do: Application.get_env(:camp_with_dennis_2019, :admin_api_token)
end
