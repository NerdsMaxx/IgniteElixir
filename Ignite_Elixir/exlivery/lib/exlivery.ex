defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpate, as: CreateOrUpateUser

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpate, as: CreateOrUpateOrder

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpateOrder, as: :call
end
