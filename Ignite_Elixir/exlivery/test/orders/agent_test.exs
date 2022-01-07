defmodule Exlivery.Users.OrderTest do
  use ExUnit.Case
  alias Exlivery.Orders.Agent, as: OrderAgent
  import Exlivery.Factory

  describe "save/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "saves the order" do
      order = build(:order)

      response = OrderAgent.save(order)

      assert  {:ok, _uuid} = response
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "when order is found, return result" do
      {:ok, uuid} = :order
      |> build()
      |> OrderAgent.save()

      response = OrderAgent.get(uuid)

      excepted_response = {:ok,
      %Exlivery.Orders.Order{
        delivery_address: "Setor Bueno, Praça T-23",
        items: [%Exlivery.Orders.Item{
                  category: :pizza,
                  description: "Pizza de peperoni",
                  quantity: 1,
                  unity_price: Decimal.new("35.5")
                },
                %Exlivery.Orders.Item{
                  category: :hamburger,
                  description: "Chesseburger",
                  quantity: 2,
                  unity_price: Decimal.new("25.20")
                }],
         total_price: Decimal.new("85.90"),
         user_cpf: "1234567890"}}

      assert response == excepted_response
    end

    test "when order is not found, return an error" do
      # :user
      # |> build(cpf: "12356468")
      # |> UserAgent.save()

      response = OrderAgent.get("0000000000")

      excepted_response = {:error, "Order not found!"}

      assert response == excepted_response
    end
  end

  describe "get_all/0" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "return all orders" do
      order = build(:order)

      for _ <- 1..3, do: OrderAgent.save(order)

      response = OrderAgent.get_all()

      assert response
    end
  end
end
