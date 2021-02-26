defmodule RocketpayWeb.UsersView do
  alias Rocketpay.User

  def render("create.json", %{user: %User{account: account} = user}) do
    %{
      id: user.id,
      name: user.name,
      nickname: user.nickname,
      inserted_at: user.inserted_at,
      email: user.email,
      account: %{
        id: account.id,
        balance: account.balance
      }
    }
  end
end
