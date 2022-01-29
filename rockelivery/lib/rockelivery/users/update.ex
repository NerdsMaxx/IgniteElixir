defmodule Rockelivery.Users.Update do
  import Ecto.Changeset, only: [change: 2]

  alias Ecto.UUID
  alias Rockelivery.{Error, Repo, User}

  def call(id, params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, uuid} -> update(uuid, params)
    end
  end

  defp update(id, params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> change_and_update_user(user, params)
    end
  end

  defp change_and_update_user(user, params) do
    user
    |> change(params)
    |> Repo.update()
  end


end
