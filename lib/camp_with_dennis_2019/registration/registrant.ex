defmodule CampWithDennis2019.Registration.Registrant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "registrants" do
    field :first_name, :string
    field :gender, :string
    field :last_name, :string
    field :paid_at, :naive_datetime
    field :phone_number, :string
    field :phone_verified_at, :naive_datetime
    field :shirt_size, :string

    timestamps()
  end

  @doc false
  def registration_changeset(registrant, attrs) do
    registrant
    |> cast(attrs, [:first_name, :last_name, :gender, :phone_number, :shirt_size])
    |> validate_required([:first_name, :last_name, :gender, :phone_number, :shirt_size])
    |> unique_constraint(:phone_number)
  end

  @doc false
  def phone_verification_changeset(registrant) do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    change(registrant, %{phone_verified_at: now})
  end
end
