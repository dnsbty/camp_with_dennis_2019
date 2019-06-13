defmodule CampWithDennis2019.Admin.Registrant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "registrants" do
    field :first_name, :string
    field :gender, :string
    field :last_name, :string
    field :paid_at, :naive_datetime
    field :phone_verified_at, :naive_datetime
    field :shirt_size, :string
    field :inserted_at, :naive_datetime
  end

  def payment_changeset(registrant, attrs) do
    registrant
    |> cast(attrs, [:paid_at])
    |> validate_required([:paid_at])
  end
end
