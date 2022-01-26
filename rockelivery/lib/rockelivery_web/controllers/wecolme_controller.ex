defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Welcome\n")


    # conn
    # |> put_status(:ok)
    # |> text("Welcome\nid = #{Map.get(params,"id")}")
  end
end
