defmodule CampWithDennis2019Web.AdminView do
  use CampWithDennis2019Web, :view

  def render("registrants.json", %{registrants: registrants}) do
    %{data: render_many(registrants, __MODULE__, "registrant.json")}
  end

  def render("registrant.json", %{admin: registrant}) do
    %{
      id: registrant.id,
      first_name: registrant.first_name,
      last_name: registrant.last_name,
      gender: registrant.gender,
      paid: !is_nil(registrant.paid_at),
      phone_number: registrant.phone_number,
      phone_verified: !is_nil(registrant.phone_verified_at),
      shirt_size: registrant.shirt_size
    }
  end
end
