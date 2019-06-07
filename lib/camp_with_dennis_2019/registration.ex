defmodule CampWithDennis2019.Registration do
  @moduledoc """
  Responsible for handling participant registration.
  """

  alias CampWithDennis2019.Registration.Registrant
  alias CampWithDennis2019.Repo

  @spec register(map()) :: {:ok, Registrant.t()} | {:error, Ecto.Changeset.t()}
  def register(attrs) do
    %Registrant{}
    |> Registrant.registration_changeset(attrs)
    |> Repo.insert()
  end
end
