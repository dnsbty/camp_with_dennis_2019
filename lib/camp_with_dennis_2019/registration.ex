defmodule CampWithDennis2019.Registration do
  @moduledoc """
  Responsible for handling participant registration.
  """

  alias CampWithDennis2019.Registration.Registrant
  alias CampWithDennis2019.Repo

  @spec get_registrant(integer()) :: Registrant.t() | nil
  def get_registrant(id) do
    Repo.get(Registrant, id)
  end

  @spec register(map()) :: {:ok, Registrant.t()} | {:error, Ecto.Changeset.t()}
  def register(attrs) do
    %Registrant{}
    |> Registrant.registration_changeset(attrs)
    |> Repo.insert()
  end

  @spec mark_phone_as_verified(Registrant.t()) ::
          {:ok, Registrant.t()} | {:error, Ecto.Changeset.t()}
  def mark_phone_as_verified(registrant) do
    registrant
    |> Registrant.phone_verification_changeset()
    |> Repo.update()
  end
end
