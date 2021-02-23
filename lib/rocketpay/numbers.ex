defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_read_file()
  end

  defp handle_read_file({:ok, numbers}) do
    summed_numbers =
      numbers
        |> String.split(",")
        |> Stream.map(fn number -> String.to_integer(number) end)
        |> Enum.sum()

    {:ok, summed_numbers}
  end

  defp handle_read_file({:error, _reason}) do
    {:error, "Invalid filename"}
  end
end
