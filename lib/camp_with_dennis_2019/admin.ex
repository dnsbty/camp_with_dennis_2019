defmodule CampWithDennis2019.Admin do
  @moduledoc """
  Handle administrative tasks like marking users as paid and seeing RSVPs and shirt sizes.
  """

  alias CampWithDennis2019.Admin.{Login, Registrant}
  alias CampWithDennis2019.Repo

  @doc """
  Get a registrant by their ID number.

  ## Examples

      iex> get_registrant(1)
      %Registrant{}

      iex> get_registrant(2)
      nil
  """
  @spec get_registrant(integer()) :: Registrant.t() | nil
  def get_registrant(registrant_id), do: Repo.get(Registrant, registrant_id)

  @doc """
  List everyone who has registered.

  ## Examples

      iex> list_registrants()
      [%Registrant{}]
  """
  @spec list_registrants :: list(Registrant.t())
  def list_registrants do
    Repo.all(Registrant)
  end

  @doc """
  Mark a registrant as having paid.

  ## Examples

      iex> mark_registrant_as_paid(%Registrant{})
      {:ok, %Registrant{}}

      iex> mark_registrant_as_paid(%Registrant{})
      {:error, %Ecto.Changeset{}}
  """
  @spec mark_registrant_as_paid(Registrant.t()) ::
          {:ok, Registrant.t()} | {:error, Ecto.Changeset.t()}
  def mark_registrant_as_paid(registrant) do
    full_now = NaiveDateTime.utc_now()
    now = NaiveDateTime.truncate(full_now, :second)

    registrant
    |> Registrant.payment_changeset(%{paid_at: now})
    |> Repo.update()
  end

  @spec phone_changeset :: Ecto.Changeset.t()
  def phone_changeset do
    Login.phone_changeset(%{})
  end

  def send_payment_confirmation_text(registrant) do
    text =
      Enum.join(
        [
          "Hey #{registrant.first_name} 👋",
          "We got your payment, so you're officially on the list for Americamping! 🇺🇸🏕",
          "I'll send you another text the week of the trip with a packing list and other details.",
          "I'm excited to have you along 😃"
        ],
        "\n\n"
      )

    registrant
    |> Map.get(:phone_number)
    |> SignalWire.send_message(text)
  end
end
