defmodule Rocketpay.NumbersTest do
  use ExUnit.Case
  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "it should return the sum of numbers if the filename is valid" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, 37}

      assert response == expected_response
    end

    test "it should return an error if the filename is not valid" do
      response = Numbers.sum_from_file("numbers2")

      expected_response = {:error, "Invalid filename"}

      assert response == expected_response
    end
  end
end
