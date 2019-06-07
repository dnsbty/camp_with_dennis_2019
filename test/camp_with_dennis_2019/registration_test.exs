defmodule CampWithDennis2019.RegistrationTest do
  use CampWithDennis2019.DataCase, async: true

  alias CampWithDennis2019.Registration

  @invalid_registrant %{
    first_name: "",
    last_name: "",
    gender: "",
    phone_number: "",
    shirt_size: ""
  }

  @valid_registrant %{
    first_name: "Dwayne",
    last_name: "Johnson",
    gender: "male",
    phone_number: "(801) 555-1234",
    shirt_size: "XL"
  }

  describe "register" do
    test "saves a valid registrant" do
      assert {:ok, registrant} = Registration.register(@valid_registrant)
      assert registrant.first_name == "Dwayne"
      assert registrant.last_name == "Johnson"
      assert registrant.gender == "male"
      assert registrant.phone_number == "(801) 555-1234"
      assert registrant.shirt_size == "XL"
    end

    test "fails when all fields aren't received" do
      assert {:error, _changeset} = Registration.register(@invalid_registrant)
    end
  end
end
