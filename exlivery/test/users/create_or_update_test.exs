defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      response = CreateOrUpdate.call(build(:user))

      excepted_response = {:ok, "User created or updated sucessfully!"}

      assert response == excepted_response
    end

    test "when there are invalid params, returns an error" do
      response = CreateOrUpdate.call(build(:user, age: 14))

      excepted_response = {:error, "Invalid parameters!"}

      assert response == excepted_response
    end
  end
end
