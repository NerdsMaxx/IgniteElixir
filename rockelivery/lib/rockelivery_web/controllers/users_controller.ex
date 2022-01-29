defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller
  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController
  import Ecto.Changeset, only: [cast: 3]

  @required_params [:id, :age, :address, :cep, :cpf, :email, :password, :name]

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params)
    do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def update(conn, %{"id" => id} = params) do
    params = convert_to_atom_key_and_delete_id(params)

    with {:ok, %User{} = user} <- Rockelivery.update_user(id, params)
    do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end

  defp convert_to_atom_key_and_delete_id(params) do
    %User{}
    |> cast(params, @required_params)
    |> Map.get(:changes)
    |> Map.delete(:id)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Rockelivery.delete_user(id)
    do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(id)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
