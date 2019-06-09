defmodule CampWithDennis2019Web.RegistrationView do
  use CampWithDennis2019Web, :view

  def input_class(form, field) do
    IO.inspect(form)

    if field in Keyword.keys(form.errors) do
      "input has-error"
    else
      "input"
    end
  end
end
