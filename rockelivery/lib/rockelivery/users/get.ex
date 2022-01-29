defmodule Rockelivery.Users.Get do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo, User}

  # Uma solução alternativa, só com uma função
  # def by_id(id) do
  #   with {:ok, _uuid} <- UUID.cast(id),
  #        %User{} = user <- Repo.get(User, id)
  #     do
  #       {:ok, user}
  #     else
  #       :error -> {:error, %{status: :bad_request, result: "Invalid id format!"}}
  #       nil -> {:error, %{status: :not_found, result: "User not found!"}}
  #     end
  # end

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end
end
