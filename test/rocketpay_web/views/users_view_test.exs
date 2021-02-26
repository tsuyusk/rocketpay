defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.{ConnCase,UsersView}
  import Phoenix.View
  alias Rocketpay.{Account,User}

  test "renders create.json" do
    params = %{
      name: "John Doe",
      password: "123456",
      nickname: "johndoe",
      email: "johndoe@email.com",
      age: 18
    }

    {:ok, %User{} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    assert %{
      email: "johndoe@email.com"
      nickname: "johndoe"
    } = user
  end
end
