defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      for _ <- 1..3, do: OrderAgent.save(build(:order))

      expected_response =
      "1234567890, pizza, 35.5, 1, hamburger, 25.20, 2, 85.90\n" <>
      "1234567890, pizza, 35.5, 1, hamburger, 25.20, 2, 85.90\n" <>
      "1234567890, pizza, 35.5, 1, hamburger, 25.20, 2, 85.90\n"

      Report.create("report_test.csv")
      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
