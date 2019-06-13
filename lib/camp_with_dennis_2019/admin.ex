defmodule CampWithDennis2019.Admin do
  @moduledoc """
  Handle administrative tasks like marking users as paid and seeing RSVPs and shirt sizes.
  """

  alias CampWithDennis2019.Admin.Login

  @spec phone_changeset :: Ecto.Changeset.t()
  def phone_changeset do
    Login.phone_changeset(%{})
  end
end
