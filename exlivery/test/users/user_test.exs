defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Guilherme",
          22,
          "1234567890",
          "Setor Bueno, Praça T-23",
          "henrique101124@gmail.com"
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, return an error" do
      response =
        User.build(
          "João",
          9,
          "02565659",
          "Praça T-sei lá o que",
          "henrique@hotmail.com"
        )

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
