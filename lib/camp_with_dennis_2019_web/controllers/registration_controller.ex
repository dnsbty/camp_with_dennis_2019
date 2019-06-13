defmodule CampWithDennis2019Web.RegistrationController do
  use CampWithDennis2019Web, :controller
  import CampWithDennis2019Web.Context, only: [ensure_registrant: 2]

  plug :ensure_registrant when action in [:share, :verify_phone]

  alias CampWithDennis2019.{
    Registration,
    SmsVerification
  }

  alias CampWithDennis2019.Registration.Registrant

  def index(conn, _) do
    changeset = Registrant.registration_changeset(%Registrant{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"registrant" => params}) do
    case Registration.register(params) do
      {:ok, registrant} ->
        conn = put_session(conn, :registrant_id, registrant.id)
        SmsVerification.send(registrant.phone_number)

        changeset =
          registrant
          |> Map.take([:phone_number])
          |> SmsVerification.verification_changeset()

        render(conn, "verify_phone.html", changeset: changeset)

      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def verify_phone(conn, %{"phone" => phone}) do
    phone = Map.put(phone, "phone_number", conn.assigns.registrant.phone_number)

    case SmsVerification.verify(phone) do
      {:ok, _} ->
        Registration.mark_phone_as_verified(conn.assigns.registrant)
        render(conn, "pay.html")

      {:error, changeset} ->
        render(conn, "verify_phone.html", changeset: changeset)
    end
  end

  def share(conn, _) do
    render(conn, "share.html")
  end
end
