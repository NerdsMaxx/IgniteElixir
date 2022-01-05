defmodule Exlivery.Users.User do
  @keys [
    :name,
    :age,
    :cpf,
    :address,
    :email
  ]

  @enforce_keys @keys

  defstruct @keys

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

  def build(_name, _age, _cpf, _address, _email), do: {:error, "Invalid parameters"}
end
