defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  # Atributo de módulo @keys
  @keys [
    :user_cpf,
    :delivery_address,
    :items,
    :total_price
  ]

  # Para que seja obrigatório usuário definir os valores para os elementos do @keys
  @enforce_keys @keys

  # Defina uma struct com base no keys
  defstruct @keys

  # Construir uma struct Order
  def build(%User{cpf: cpf, address: address}, [%Item{} | _resto_dos_items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items) # calcular o preço total dos itens
     }}
  end

  # Caso dê erro, retorna erro
  def build(_user, _item), do: {:error, "Invalid parameters!"}

  # Calcular o preço total dos itens
  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), fn item, acc -> sum_prices(item, acc) end)
  end

  # Calcular a soma de preços
  defp sum_prices(%Item{unity_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
