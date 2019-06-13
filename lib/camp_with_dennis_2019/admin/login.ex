defmodule CampWithDennis2019.Admin.Login do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :phone_number, :string
    field :verification_code, :string
  end

  @doc false
  def phone_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:phone_number])
    |> validate_required([:phone_number])
  end
end
