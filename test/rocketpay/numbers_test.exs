defmodule Rocketpay.NumbersTest do
  use ExUnit.Case
  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "If filename is valid, it returns the sum of numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, 37}

      assert response == expected_response
    end

    test "If filename is not valid, it returns an error" do
      response = Numbers.sum_from_file("numbers2")

      expected_response = {:error, "Invalid filename"}

      assert response == expected_response
    end
  end
end
