defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when user is found, return result" do
      :user
      |> build(cpf: "12356468")
      |> UserAgent.save()

      response = UserAgent.get("12356468")

      excepted_response =
        {:ok,
        %Exlivery.Users.User{
          address: "Setor Bueno, Praça T-23",
          age: 22,
          cpf: "12356468",
          email: "henrique101124@gmail.com",
          name: "Guilherme"
        }}

      assert response == excepted_response
    end

    test "when user is not found, return an error" do
      # :user
      # |> build(cpf: "12356468")
      # |> UserAgent.save()

      response = UserAgent.get("0000000000")

      excepted_response = {:error, "User not found!"}

      assert response == excepted_response
    end
  end
end
