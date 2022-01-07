defmodule Exlivery.Users.CreateOrUpateTest do
  use ExUnit.Case
  alias Exlivery.Users.CreateOrUpate
  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent
  import Exlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      map_user = Map.from_struct(build(:user))

      response = CreateOrUpate.call(map_user)

      excepted_response = {:ok, "User created or updated sucessfully!"}

      assert response == excepted_response
    end

    test "when there are invalid params, returns an error" do
      map_user = Map.from_struct(build(:user, age: 14))

      response = CreateOrUpate.call(map_user)

      excepted_response = {:error, "Invalid parameters"}

      assert response == excepted_response
    end
  end
end
