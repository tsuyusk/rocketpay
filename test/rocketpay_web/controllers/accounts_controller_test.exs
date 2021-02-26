defmodule RocketpayWeb.AccountsControllerTest do
  alias Rocketpay.{Account,User}
  use RocketpayWeb.ConnCase

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "John Doe",
        password: "123456",
        nickname: "johndoe",
        email: "johndoe@email.com",
        age: 18
      }

      conn = put_req_header(conn, "Authorization", "Basic YmF0YXRhOmJhdGF0YQ==")

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      {:ok, conn: conn, account_id: account_id}
    end

    test "it should be able to deposit to an account", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "balance" => "50.00",
      } = response
    end

    test "it should return an error if params are invalid", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid_param"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(400)

      expected_response = %{
        "message" => "Invalid deposit value!",
      }

      assert expected_response == response
    end
  end
end
