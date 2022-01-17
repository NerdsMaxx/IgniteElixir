defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case
  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "123165489"
      user = build(:user, cpf: cpf)

      Exlivery.start_agents()
      UserAgent.save(user)

      [item1, item2] = [build(:item),
                        build(:item,
                          description: "Pizza de frango",
                          unity_price: Decimal.new("25.50"),
                          quantity: 2)]

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, return an error", %{item1: item1, item2: item2} do
      params = %{user_cpf: "00000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:error, "User not found!"} = response
    end

    test "when some items are invalid, return an error", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{user_cpf: cpf, items: [item1, %{item2 | quantity: 0}]}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid items!"} = response
    end

    test "when items are not avaliable, return an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid parameters!"} = response
    end
  end
end
