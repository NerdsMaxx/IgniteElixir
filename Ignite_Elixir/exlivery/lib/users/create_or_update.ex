defmodule Exlivery.Users.CreateOrUpate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{name: name, age: age, cpf: cpf, address: address, email: email}) do
    User.build(name, age, cpf, address, email)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated sucessfully!"}
  end
  defp save_user({:error, _reason} = error), do: error
end
