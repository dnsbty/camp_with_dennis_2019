defmodule CampWithDennis2019.Repo.Migrations.MakePhoneNumbersUnique do
  use Ecto.Migration

  def change do
    create unique_index(:registrants, [:phone_number])
  end
end
