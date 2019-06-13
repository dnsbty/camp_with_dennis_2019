defmodule CampWithDennis2019Web.Context do
  alias CampWithDennis2019.Registration
  use CampWithDennis2019Web, :controller

  @spec get_registrant(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def get_registrant(conn, _) do
    case get_session(conn, :registrant_id) do
      nil ->
        conn

      registrant_id ->
        registrant = Registration.get_registrant(registrant_id)
        assign(conn, :registrant, registrant)
    end
  end

  @spec ensure_registrant(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def ensure_registrant(conn, _) do
    case Map.get(conn.assigns, :registrant) do
      nil ->
        conn
        |> redirect(to: "/")
        |> halt()

      _ ->
        conn
    end
  end
end
