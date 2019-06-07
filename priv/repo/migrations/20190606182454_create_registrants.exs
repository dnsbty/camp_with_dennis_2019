defmodule CampWithDennis2019.Repo.Migrations.CreateRegistrants do
  use Ecto.Migration

  def change do
    create table(:registrants) do
      add :first_name, :string
      add :gender, :string
      add :last_name, :string
      add :paid_at, :naive_datetime
      add :phone_number, :string
      add :shirt_size, :string

      timestamps()
    end
  end
end
