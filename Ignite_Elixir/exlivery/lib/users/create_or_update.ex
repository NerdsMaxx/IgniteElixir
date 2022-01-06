defmodule Exlivery.Users.CreateOrUpate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{name: name, age: age, cpf: cpf, address: address, email: email}) do
    User.build(name, age, cpf, address, email)
    |> save_user()
  end

  # state é uma struct User que está armazenado
  def get(cpf), do: Agent.get(__MODULE__, fn state -> get_user(state, cpf) end)

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
