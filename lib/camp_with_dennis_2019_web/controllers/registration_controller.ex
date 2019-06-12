defmodule CampWithDennis2019Web.RegistrationController do
  use CampWithDennis2019Web, :controller

  alias CampWithDennis2019.{
    Registration,
    SmsVerification
  }

  def index(conn, _) do
    changeset = Registration.Registrant.registration_changeset(%Registration.Registrant{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"registrant" => params}) do
    case Registration.register(params) do
      {:ok, registrant} ->
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
    case SmsVerification.verify(phone) do
      {:ok, _} ->
        render(conn, "pay.html")

      {:error, changeset} ->
        render(conn, "verify_phone.html", changeset: changeset)
    end
  end

  def share(conn, _) do
    render(conn, "share.html")
  end
end
