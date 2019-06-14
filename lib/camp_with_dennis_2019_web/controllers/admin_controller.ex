defmodule CampWithDennis2019Web.AdminController do
  use CampWithDennis2019Web, :controller
  alias CampWithDennis2019.Admin

  def login(conn, _) do
    render(conn, "login.html", changeset: Admin.phone_changeset())
  end

  def mark_paid(conn, %{"id" => registrant_id}) do
    with registrant
         when not is_nil(registrant) <- Admin.get_registrant(registrant_id),
         {:ok, registrant} <- Admin.mark_registrant_as_paid(registrant),
         {:ok, _sent} <- Admin.send_payment_confirmation_text(registrant) do
      json(conn, %{success: true})
    end
  end

  def registrants(conn, _) do
    registrants = Admin.list_registrants()
    render(conn, "registrants.json", registrants: registrants)
  end
end
