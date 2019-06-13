defmodule CampWithDennis2019.Repo.Migrations.AddPhoneVerifiedAtToRegistrants do
  use Ecto.Migration

  def change do
    alter table(:registrants) do
      add :phone_verified_at, :naive_datetime
    end
  end
end
