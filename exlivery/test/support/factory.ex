defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Guilherme",
      age: 22,
      cpf: "1234567890",
      address: "Setor Bueno, Praça T-23",
      email: "henrique101124@gmail.com"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperoni",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Setor Bueno, Praça T-23",
      items: [
          build(:item),
          build(:item,
            description: "Chesseburger",
            category: :hamburger,
            unity_price: Decimal.new("25.20"),
            quantity: 2
        )
      ],
      total_price: Decimal.new("85.90"),
      user_cpf: "1234567890"}
  end
end
