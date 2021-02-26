defmodule RocketpayWeb.FallbackController do
  use RocketpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(400)
    |> put_view(RocketpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
