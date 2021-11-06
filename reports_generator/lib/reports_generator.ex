defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açai",
    "churrasco",
    "esfirra",
    "hambúrger",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), &sum_values(&1, &2))
  end

  # defp fetch_higher_cost(report), do: Enum.max_by(report, fn {_key, value} -> value end)

  defp sum_values([id, food_name, price], %{foods: foods, users: users} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    # report
    # |> Map.put(:users, users)
    # |> Map.put(:foods, foods)
    report
  end

  defp report_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{users: users, foods: foods}
  end
end
