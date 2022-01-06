defmodule Exlivery.Users.User do

  # Atributo de módulo @keys
  @keys [
    :name,
    :age,
    :cpf,
    :address,
    :email
  ]

  # Para que seja obrigatório usuário definir os valores para os elementos do @keys
  @enforce_keys @keys

  # Defina uma struct com base no keys
  defstruct @keys

  # Uma função para retornar uma struct User desde que obedeça as condições do when
  def build(name, age, cpf, address, email)
      when age >= 18 and is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       name: name,
       age: age,
       cpf: cpf,
       address: address,
       email: email
     }}
  end

  # Caso dê erro, retorna erro
  def build(_name, _age, _cpf, _address, _email), do: {:error, "Invalid parameters"}
end
