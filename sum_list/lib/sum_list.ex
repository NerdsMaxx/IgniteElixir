defmodule SumList do
  def call(list), do: sum(list, 0)

  def call_enum(list), do: Enum.map(list, fn element -> element * 2 end)

  defp sum([], acc), do: acc

  defp sum([head | tail], acc) do
    acc = acc + head
    sum(tail, acc)
  end
end
