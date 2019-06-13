defmodule CampWithDennis2019Web.Context do
  alias CampWithDennis2019.Registration
  alias CampWithDennis2019.Registration.Registrant
  use CampWithDennis2019Web, :controller

  @spec get_registrant(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def get_registrant(conn, _) do
    with registrant_id when not is_nil(registrant_id) <- get_session(conn, :registrant_id),
         %Registrant{} = registrant <- Registration.get_registrant(registrant_id) do
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
