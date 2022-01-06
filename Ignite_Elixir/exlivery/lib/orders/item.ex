defmodule Exlivery.Orders.Item do
  # Atributos de módulo @categories e @keys
  @categories [
    :pizza,
    :hamburger,
    :carne,
    :prato_feito,
    :japonesa,
    :sobremesa
  ]

  @keys [
    :description,
    :category,
    :unity_price,
    :quantity
  ]

  # Para que seja obrigatório usuário definir os valores para os elementos do @keys
  @enforce_keys @keys

  # Defina uma struct com base no keys
  defstruct @keys

  # Uma função para retornar uma struct Item desde que obedeça as condições do when
  def build(description, category, unity_price, quantity)
      when quantity > 0 and category in @categories do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  # Caso não obedeça as condições, retorna erro
  def build(_description, _category, _unity_price, _quantity), do: {:error, "Invalid parameters"}

  # Construir uma struct Item
  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  # Caso dê erro no unity_price, retorna erro
  defp build_item(:error, _description, _category, _quantity), do: {:error, "Invalid price!"}
end
