defmodule Rocketpay.Users.CreateTest do
  alias Rocketpay.{User,Repo}
  alias Rocketpay.Users.Create
  use Rocketpay.DataCase

  describe "call/1" do
    test "it should return an user when all params are valid" do
      params = %{
        name: "John Doe",
        password: "123456",
        nickname: "johndoe",
        email: "johndoe@email.com",
        age: 18
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{nickname: "johndoe", email: "johndoe@email.com", id: ^user_id } = user
    end

    test "it should return an error there are params are invalid" do
      params = %{
        name: "John Doe",
        nickname: "johndoe",
        email: "johndoe@email.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
