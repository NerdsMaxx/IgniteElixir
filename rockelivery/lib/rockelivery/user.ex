defmodule Rockelivery.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:age, :address, :cep, :cpf, :email, :password, :name]

  @update_params @required_params -- [:password]

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :cep, :address, :email, :name]}

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> do_cast_and_validate_required(params, @required_params)
    |> do_the_rest()
    |> put_password_hash()
  end

  def changeset(struct, params) do
    struct
    |> do_cast_and_validate_required(params, @update_params)
    |> do_the_rest()
  end

  defp do_cast_and_validate_required(struct, params, field) do
    struct
    |> cast(params, field)
    |> validate_required(field)
  end

  defp do_the_rest(changeset) do
    changeset
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
